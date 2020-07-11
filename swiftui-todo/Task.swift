//
//  Task.swift
//  swiftui-todo
//
//  Created by Reqven on 11/07/2020.
//  Copyright © 2020 Manu Marchand. All rights reserved.
//

import Foundation

struct Task: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var done: Bool
    
    var image: String {
        return done
            ? "checkmark.circle.fill"
            : "circle"
    }
    
    static func createTask() -> Task {
        return Task(title: "", done: false)
    }
}

enum TaskError: Error {
    case empty
}
