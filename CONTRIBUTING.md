# Contributing to BAOBAB

> **Strong Roots. Inspired Growth.**

First and foremost, thank you for your interest in contributing to BAOBAB.

Whether you are fixing a bug, improving documentation, proposing an architectural enhancement, developing a new feature, strengthening security, or sharing ideas, your contribution helps make BAOBAB a stronger, more reliable, and more sustainable enterprise software platform.

We believe successful open-source software is built through collaboration, professionalism, and shared responsibility. Every contribution—large or small—is valued when it aligns with the project's engineering standards and long-term vision.

---

# Purpose

This document provides guidance for anyone wishing to contribute to BAOBAB.

Its objectives are to:

- Explain the project's engineering principles and contribution process.
- Provide a consistent workflow for contributors.
- Promote high standards of software quality.
- Encourage respectful and constructive collaboration.
- Maintain the long-term sustainability of the platform.

This document should be read alongside the following repository documents:

- `README.md`
- `CODE_OF_CONDUCT.md`
- `SECURITY.md`
- `docs/Coding-Standards.md`
- `docs/Testing-Standards.md`
- `docs/Documentation-Standards.md`

---

# Contributor Promise

Every contribution matters.

Whether you contribute code, documentation, architecture, testing, design, infrastructure, translations, or ideas, you are helping to build software that may eventually support organisations, businesses, governments, and communities.

In return, BAOBAB is committed to fostering a collaborative environment where contributions are reviewed fairly, feedback is constructive, and learning is encouraged.

We ask every contributor to approach discussions with professionalism, curiosity, and mutual respect.

---

# Engineering Philosophy

BAOBAB is guided by a set of engineering values that influence every architectural and development decision.

## Build for the Long Term

We prioritise maintainability over short-term convenience. Software should remain understandable, adaptable, and reliable as the platform evolves.

## Security by Default

Security is everyone's responsibility. Contributors should consider security implications during design, implementation, testing, and review.

## Documentation is Part of the Product

Well-written documentation is not optional. Every meaningful change should be accompanied by documentation updates where appropriate.

## Quality Before Speed

We value thoughtful engineering over rapid delivery. A well-designed, well-tested solution is preferred to a rushed implementation.

## Small, Focused Contributions

Smaller Pull Requests are easier to understand, review, test, and maintain. Whenever possible, contributions should address a single concern.

## Automation Improves Reliability

Routine quality checks should be automated wherever practical through continuous integration, automated testing, linting, formatting, dependency management, and security scanning.

## Continuous Learning

BAOBAB embraces continuous improvement. Constructive feedback, knowledge sharing, mentoring, and technical discussions help strengthen both the platform and its contributors.

---

# Code of Conduct

All contributors are expected to follow the project's `CODE_OF_CONDUCT.md`.

We are committed to maintaining a professional, respectful, and inclusive community where technical discussions remain constructive and focused on improving the platform.

Harassment, discrimination, abusive behaviour, or personal attacks will not be tolerated.

---

# Ways to Contribute

Contributions extend far beyond writing source code.

Examples include:

## Software Development

- New platform features
- Bug fixes
- Performance improvements
- Refactoring
- API enhancements

## Documentation

- README improvements
- Architecture documentation
- Tutorials
- User guides
- API documentation
- Examples

## Quality Assurance

- Unit tests
- Integration tests
- Performance testing
- Security testing
- Bug reporting

## Artificial Intelligence

- Prompt engineering
- Agent development
- RAG improvements
- Evaluation datasets
- AI workflows

## Infrastructure & DevOps

- GitHub Actions
- Docker
- Kubernetes
- Terraform
- AWS infrastructure
- Monitoring
- Deployment automation

## Security

- Vulnerability identification
- Secure coding improvements
- Dependency management
- Threat modelling
- Security documentation

## User Experience

- Accessibility improvements
- Interface design
- User research
- Workflow improvements

## Community

- Answering questions
- Reviewing Pull Requests
- Improving discussions
- Mentoring contributors
- Sharing knowledge

Every meaningful contribution is appreciated.

---

# Before You Start

Before making your first contribution, please take time to familiarise yourself with the project.

We recommend completing the following steps:

