//
//  JSONBody.swift
//  HoyaHacks-2023-College-Planner-App
//
//  Created by Anay Gandhi on 1/28/23.
//

import Foundation

// Use in JSON_HTTPRequest
/* Usage:
    
    dataToSend = JSONBody()
    dataToSend.username = "username"
    dataToSend.assignmentName = "assignmentName"
    ...
    req = JSON_HTTPRequest([URL], dataToSend)
    req.makeRequest()
 */
struct JSONBody: Codable {
    var username: String
    var assignmentName: String?
    var subjectName: String?
    var dueDate: String?
    
    var jsonBody: Data? {
        let encoder = JSONEncoder()
        var dict: [String: String?] = [
            "username": self.username,
            "assignment-name": self.assignmentName,
            "subject-name": self.subjectName,
            "dueDate": self.dueDate
        ]
        var encodedData = try? encoder.encode(dict)
        return encodedData
    }
}
