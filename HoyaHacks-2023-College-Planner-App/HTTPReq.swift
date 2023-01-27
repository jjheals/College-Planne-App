//
//  HTTPReq.swift
//  College-Planner-App-SwiftUI
//
//  Created by Justin Healey on 1/27/23.
//

import Foundation


class HTTPReq {
    
    var username: String
    var body: Dictionary<String, String>
    
    init(username: String, body: Dictionary<String, String>) {
        self.username = username
        self.body = body
    }
    
    func sendReq(destination: String) -> [String: Any] {
        
        var json: [String: Any] = [:]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options:[])
        
        let url = URL(string: /*REPLACE WITH SERVER IP*/ "/\(destination)")
        var request = URLRequest(url: url!)
        request.setValue(/*USE USERS PASSWORD*/"", forHTTPHeaderField: "Authorization")
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = bodyData
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else { /* HANDLE ERROR */ return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            } catch {
                print(error)
            }
        }
        return json
    }
}