1. Read the `README.md`.
2. Review the Enterprise Architecture documentation.
3. Read this contribution guide in full.
4. Read the Coding Standards.
5. Read the Testing Standards.
6. Read the Documentation Standards.
7. Review open Issues before beginning new work.
8. Confirm that your intended contribution does not duplicate existing work.

Understanding the platform architecture before writing code will lead to better design decisions and smoother code reviews.

---

# Choosing a Contribution

If you are unsure where to begin, consider one of the following:

- Resolve a documented bug.
- Improve project documentation.
- Increase automated test coverage.
- Refactor an existing component.
- Improve performance.
- Address a security enhancement.
- Improve accessibility.
- Propose an architectural improvement.
- Develop a new feature from the project roadmap.

For larger changes, we encourage opening a GitHub Discussion or Issue before implementation to ensure alignment with the project's direction.

---
---

# Development Environment

BAOBAB provides a consistent and reproducible development experience across all supported services. Contributors are encouraged to use the project's recommended tooling to minimise environmental differences and simplify collaboration.

## Recommended Development Environment

The preferred development environments are:

- Docker Dev Containers
- GitHub Codespaces

These environments are preconfigured to provide:

- Required programming languages
- Development dependencies
- Code quality tools
- Testing frameworks
- Git utilities
- Consistent runtime environments

Using the recommended environments helps ensure that software behaves consistently across development, testing, and continuous integration.

---

# Repository Workflow

Every contribution follows a structured engineering workflow.

```text
Identify Work Item
        │
        ▼
Discuss (if required)
        │
        ▼
Create Issue
        │
        ▼
Create Feature Branch
        │
        ▼
Develop Solution
        │
        ▼
Run Local Quality Checks
        │
        ▼
Update Documentation
        │
        ▼
Commit Changes
        │
        ▼
Open Pull Request
        │
        ▼
Automated CI Validation
        │
        ▼
Code Review
        │
        ▼
Merge
```

This workflow promotes quality, traceability, and effective collaboration.

---

# Branching Strategy

BAOBAB uses a feature-based branching model.

| Branch | Purpose |
|---------|----------|
| `main` | Stable production-ready code. |
| `develop` *(optional)* | Integration branch for ongoing development where adopted. |
| `feature/*` | New features and enhancements. |
| `bugfix/*` | Non-critical defect corrections. |
| `hotfix/*` | Urgent fixes for production issues. |
| `release/*` | Release preparation and stabilisation. |
| `docs/*` | Documentation-only changes. |
| `chore/*` | Maintenance tasks and repository housekeeping. |

### Branch Naming

Branch names should clearly describe the work being undertaken.

Examples:

```text
feature/tenant-authentication

feature/document-management

bugfix/login-timeout

hotfix/security-patch

docs/api-guide

chore/dependency-update
```

Keep branch names concise, descriptive, and lowercase using hyphens where appropriate.

---

# Selecting Work

Before beginning work:

- Search existing GitHub Issues.
- Confirm that work is not already in progress.
- For significant features or architectural changes, open a Discussion or Issue before implementation.
- Agree on the proposed direction before investing substantial development effort.

Good communication reduces duplicate work and improves collaboration.

---

# Development Workflow

When implementing a contribution, contributors should generally follow this sequence:

1. Synchronise with the latest changes from the default branch.
2. Create a dedicated feature branch.
3. Implement the proposed change.
4. Add or update automated tests.
5. Update documentation where applicable.
6. Execute local quality checks.
7. Commit logically grouped changes.
8. Push the branch to GitHub.
9. Open a Pull Request.

Avoid combining unrelated changes into a single Pull Request.

---

# Commit Message Convention

Meaningful commit messages improve traceability, simplify reviews, and make project history easier to understand.

BAOBAB follows the Conventional Commits specification.

## Format

```text
type(scope): short description
```

Examples:

```text
feat(authentication): implement tenant login

fix(api): resolve pagination bug

docs(readme): update installation guide

test(ai): improve prompt evaluation coverage

refactor(worker): simplify task scheduling

chore(dependencies): update project libraries
```

### Common Commit Types

| Type | Purpose |
|------|---------|
| `feat` | New functionality |
| `fix` | Bug fixes |
| `docs` | Documentation |
| `test` | Tests |
| `refactor` | Internal improvements without behaviour changes |
| `perf` | Performance improvements |
| `build` | Build system changes |
| `ci` | Continuous Integration updates |
| `chore` | Repository maintenance |
| `style` | Formatting changes with no functional impact |

