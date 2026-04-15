# iOSProductivity — System Architecture

```mermaid
graph TB
  subgraph "iOSProductivity — mobile"
    User["👤 User"]
    FE["SwiftUI (iOS) / Jetpack Compose (Android)"]
    BE["FastAPI\nREST API"]
    DB[("📦 PostgreSQL + CoreData / Room")]
    Infra["🐳 Docker + Fly.io"]
    User -->|HTTP| FE
    FE -->|API calls| BE
    BE -->|SQL / ORM| DB
  end
```

## Architecture Pattern: Clean

### Layers

```mermaid
graph LR
  L0["domain"]
  L1["application"]
  L2["infrastructure"]
  L3["presentation"]
  L0 --> L1
  L1 --> L2
  L2 --> L3
```

> Stack: lang=Swift / Kotlin | fe=SwiftUI (iOS) / Jetpack Compose (Android) | be=FastAPI | db=PostgreSQL + CoreData / Room | infra=Docker + Fly.io
