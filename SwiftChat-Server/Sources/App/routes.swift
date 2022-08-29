import Fluent
import Vapor
import WebSocketKit
import NIO

var connections: [String: WebSocket] = [:]

func routes(_ app: Application) throws {
    
    //
    // REST API
    //
    
    // [ GET ] http://127.0.0.1:8080/
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    // [ GET ] http://127.0.0.1:8080/hello/vapor
    app.get("hello", "vapor") { req async -> String in
        print("сработало")
        return "Hello, vapor!"
    }
    
    // [ POST ] http://127.0.0.1:8080/swiftchat
    app.post("swiftchat") { r async -> String in
        print(r.url)
        print(r.headers)
        return "привет шнурки"
    }
    
    // ============== //
    // WebSockets API //
    // ============== //
    app.webSocket("chat") { r, ws in
        
        ws.send("You have connected to WebSocket")
        connections["name"] = ws // TODO get name
        
        ws.onBinary { ws, bytebuffer in
            print("connected")
        }
        
        ws.onText { ws, string in
            print(string)
            
            for (_, connection) in connections {
                connection.send(string)
            }
        }
        
        ws.onClose.whenSuccess { _ in
            print("disconnected")
        }
    }
    
    try app.register(collection: TodoController())
}