Commit messages should:

- Be concise.
- Use the imperative mood.
- Describe *what* changed.
- Avoid unnecessary detail in the subject line.

---

# Working Across Services

BAOBAB is organised as a service-oriented platform.

Whenever practical:

- Keep changes isolated to the relevant service.
- Avoid introducing unnecessary dependencies between services.
- Maintain clearly defined interfaces.
- Use shared contracts rather than duplicating data models.
- Preserve loose coupling between platform components.

Changes affecting multiple services should be carefully documented within the Pull Request.

---

# Working with Shared Components

The `shared/` directory contains reusable platform assets.

Examples include:

- API contracts
- Event definitions
- Shared schemas
- Data transfer objects
- Common utilities
- Platform constants
- Localisation resources

Before creating new shared assets:

- Verify that similar functionality does not already exist.
- Consider the impact on dependent services.
- Maintain backwards compatibility wherever practical.
- Document interface changes.

---

# Keeping Your Branch Current

Long-running branches increase the likelihood of merge conflicts.

Contributors should:

- Synchronise frequently with the default branch.
- Resolve conflicts early.
- Keep Pull Requests focused.
- Avoid large batches of unrelated changes.

Smaller, incremental contributions are generally easier to review and merge.

---

# Engineering Expectations

Every contribution should reflect the engineering values of the project.

Contributors are expected to:

- Write clean, maintainable code.
- Follow established engineering standards.
- Design for long-term maintainability.
- Prioritise security.
- Consider performance where appropriate.
- Maintain backwards compatibility whenever practical.
- Document significant architectural decisions.
- Seek feedback early when uncertain.

Remember that every contribution becomes part of a long-lived enterprise platform.

---

# Asking for Guidance

Questions are encouraged.

If you are uncertain about:

- architecture,
- implementation,
- coding standards,
- testing,
- documentation,
- security,
- or design decisions,

please ask before investing significant effort.

Early discussion often results in better technical outcomes and reduces unnecessary rework.

---

---

# Pull Request Process

Every contribution to BAOBAB is integrated through a Pull Request (PR). Pull Requests provide an opportunity to validate code quality, verify compliance with engineering standards, encourage collaborative discussion, and preserve the long-term maintainability of the platform.

Contributors should open Pull Requests as early as practical. Early review often identifies architectural concerns before significant implementation effort has been invested.

---

# Before Opening a Pull Request

Before creating a Pull Request, ensure that you have:

- Synced your branch with the latest changes.
- Completed the planned implementation.
- Added or updated automated tests.
- Updated documentation where appropriate.
- Executed all required quality checks.
- Reviewed your own changes.
- Removed debugging code and temporary files.
- Verified that no sensitive information has been committed.

A Pull Request should represent a complete, coherent piece of work.

---

# Pull Request Title

Pull Request titles should clearly describe the contribution.

Examples:

```text
Add tenant authentication service

Improve API pagination performance

Implement AI evaluation framework

Update enterprise architecture documentation
```

Avoid vague titles such as:

```text
Changes

Updates

Fixes

Miscellaneous improvements
```

---

# Pull Request Description

A good Pull Request explains both **what** changed and **why** the change was necessary.

Where appropriate, include:

- Background
- Objective
- Summary of changes
- Screenshots (UI changes)
- Testing performed
- Related Issues
- Breaking changes
- Migration considerations
- Additional notes for reviewers

Well-written Pull Requests significantly improve review quality.

---

# Definition of Ready

Before implementation begins, work should be sufficiently understood.

A task is considered **Ready** when:

- The objective is clearly defined.
- The expected outcome is understood.
- Requirements are sufficiently documented.
- Dependencies have been identified.
- Acceptance criteria are agreed.
- Major architectural questions have been resolved.

Starting development before work is ready often leads to unnecessary rework.

---

# Definition of Done

A contribution is considered complete only when all applicable requirements have been satisfied.

A contribution is **Done** when:

- Implementation is complete.
- Code follows the project's engineering standards.
- Automated tests pass.
- Documentation has been updated.
- Security considerations have been addressed.
- Code has been reviewed.
- Continuous Integration checks have passed.
- Reviewer feedback has been incorporated.
- The Pull Request is approved.

Completion is determined by quality—not merely by writing code.

