# Conventions

This file contains informations on how to write acceptable code for this
project. If this prototype becomes the main version, then you should
be sure to respect such conventions if you want any PR to be accepted.

This is subject to change while still in prototype phase.

## Project Architecture

- Use reusable components, like the already implemented ShootingSystem
- Scripts should have one single responsibility (using components does not count as an additional responsibility)
- Use exports and resources for customization.
- Unexpected situations SHOULD create a crash with an adequate error message using assert()
- Use signals for inter-objects data transmission

## Naming Conventions

Class names, nodes: PascalCase
Variable, files: snake_case
Constants: SCREAMING_CASE
