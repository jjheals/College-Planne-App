//
//  APIRequest.swift
//  HoyaHacks-2023-College-Planner-App
//
//  Created by Justin Healey on 1/28/23.
//

import Foundation


final class Message: Codable {
    var id: Int?
    var message: String
    
    init(message: String) {
        self.message = message
    }
}
enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}


struct APIRequest {
    let resourceURL: URL
    
    init(endpoint: String) {
        let resourceString = "http://SERVER_IP/\(endpoint)"
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        self.resourceURL = resourceURL
    }
    
    func verifyUser(_ username:String, completion: @escaping(Result<Message, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
            urlRequest.httpBody = try JSONEncoder().encode(messageToSave)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let
                        jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let messageData = try JSONDecoder().decode(Message.self, from: jsonData)
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
}