---

# Code Review

Every Pull Request undergoes peer review before it can be merged.

Code reviews aim to improve:

- Correctness
- Maintainability
- Security
- Readability
- Performance
- Architectural consistency
- Knowledge sharing

Reviews should remain respectful, constructive, and focused on improving the software.

---

# Reviewer Responsibilities

Reviewers are expected to:

- Understand the proposed change.
- Evaluate architectural consistency.
- Verify compliance with engineering standards.
- Consider security implications.
- Review automated test coverage.
- Confirm documentation updates.
- Provide constructive feedback.
- Approve only when satisfied that the contribution meets project expectations.

Reviews should improve software—not discourage contributors.

---

# Responding to Review Feedback

Feedback is a normal and valuable part of collaborative software development.

When responding to review comments:

- Remain professional.
- Ask questions when clarification is needed.
- Discuss technical alternatives respectfully.
- Avoid taking feedback personally.
- Update the Pull Request promptly where appropriate.

The objective is always to improve the platform.

---

# Testing Expectations

Every contribution should include appropriate testing.

Depending on the nature of the change, testing may include:

- Unit testing
- Integration testing
- API testing
- Tenant isolation testing
- End-to-end testing
- Performance testing
- Security testing
- Regression testing

Testing requirements are described in detail within:

`docs/Testing-Standards.md`

---

# Documentation Expectations

Documentation should evolve alongside the source code.

Contributors should update documentation whenever changes affect:

- Platform architecture
- Public APIs
- Configuration
- Installation
- Deployment
- User workflows
- Developer workflows
- Operational procedures

Documentation is considered part of the deliverable—not an optional afterthought.

Detailed guidance is available in:

`docs/Documentation-Standards.md`

---

# Engineering Standards

Every contribution is expected to comply with the project's engineering standards.

These standards include:

- Coding conventions
- Naming conventions
- Architectural principles
- Error handling
- Logging
- Dependency management
- Security practices
- Performance considerations

Refer to:

`docs/Coding-Standards.md`

for the complete standards.

---

# Security Expectations

Security is a shared responsibility.

Contributors should:

- Protect confidential information.
- Avoid introducing unnecessary dependencies.
- Validate all external inputs.
- Apply the principle of least privilege.
- Protect authentication and authorisation mechanisms.
- Avoid committing secrets or credentials.
- Report vulnerabilities responsibly.

Potential vulnerabilities should be reported using the process described in:

`SECURITY.md`

They should **not** be disclosed publicly before appropriate investigation.

---

# Continuous Integration

Every Pull Request is automatically validated using GitHub Actions.

Depending on the services affected, automated validation may include:

- Code formatting
- Static analysis
- Linting
- Dependency auditing
- Unit testing
- Integration testing
- Security scanning
- Build verification
- Documentation validation

A Pull Request should not be merged while required checks are failing.

---

# Pull Request Checklist

Before requesting review, confirm that:

- [ ] The contribution addresses a single logical concern.
- [ ] Code follows the project's engineering standards.
- [ ] Automated tests have been added or updated.
- [ ] Existing tests continue to pass.
- [ ] Documentation has been updated where necessary.
- [ ] No secrets or sensitive information have been committed.
- [ ] Continuous Integration checks pass locally where applicable.
- [ ] Commit history is clean and meaningful.
- [ ] Reviewer comments have been addressed.
- [ ] The contribution satisfies the Definition of Done.

---

# Merge Strategy

To maintain a clean and understandable project history:

- Pull Requests should be reviewed before merging.
- Merge conflicts should be resolved before approval.
- Commits may be squashed where appropriate.
- Large unrelated changes should be separated into multiple Pull Requests.
- Every merge should preserve repository quality and traceability.

Maintaining a high-quality Git history benefits both current and future contributors.

---

---

# Communication

Open, respectful, and constructive communication is essential to the success of BAOBAB.

We encourage contributors to:

- Ask questions when uncertain.
- Share ideas and suggestions.
- Propose architectural improvements.
- Report bugs responsibly.
- Participate in technical discussions.
- Help other contributors.
- Share knowledge and lessons learned.

Healthy technical discussions strengthen both the platform and the engineering community.

---

# Community Expectations

BAOBAB values collaboration built on professionalism, integrity, and mutual respect.

Every contributor is expected to:

