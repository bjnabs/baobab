# GitHub Issues Governance

## Purpose

This document defines the standards for creating, managing, and maintaining GitHub Issues within the BAOBAB project. It establishes a consistent approach to planning, tracking, implementing, and reviewing work throughout the software development lifecycle.

All contributors should follow these standards when creating or updating GitHub Issues.

---

# Guiding Principles

GitHub Issues document the work.

GitHub Projects manage the work.

Issue templates capture the engineering details required to complete a piece of work, while GitHub Project fields provide planning and workflow metadata.

This separation ensures there is a single source of truth for project management information.

---

# Work Item Hierarchy

BAOBAB uses the following hierarchy.

```text
Phase
│
├── Sprint
│   │
│   ├── Epic
│   │    ├── Technical Task
│   │    ├── Feature
│   │    ├── Enhancement
│   │    ├── Refactor
│   │    ├── Documentation
│   │    └── Bug
│   │
│   └── Sprint Deliverables
│
└── Release
```

Every implementation issue should belong to one Epic.

---

# Naming Convention

## Epic

```text
P<Phase>-S<Sprint>: <Epic Title>
```

Examples

```text
P3-S1: Foundation & Development Environment

P3-S2: Identity & Access Management

P4-S1: Customer Management
```

---

## Technical Tasks

```text
P<Phase>-S<Sprint>-<Task Number>: <Task Title>
```

Examples

```text
P3-S1-01: Repository Skeleton

P3-S1-02: GitHub Codespaces Configuration

P3-S1-03: Dev Container Setup
```

Task numbers should always use two digits.

---

# Issue Types

| Type | Purpose |
|-------|----------|
| Epic | Large body of work delivered through multiple issues |
| Task | Technical implementation work |
| Feature | Introduces new functionality |
| Enhancement | Improves existing functionality |
| Refactor | Improves internal implementation without changing behaviour |
| Documentation | Documentation-only work |
| Bug | Corrects incorrect behaviour |

---

# GitHub Project Fields

The following information is managed exclusively by GitHub Projects.

| Field |
|---------|
| Status |
| Priority |
| Size |
| Estimate |
| Milestone |
| Assignee |

These fields must not be duplicated inside issue descriptions.

---

# Labels

Labels provide classification only.

## Status

- Backlog
- Ready
- Sprint
- In Progress
- Review
- Testing
- Done

## Priority

- High
- Medium
- Low

## Size

- XS
- S
- M
- L
- XL

## Types

- Epic
- Task
- Feature
- Enhancement
- Bug
- Refactor
- Documentation

## Areas

- Backend
- Frontend
- Infrastructure
- DevOps
- Database
- API
- CMS
- Commerce
- Payments
- Analytics
- Security
- AI
- UI/UX

---

# Technical Task Standard

Every Technical Task should follow the approved template.

The sections appear in the following order.

1. Parent Epic
2. Summary
3. Background
4. Objectives
5. Scope
6. Acceptance Criteria
7. Implementation Checklist
8. Verification Checklist
9. Dependencies
10. Definition of Done
11. References

---

# Epic Standard

Every Epic should include:

1. Summary
2. Business Value
3. Objectives
4. Scope
5. Out of Scope
6. Deliverables
7. Child Issues
8. Success Criteria
9. Risks & Dependencies
10. Additional Notes

---

# Checklist Guidelines

## Implementation Checklist

Describes the engineering activities required to complete the work.

Examples include:

- Creating files
- Writing code
- Configuring infrastructure
- Updating documentation
- Adding tests

---

## Verification Checklist

Describes how completed work is validated.

Examples include:

- Builds successfully
- Tests pass
- Documentation renders correctly
- Pull request reviewed
- No linting errors

---

# Definition of Done

An issue may only be moved to **Done** when:

- All Acceptance Criteria have been satisfied.
- All Implementation Checklist items are complete.
- All Verification Checklist items are complete.
- Documentation has been updated where required.
- Code review has been completed.
- CI/CD checks have passed.
- The issue has been approved for completion.

---

# Dependencies

Dependencies should clearly identify:

## Depends On

Work that must be completed first.

## Blocks

Work that cannot begin until the current issue is complete.

---

# References

Issues should reference relevant project resources whenever applicable.

Examples include:

- Architecture documentation
- ADRs
- Engineering standards
- Related issues
- Pull requests
- External specifications

---

# Governance

This document forms part of the BAOBAB Engineering Governance.

Changes to these standards should be made through pull requests and reviewed before adoption to ensure consistency across the project.
