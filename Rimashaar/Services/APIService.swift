import Foundation

class APIService {
    private let baseURL = "https://admin-cp.rimashaar.com/api/v1/"

    private func performRequest<T: Decodable>(endpoint: String, method: String = "POST", body: (some Encodable)? = nil) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(endpoint)?lang=en") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body {
            request.httpBody = try JSONEncoder().encode(body)
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        guard !data.isEmpty else {
            throw APIError.noData
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    private func performRequest(endpoint: String, method: String = "POST", body: [String: Any]? = nil) async throws -> [String: Any] {
        guard let url = URL(string: "\(baseURL)\(endpoint)?lang=en") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        guard !data.isEmpty else {
            throw APIError.noData
        }

        do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return jsonResponse
            } else {
                throw APIError.decodingError(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON response."]))
            }
        } catch {
            throw APIError.decodingError(error)
        }
    }

    func registerUser(registrationData: RegistrationRequest) async throws -> RegistrationResponse {
        let response: RegistrationResponse = try await performRequest(endpoint: "register-new", body: registrationData)
        if !response.success {
            throw APIError.apiError(message: response.message ?? "Registration failed.", code: response.status)
        }
        return response
    }

    func verifyOtp(otp: String, userId: Int) async throws -> Bool {
        let body: [String: Any] = ["user_id": userId, "otp": otp]
        let response = try await performRequest(endpoint: "verify-code", body: body)
        return response["success"] as? Bool ?? false
    }
}
