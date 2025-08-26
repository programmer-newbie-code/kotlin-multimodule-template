# Branch Protection Rule Configuration

This document describes the branch protection rules configured for this repository.

## Main Branch Protection

The following protections are in place for the `main` branch:

### Required Rules

- **Require a pull request before merging**
  - At least 1 approval is required before merging
  - Dismiss stale pull request approvals when new commits are pushed
  - Require review from Code Owners

- **Require status checks to pass before merging**
  - Required status checks:
    - Build and test workflow
    - Code coverage minimum threshold (70%)

- **Require conversation resolution before merging**
  - All conversations must be resolved before a PR can be merged

- **Require signed commits**
  - All commits must be signed with a verified signature

- **Require linear history**
  - Prevents merge commits, ensuring a clean, linear git history

- **Do not allow bypassing the above settings**
  - These rules apply to all contributors including administrators

## Development Branch Protection

For `dev` branches, the following protections apply:

- **Require signed commits**
- **Require status checks to pass**

## Implementation Guide for Repository Administrators

To implement these rules:

1. Go to the repository Settings
2. Navigate to "Branches"
3. Click "Add rule" or edit an existing rule
4. Configure the protections as described above
5. Save changes

These protection rules ensure code quality, maintain security through signed commits, and establish a structured
contribution workflow.