- Treat others with courtesy and respect.
- Welcome constructive feedback.
- Respect differing technical viewpoints.
- Focus discussions on technical merit.
- Encourage learning and knowledge sharing.
- Support an inclusive and collaborative environment.

All community interactions are governed by the project's `CODE_OF_CONDUCT.md`.

---

# Recognition

Every meaningful contribution deserves recognition.

Contributions may include:

- Software development
- Documentation
- Architecture
- Security improvements
- Artificial Intelligence
- Testing
- Infrastructure
- Performance optimisation
- User experience
- Translation
- Community support
- Code review
- Knowledge sharing

The value of a contribution is measured by its positive impact on the project—not by the number of lines of code written.

---

# Governance

BAOBAB is governed through documented engineering standards, transparent decision-making, and collaborative review.

Project governance is supported by the following repository documents:

| Document | Purpose |
|----------|---------|
| `README.md` | Project overview and architecture. |
| `CONTRIBUTING.md` | Contribution workflow and engineering practices. |
| `CODE_OF_CONDUCT.md` | Community standards and expected behaviour. |
| `SECURITY.md` | Responsible vulnerability disclosure and security policy. |
| `CHANGELOG.md` | Project release history. |
| `docs/Coding-Standards.md` | Coding conventions and engineering standards. |
| `docs/Testing-Standards.md` | Testing strategy and quality expectations. |
| `docs/Documentation-Standards.md` | Documentation principles and style guide. |

Together, these documents establish the governance framework that guides the evolution of BAOBAB.

---

# Questions and Support

If you need assistance before or during your contribution:

- Review the project documentation.
- Search existing Issues and Discussions.
- Open a new Discussion for design or architectural questions.
- Open an Issue for confirmed bugs or feature requests.
- Ask for clarification before making significant architectural changes.

Seeking guidance early is encouraged and often leads to better technical outcomes.

---

# First Contribution Guide

If this is your first contribution to BAOBAB, the following workflow is recommended.

```text
Read the README
        │
        ▼
Read CONTRIBUTING.md
        │
        ▼
Set Up Development Environment
        │
        ▼
Choose an Issue
        │
        ▼
Create a Feature Branch
        │
        ▼
Implement the Change
        │
        ▼
Run Quality Checks
        │
        ▼
Update Documentation
        │
        ▼
Commit Changes
        │
        ▼
Open a Pull Request
        │
        ▼
Participate in Code Review
        │
        ▼
Contribution Merged
```

Every experienced contributor began with a first contribution. We welcome yours.

---

# Contributor Journey

Contributing to BAOBAB is an ongoing cycle of learning, collaboration, and continuous improvement.

```text
        Learn
          │
          ▼
       Discuss
          │
          ▼
       Design
          │
          ▼
      Implement
          │
          ▼
         Test
          │
          ▼
      Document
          │
          ▼
        Review
          │
          ▼
        Merge
          │
          ▼
        Improve
          │
          └───────────────────────┐
                                  │
                                  ▼
                              Learn Again
```

This cycle reflects BAOBAB's belief that great software is built through continuous refinement, shared knowledge, and thoughtful collaboration.

---

# Contributor Checklist

Before considering your contribution complete, confirm that you have:

- [ ] Read the `README.md`.
- [ ] Followed this contribution guide.
- [ ] Complied with the `CODE_OF_CONDUCT.md`.
- [ ] Followed the engineering standards.
- [ ] Added or updated automated tests where required.
- [ ] Updated documentation where necessary.
- [ ] Considered security implications.
- [ ] Verified that quality checks pass.
- [ ] Responded to review feedback.
- [ ] Satisfied the Definition of Done.

Completing this checklist helps maintain the quality, consistency, and long-term sustainability of BAOBAB.

---

# Thank You

Thank you for contributing to BAOBAB.

Whether your contribution is a single documentation improvement, a complex architectural enhancement, a security recommendation, or a new platform capability, your effort helps strengthen a platform intended to support organisations and communities through reliable, secure, and sustainable software.

We appreciate your time, your expertise, and your commitment to excellence.

Together, we are building more than software—we are building an engineering community founded on collaboration, professionalism, and continuous learning.

---

<div align="center">

## Strong Roots. Inspired Growth.

**Thank you for helping BAOBAB grow stronger with every contribution.**

</div>
