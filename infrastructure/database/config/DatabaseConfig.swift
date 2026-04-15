import Foundation

/// Protocol defining the requirements for a database configuration.
protocol DatabaseConfig {
    /// The name of the database.
    var databaseName: String { get }

    /// The host of the database.
    var host: String { get }

    /// The port of the database.
    var port: Int { get }

    /// The username for database authentication.
    var username: String { get }

    /// The password for database authentication.
    var password: String { get }
}

/// Configuration for a PostgreSQL database.
struct PostgreSQLConfig: DatabaseConfig {
    let databaseName: String
    let host: String
    let port: Int
    let username: String
    let password: String

    /// Initializes a new PostgreSQL configuration.
    ///
    /// - Parameters:
    ///   - databaseName: The name of the database.
    ///   - host: The host of the database.
    ///   - port: The port of the database.
    ///   - username: The username for database authentication.
    ///   - password: The password for database authentication.
    init(databaseName: String, host: String, port: Int, username: String, password: String) {
        self.databaseName = databaseName
        self.host = host
        self.port = port
        self.username = username
        self.password = password
    }
}

// Note: CoreData/Room configuration would typically involve
// CoreData stack setup or Room database builder instantiation,
// which are more complex and often tied to specific frameworks
// (e.g., CoreData in iOS, Room in Android).
// For this scaffold, we'll represent a conceptual configuration.

/// Placeholder for CoreData/Room database configuration.
/// In a real application, this would be more detailed and framework-specific.
struct LocalDatabaseConfig {
    let databaseName: String
    let modelName: String // For CoreData
    let migrationVersion: String // For Room/CoreData

    /// Initializes a new local database configuration.
    ///
    /// - Parameters:
    ///   - databaseName: The name of the local database file.
    ///   - modelName: The name of the CoreData model.
    ///   - migrationVersion: The version for database migrations.
    init(databaseName: String, modelName: String, migrationVersion: String) {
        self.databaseName = databaseName
        self.modelName = modelName
        self.migrationVersion = migrationVersion
    }
}
