# iOSProductivity — Architecture

## Overview

**Build a mobile iOS productivity app. Follow the design files in the stitch folder for all views — maintain the same design identity, colours, spacing, and assets.**

| Property | Value |
|----------|-------|
| Domain | mobile |
| Pattern | Clean Architecture |
| Feature-based | Yes |
| Created | 2026-04-15 |

## Tech Stack

| Tier | Technology |
|------|-----------|
| Language | Swift / Kotlin |
| Frontend | SwiftUI (iOS) / Jetpack Compose (Android) |
| Backend | FastAPI |
| Database | PostgreSQL + CoreData / Room |
| Infra | Docker + Fly.io |
| Testing | XCTest / JUnit5 |
| Auth | JWT |

## Code Conventions

```
CONVENTIONS:
  functions=camelCase  classes=PascalCase
  files=PascalCase  constants=camelCase
  errors=throws  logging=structured
  docs=markup  tests=XCTest
  line_len<=120
```

## Architecture Layers

| Layer | Description | Forbidden Imports |
|-------|-------------|-------------------|
| `domain` | Pure business logic — no frameworks, no I/O | `fastapi, sqlalchemy, redis` |
| `application` | Use-case orchestration — calls domain, ports outward | `fastapi, sqlalchemy` |
| `infrastructure` | Adapters: DB, HTTP clients, message brokers | `—` |
| `presentation` | API routes, serialisation, auth middleware | `—` |

## Folder Structure

```
iosproductivity/
├── .codedna/                    # Agent state (DNA, context cards, checkpoints)
│   ├── dna.json                 # Project identity — single source of truth
│   ├── context/                 # Module context cards (~200 tokens each)
│   ├── tasks/                   # Task DAG and plan
│   └── checkpoints/             # Resume points
├── src/
│   ├── core/                    # Shared config, DB, logging, auth middleware
│   └── features/                # Vertical feature slices
│       ├── <feature>/
│       │   ├── domain/          # Pure business logic — no framework imports
│       │   ├── application/     # Use-case orchestration
│       │   ├── infrastructure/  # DB repos, HTTP clients, adapters
│       │   └── presentation/    # API routes, serialisation
├── tests/
├── docs/
│   ├── ARCHITECTURE.md
│   ├── MODULES.md
│   ├── API.md
│   ├── DECISIONS.md
│   └── flowcharts/              # Mermaid diagrams (auto-generated)
├── docker-compose.yml
├── Makefile
└── CODEDNA.md                   # Project summary + resume instructions
```

## Design Principles

1. **DNA-first** — All identity lives in `.codedna/dna.json`, never in LLM memory
2. **Context cards** — Modules are known by their ~200-token card; full source only when editing
3. **Atomic tasks** — Every unit of work ≤ 500 LOC, always checkpointed
4. **Quality gates** — Naming, import rules, size limits enforced before every file write
5. **Git as truth** — Every task = conventional commit; history is the audit trail
