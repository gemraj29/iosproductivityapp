import Foundation

// MARK: - API Error

enum APIError: LocalizedError {
    case invalidURL
    case encodingFailed
    case networkError(URLError)
    case serverError(statusCode: Int, body: String)
    case decodingFailed(DecodingError)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The server URL is invalid."
        case .encodingFailed:
            return "Failed to encode the request body."
        case .networkError(let e) where e.code == .notConnectedToInternet:
            return "No internet connection. Check that the backend is running."
        case .networkError(let e) where e.code == .cannotConnectToHost:
            return "Cannot reach the server. Make sure the backend is running on port 8000."
        case .networkError(let e):
            return "Network error: \(e.localizedDescription)"
        case .serverError(let code, let body):
            return "Server returned \(code): \(body)"
        case .decodingFailed(let e):
            return "Unexpected response format: \(e.localizedDescription)"
        case .unknown(let e):
            return e.localizedDescription
        }
    }
}

// MARK: - Network Client

/// Thin URLSession wrapper. Inject via protocol for testability.
protocol NetworkClientProtocol: Sendable {
    func get<T: Decodable>(path: String) async throws -> T
    func post<Body: Encodable, Response: Decodable>(path: String, body: Body) async throws -> Response
    func put<Body: Encodable, Response: Decodable>(path: String, body: Body) async throws -> Response
    func delete<T: Decodable>(path: String) async throws -> T
}

final class NetworkClient: NetworkClientProtocol, @unchecked Sendable {

    // In the Simulator, localhost resolves to the host Mac.
    static let shared = NetworkClient(baseURL: URL(string: "http://localhost:8000")!)

    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session

        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        // Dates from the API come as "yyyy-MM-dd" strings
        decoder.dateDecodingStrategy = .formatted(NetworkClient.dateFormatter)

        encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(NetworkClient.dateFormatter)
    }

    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        f.locale = Locale(identifier: "en_US_POSIX")
        f.timeZone = TimeZone(secondsFromGMT: 0)
        return f
    }()

    // MARK: - Public API

    func get<T: Decodable>(path: String) async throws -> T {
        let request = try buildRequest(method: "GET", path: path, body: Optional<Empty>.none)
        return try await execute(request)
    }

    func post<Body: Encodable, Response: Decodable>(path: String, body: Body) async throws -> Response {
        let request = try buildRequest(method: "POST", path: path, body: body)
        return try await execute(request)
    }

    func put<Body: Encodable, Response: Decodable>(path: String, body: Body) async throws -> Response {
        let request = try buildRequest(method: "PUT", path: path, body: body)
        return try await execute(request)
    }

    func delete<T: Decodable>(path: String) async throws -> T {
        let request = try buildRequest(method: "DELETE", path: path, body: Optional<Empty>.none)
        return try await execute(request)
    }

    // MARK: - Private Helpers

    private struct Empty: Encodable {}

    private func buildRequest<Body: Encodable>(
        method: String,
        path: String,
        body: Body?
    ) throws -> URLRequest {
        guard let url = URL(string: path, relativeTo: baseURL) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let body {
            do {
                request.httpBody = try encoder.encode(body)
            } catch {
                throw APIError.encodingFailed
            }
        }
        return request
    }

    private func execute<T: Decodable>(_ request: URLRequest) async throws -> T {
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(for: request)
        } catch let urlError as URLError {
            throw APIError.networkError(urlError)
        } catch {
            throw APIError.unknown(error)
        }

        if let http = response as? HTTPURLResponse,
           !(200...299).contains(http.statusCode) {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw APIError.serverError(statusCode: http.statusCode, body: body)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            throw APIError.decodingFailed(decodingError)
        } catch {
            throw APIError.unknown(error)
        }
    }
}
