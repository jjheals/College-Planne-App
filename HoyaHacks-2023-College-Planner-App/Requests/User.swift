//
//  User.swift
//  HoyaHacks-2023-College-Planner-App
//
//  Created by Justin Healey on 1/28/23.
//
  
import Foundation

struct User: Decodable {
    var username: String
    var verified: Bool? // Optional so JSON response does not need to include
}
