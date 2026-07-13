# Architecture Decision Record (ADR) Process

## Purpose

This document defines how Architecture Decision Records (ADRs) are created, reviewed, approved, maintained, and retired within the BAOBAB platform.

ADRs provide a permanent record of significant architectural and technical decisions, including the reasoning behind each decision and its expected consequences.

They ensure that future contributors understand not only *what* was decided, but also *why*.

---

# Objectives

The ADR process exists to:

- Document significant engineering decisions.
- Preserve architectural knowledge.
- Improve engineering transparency.
- Reduce repeated discussions.
- Support long-term maintainability.
- Provide historical context for future changes.

---

# What is an ADR?

An Architecture Decision Record is a short document describing:

- the problem,
- the available options,
- the chosen solution,
- the rationale,
- the consequences.

ADRs are immutable historical records.

If a decision changes, a new ADR supersedes the previous one.

---

# Directory Structure

```text
docs/
└── adr/
    ├── README.md
    ├── 0001-use-django.md
    ├── 0002-use-nextjs.md
    ├── 0003-use-flutter.md
    ├── 0004-use-uv.md
    ├── 0005-use-django-tenants.md
    └── ...
```

Each ADR uses sequential numbering.

Numbers are never reused.

---

# ADR Lifecycle

```text
Proposed
    ↓

Review

    ↓

Accepted

    ↓

Implemented

    ↓

Superseded (optional)

    ↓

Archived
```

---

# ADR Status Values

Every ADR must include one status.

- Proposed
- Accepted
- Superseded
- Deprecated

---

# When an ADR is Required

Create an ADR when making decisions involving:

## Architecture

- Framework selection
- Database selection
- Service architecture
- Monolith vs Microservices
- Multi-tenancy
- APIs

---

## Infrastructure

- Docker
- Kubernetes
- Cloud provider
- Networking
- Storage

---

## Engineering

- Repository structure
- Coding standards
- Testing strategy
- CI/CD architecture
- Security approach

---

## Platform

- Authentication
- Authorization
- CMS
- Search
- AI platform
- Event architecture

---

# When an ADR is NOT Required

Do not create ADRs for:

- Bug fixes
- Refactoring
- Naming changes
- Minor dependency updates
- Documentation improvements
- Routine implementation details

---

# ADR Template

Every ADR should contain:

1. Title
2. Status
3. Date
4. Context
5. Problem Statement
6. Decision Drivers
7. Considered Options
8. Decision
9. Consequences
10. Alternatives Rejected
11. References

---

# Naming Convention

```text
0001-use-django.md

0002-use-nextjs.md

0003-use-flutter.md

0004-use-uv.md

0005-use-django-tenants.md
```

Use lowercase.

Separate words with hyphens.

Use verbs where appropriate.

---

# Review Process

The workflow is:

Idea

↓

Create ADR

↓

Engineering Review

↓

Discussion

↓

Approval

↓

Merge

↓

Implementation

---

# Superseding an ADR

Never modify an Accepted ADR to represent a different decision.

Instead:

Create a new ADR.

Example

```text
0005-use-django-tenants.md

↓

superseded by

↓

0018-adopt-sharded-tenancy.md
```

The old ADR remains for historical reference.

---

# Relationship with GitHub Issues

Large architectural decisions should reference:

- GitHub Epic
- Technical Task
- Pull Request

Likewise, issues implementing an architectural decision should link back to the relevant ADR.

---

# Relationship with Sprint Planning

ADRs capture strategic engineering decisions.

Sprint tasks implement those decisions.

Roadmaps schedule the work.

Together they provide traceability from architectural intent to implementation.

---

# Repository Governance

All ADRs reside under:

docs/adr/

ADRs should be reviewed before implementation begins.

No architectural change should be implemented without either:

- an existing ADR, or
- a new ADR proposed for review.

---

# Benefits

Using ADRs allows BAOBAB to:

- preserve architectural knowledge,
- onboard new contributors more quickly,
- justify technology choices,
- improve governance,
- support long-term platform evolution.

---

# Governance

This ADR process forms part of the BAOBAB Engineering Governance.

Changes to this process should themselves be documented through an ADR and reviewed before adoption.
