//
//  Request.swift
//  HoyaHacks-2023-College-Planner-App
//
//  Created by Justin Healey on 1/28/23.
//
 
import Foundation

class Network: ObservableObject {
    @Published var thisUser: User?
 
    init() {}
    
    func verifyUser(username: String) {
        // Set the URL
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { fatalError("Missing URL") }
        // Create Request
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"  // Set request type to POST
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type") // Set the content-type header
        let parameters = ["username": username] // Parameters used for JSON body
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // Set the request body
        } catch let error {
            print("Error creating request", error) // Handle error from above
            return
        }
        // Start task
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            // Handle error
            if let error = error {
                print("Request error: ", error)
                return
            }
            // Get server response
            guard let response = response as? HTTPURLResponse else { return }
            // If the response code is 200 (ok) continue; else return
            if response.statusCode == 200 {
                guard let data = data else { return }
                // Start decoding asyncronously
                DispatchQueue.main.async {
                    do {
                        // Decoded json from response
                        let decodedJson = try JSONDecoder().decode(User.self, from: data)
                        // Store response in this instance's user
                        self.thisUser = decodedJson
                        // Handle error
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
