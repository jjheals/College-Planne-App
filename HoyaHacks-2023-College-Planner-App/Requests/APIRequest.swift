////
////  APIRequest.swift
////  HoyaHacks-2023-College-Planner-App
////
////  Created by Justin Healey on 1/28/23.
////

import Foundation

// User data structure
final class User: Codable {
    var username: String
    var status: String
    
    init() {
        self.username = ""
        self.status = ""
    }
}

// Errors
enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

class APIRequest {
    let resourceURL: URL
    var thisUser: User = User()

    init(endpoint: String) {
        let resourceString = "http://139.144.239.83:8080/\(endpoint)"
        guard let resourceURL = URL(string: resourceString) else { fatalError("Unable to create URL") }
        self.resourceURL = resourceURL
    }
    
    func verifyUser(_ username: String, completion: @escaping (Result<User, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
            
            let content = ["username": username]
            
            urlRequest.httpBody = try JSONEncoder().encode(content)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                      let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                if httpResponse.statusCode != 200 {
                    completion(.failure(.responseProblem))
                    return
                }
                
                do {
                    let user = try JSONDecoder().decode(User.self, from: jsonData)
                    self.thisUser = user
                    print(user.username)
                    print(user.status)
                    completion(.success(user))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
            
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func verifyPhone(_ phone: String, id: String, completion: @escaping (Result<User, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
            
            let content = ["username": id,
                           "phone": phone
                        ]
            
            urlRequest.httpBody = try JSONEncoder().encode(content)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                      let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                if httpResponse.statusCode != 200 {
                    completion(.failure(.responseProblem))
                    return
                }
                
                do {
                    let user = try JSONDecoder().decode(User.self, from: jsonData)
                    self.thisUser = user
                    print(user.username)
                    print(user.status)
                    completion(.success(user))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
            
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func verifyCode(_ code: String, completion: @escaping (Result<User, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
            
            let content = ["code": code]
            
            urlRequest.httpBody = try JSONEncoder().encode(content)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                      let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                if httpResponse.statusCode != 200 {
                    completion(.failure(.responseProblem))
                    return
                }
                
                do {
                    let user = try JSONDecoder().decode(User.self, from: jsonData)
                    self.thisUser = user
                    print(user.username)
                    print(user.status)
                    completion(.success(user))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
            
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func verifytodo(_ subject: String, assignment: String, dueDate: String, id: String, completion: @escaping (Result<User, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
            
            let content = ["assignment-name": assignment,
                           "for-subject": subject,
                           "due-date": dueDate,
                           "username": id
                        ]
            
            urlRequest.httpBody = try JSONEncoder().encode(content)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                      let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                if httpResponse.statusCode != 200 {
                    completion(.failure(.responseProblem))
                    return
                }
                
                do {
                    let user = try JSONDecoder().decode(User.self, from: jsonData)
                    self.thisUser = user
                    print(user.username)
                    print(user.status)
                    completion(.success(user))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
            
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
}


//
//import Foundation
//
//// User data structure
//final class User: Codable {
//    var username: String
//    var verified: Bool? // Optional so JSON response does not need to include
//    var Status: String?
//}
//
//// Errors
//enum APIError: Error {
//    case responseProblem
//    case decodingProblem
//    case encodingProblem
//}
//
//
//struct APIRequest {
//    let resourceURL: URL
//
//    init(endpoint: String) {
//        let resourceString = "http://139.144.239.83:8080/\(endpoint)"
//        guard let resourceURL = URL(string: resourceString) else { fatalError() }
//        self.resourceURL = resourceURL
//    }
//
//    func verifyUser(_ username: String, completion: @escaping(Result<String, APIError>) -> Void) {
//        do {
//            var urlRequest = URLRequest(url: resourceURL)
//            urlRequest.httpMethod = "POST"
//            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
//
//            var content: [String:String] = ["username": username]
//
//            urlRequest.httpBody = try JSONEncoder().encode(content)
//
//            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
//                guard let httpResponse = response as? HTTPURLResponse, let
//                        jsonData = data else {
//                    completion(.failure(.responseProblem))
//                    return
//                    }
//                do {
//                    let content = try JSONDecoder().decode(User.self, from: jsonData)
//                    completion(.failure(.decodingProblem))
//                } catch {
//                    print(content)
//                    print("JSON DATA")
//                    print(jsonData as! String)
//                    print("DATA")
//                    print(data)
//                    completion(.failure(.encodingProblem))
//
//                }
//            }
//            dataTask.resume()
//
//        } catch {
//            completion(.failure(.encodingProblem))
//        }
//    }
//}
