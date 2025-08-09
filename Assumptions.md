# Assumptions
- Existing branch `work` used since creating new branches is disallowed.
- Swift Package manifest added for testing (`swift test`).
- Exponential backoff uses base delay 0.5s with maximum 3 attempts.
- Tokens are stored only in-memory via `TokenStore`.
- Swift package renamed to `CepteBulNetworking` to avoid Xcode build conflicts.
