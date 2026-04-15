# iOSProductivity (mobile) v0.1.0

## Project Overview

iOSProductivity is a mobile application designed to enhance user productivity on iOS devices. It integrates task management, focus modes, and performance analytics into a seamless and intuitive user experience. The app adheres strictly to the design specifications provided in the Stitch design files, ensuring a consistent and polished visual identity.

## Technology Stack

*   **Language:** Swift
*   **Frontend:** SwiftUI
*   **Backend:** FastAPI
*   **Database:** PostgreSQL + CoreData
*   **Infrastructure:** Docker, Fly.io

## Design Principles

*   **Primary Color:** `#00334d`
*   **Secondary Color:** `#53606b`
*   **Background Color:** `#f7f9fc`
*   **Surface Color:** `#f7f9fc`
*   **Font:** Inter, sans-serif
*   **Corner Radius:** `0.25rem`
*   **Spacing:** `4px`

## Setup Instructions

### Prerequisites

*   Xcode 14.0 or later
*   Swift 5.7 or later
*   Docker (for backend and database setup)

### Local Development Setup

1.  **Clone the Repository:**
    ```bash
    git clone <repository_url>
    cd iOSProductivity
    ```

2.  **Backend Setup:**
    The backend is built with FastAPI and uses PostgreSQL. For local development, Docker Compose is recommended.
    *   Navigate to the backend directory:
        ```bash
        cd backend
        ```
    *   Build and start the backend services:
        ```bash
        docker-compose up --build
        ```
    *   The API should be accessible at `http://localhost:8000`. Refer to the backend's `README.md` for detailed API documentation.

3.  **iOS Application Setup:**
    *   Open the `iOSProductivity.xcodeproj` file in Xcode.
    *   Ensure your Xcode project is configured to use the correct Swift version and build settings.
    *   Connect an iOS device or select a simulator.
    *   Build and run the application:
        *   Select the `iOSProductivity` scheme.
        *   Click the Run button in Xcode.

### Environment Variables

Certain configurations might require environment variables. Please refer to the respective module's documentation for specific requirements.

## Project Structure

The project follows a Clean Architecture pattern with distinct layers:

*   **Domain:** Core business logic and entities.
*   **Application:** Use cases and application-specific logic.
*   **Infrastructure:** Data sources, network clients, and external services.
*   **Presentation:** SwiftUI views and UI logic.

Feature slices are implemented to maintain modularity.

## Contributing

Please refer to the `CONTRIBUTING.md` file for guidelines on how to contribute to this project.

## License

This project is licensed under the MIT License - see the `LICENSE` file for details.
