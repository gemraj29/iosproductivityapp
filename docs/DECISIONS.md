# iOSProductivity — Architecture Decision Records

## ADR-001: Backend — FastAPI

**Status:** Accepted
**Date:** 2026-04-15

### Context
The project needs a backend API framework for domain `mobile`.

### Decision
FastAPI

### Rationale
FastAPI provides automatic OpenAPI docs, async-first design, Pydantic validation, and Python type safety. Ideal for high-performance APIs.

### Consequences
- Developers must follow the conventions defined in the DNA
- All API endpoints must be documented with OpenAPI schemas

---
## ADR-002: Database — PostgreSQL + CoreData / Room

**Status:** Accepted
**Date:** 2026-04-15

### Context
The project requires a primary data store.

### Decision
PostgreSQL + CoreData / Room

### Rationale
PostgreSQL provides ACID compliance, rich JSON support, excellent performance, and the broadest feature set of any open-source RDBMS.

---
## ADR-003: Frontend — SwiftUI (iOS) / Jetpack Compose (Android)

**Status:** Accepted
**Date:** 2026-04-15

### Context
The project requires a frontend framework.

### Decision
SwiftUI (iOS) / Jetpack Compose (Android)

### Rationale
SwiftUI (iOS) / Jetpack Compose (Android) selected for this project.
