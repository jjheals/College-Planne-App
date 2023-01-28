//
//  APIRequest.swift
//  HoyaHacks-2023-College-Planner-App
//
//  Created by Justin Healey on 1/28/23.
//

import Foundation

// User data structure
final class User: Codable {
    var username: String
    var verified: Bool? // Optional so JSON response does not need to include
}

// Errors
enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}


struct APIRequest {
    let resourceURL: URL
    
    init(endpoint: String) {
        let resourceString = "http://139.144.239.83:8080/\(endpoint)"
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        self.resourceURL = resourceURL
    }
    
    func verifyUser(_ username: String, completion: @escaping(Result<String, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
            
            var content: [String:String] = ["username": username]
            
            urlRequest.httpBody = try JSONEncoder().encode(content)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let
                    jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                    }
                do {
                    let content = try JSONDecoder().decode(User.self, from: jsonData)
                    completion(.failure(.decodingProblem))
                } catch {
                    completion(.failure(.encodingProblem))

                }
            }
            dataTask.resume()
            
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
}
