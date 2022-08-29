//
//  File.swift
//  
//
//  Created by Admin on 22.08.2022.
//

import Vapor

class ChatRoom {
    var connections: [String: WebSocket]
    
    init() {
        connections = [:]
    }
    
    func send(name: String, message: String) {
       
        for (_, socket) in connections {
            socket.send(message)
            
        }
//        guard let json = try? JSON(node: message) else {
//            return
//        }
//        
//        
        
        
    }
    
}
