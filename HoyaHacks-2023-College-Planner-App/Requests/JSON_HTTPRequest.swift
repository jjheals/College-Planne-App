//
//  JSON_HTTPRequest.swift
//  HoyaHacks-2023-College-Planner-App
//
//  Created by Anay Gandhi on 1/27/23.
//

import Foundation
import OrderedCollections

class JSON_HTTPRequest {
    
    let url: URL
    var request: URLRequest
    let contentType: String
    let jsonBody: Codable
    
    init(url: URL, jsonBody: JSONBody) {
        self.url = url
        self.contentType = "application/json"
        self.request = URLRequest(url: self.url)
        self.jsonBody = jsonBody
    }
    
    func getConfirmation() -> Bool {
        
        return false
    }
    
    func makeRequest() -> OrderedDictionary<String, String> {
        
        var serverResponse: OrderedDictionary<String, String> = [:]
        
        // Set the request's body to JSON data type
        let encoder = JSONEncoder()
        let reqBody = try? JSONSerialization.data(withJSONObject: self.jsonBody, options: [])
        // Set request parameters
        self.request.httpMethod = "POST"
        self.request.httpBody = reqBody
        // Start session
        let session = URLSession.shared
        // Initiate task
        let task = session.dataTask(with: self.request) { (data, response, error) in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(HTTPResponse.self, from:data)
                } catch {
                    
                }
            } else {
                    // Handle unexpected error
                }
        }
        // Resume task
        task.resume()
        return serverResponse
    }
}
