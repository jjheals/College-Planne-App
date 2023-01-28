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
        print("VERIFY USER CALL \(username)")
        // Set the URL
        guard let url = URL(string: "http://139.144.239.83/verify") else { fatalError("Missing URL") }
        // Create Request
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"  // Set request type to POST
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type") // Set the content-type header
        let parameters = ["username": username] // Parameters used for JSON body
        print("PARAMETERS \(parameters)")
        urlRequest.timeoutInterval = 20
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
                DispatchQueue.main.sync {
                    do {
                        // Decoded json from response
                        let decodedJson = try JSONDecoder().decode(User.self, from: data)
                        // Store response in this instance's user and set verified to true 
                        self.thisUser = decodedJson
                        self.thisUser?.verified = true
                        // Handle error
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    
    /* Create a new user */
    func createUser(username: String) throws {
        // Set the URL
        guard let url = URL(string: "http://139.144.239.83/create-user") else { fatalError("Missing URL") }
        // Create Request
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"  // Set request type to POST
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type") // Set the content-type header
        let parameters = ["username": username] // Parameters used for JSON body
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // Set the request body
        } catch let error {
            print("Error creating request", error) // Handle error from above
            throw error // Throw error
        }
        // Start task
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            // Handle error
            if let error = error {
                print("Request error: ", error)
            }
            // Get server response
            //guard let response = response as? HTTPURLResponse else { return }
            guard let data = data else { return }
            // Start decoding syncronously
            DispatchQueue.main.sync {
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
        dataTask.resume()
    }
}
