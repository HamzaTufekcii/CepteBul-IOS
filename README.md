# CepteBul Networking

## Configuration
- **Base URL:** `http://localhost:8080` (development). Use `APIClient(baseURL:)` to change, e.g., `https://api.ceptebul.com` for production.
- **Authentication:** Bearer JWT. `APIClient` attaches tokens from `TokenStore` automatically.

## Token Handling
1. Perform `login` to obtain tokens. `AuthService` stores them via `TokenStore`.
2. Tokens refresh automatically on `401` responses. Manual refresh available through `AuthService.refresh`.

## Example Usage
```swift
let tokenStore = TokenStore()
let client = APIClient(tokenStore: tokenStore)
let authService = AuthService(client: client, tokenStore: tokenStore)

let auth = try await authService.login(AuthRequest(email: "user@example.com", password: "pass"))
print(auth.user.name)

let businessService = BusinessService(client: client)
let businesses = try await businessService.listBusinesses()
```
