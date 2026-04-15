# Project Architecture

This project follows a Clean Architecture approach, emphasizing separation of concerns and testability. It's structured into distinct layers, with feature slicing used to organize code by functionality.

## Layers

The architecture is divided into the following layers, from innermost to outermost:

1.  **Domain:**
    *   Contains the core business logic, entities, and use cases.
    *   Independent of any external concerns like UI, databases, or frameworks.
    *   Defines interfaces for data access and other external services.

2.  **Application:**
    *   Orchestrates the domain layer.
    *   Contains application-specific business rules and use cases.
    *   Implements interfaces defined by the domain layer.
    *   Handles data mapping between domain and infrastructure layers.

3.  **Infrastructure:**
    *   Deals with external concerns such as data persistence (PostgreSQL, CoreData/Room), network communication (FastAPI), and device-specific APIs.
    *   Implements interfaces defined by the domain and application layers.

4.  **Presentation:**
    *   Responsible for the user interface and user experience.
    *   Built using SwiftUI for iOS.
    *   Interacts with the application layer to display data and trigger actions.
    *   Independent of the infrastructure layer.

## Feature Slicing

Code is organized by feature rather than by layer. Each feature resides in its own directory, containing all the necessary components for that feature (domain, application, infrastructure, and presentation aspects) within its slice. This promotes modularity and makes it easier to understand, develop, and maintain individual features.

For example, a `TaskList` feature might have a structure like:

```
Sources/
├── Features/
│   ├── TaskList/
│   │   ├── Domain/
│   │   │   ├── Entities/
│   │   │   ├── UseCases/
│   │   │   └── Repositories/
│   │   ├── Application/
│   │   │   ├── Services/
│   │   │   └── Mappers/
│   │   ├── Infrastructure/
│   │   │   ├── DataSources/
│   │   │   └── Repositories/
│   │   └── Presentation/
│   │       ├── Views/
│   │       ├── ViewModels/
│   │       └── Components/
│   └── Calendar/
│       ├── ...
├── Core/
│   ├── ...
└── Shared/
    ├── ...
```

This approach ensures that related code is co-located, reducing cognitive load and improving maintainability. Dependencies flow inwards, meaning a feature slice can depend on lower-level layers or shared components, but not on other feature slices directly.
