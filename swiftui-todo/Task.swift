//
//  Task.swift
//  swiftui-todo
//
//  Created by Reqven on 11/07/2020.
//  Copyright © 2020 Manu Marchand. All rights reserved.
//

import SwiftUI

struct Task: Identifiable {
  var id: String = UUID().uuidString
  var title: String = ""
  var done: Bool = false
  var date: Date?
  var priority: TaskPriority?
  
  var image: String {
    return done
      ? "checkmark.circle.fill"
      : "circle"
  }
}


enum TaskPriority: Int {
  case low
  case medium
  case high
  
  static func title(for priority: TaskPriority) -> String {
    switch priority {
      case .high: return "High"
      case .medium: return "Medium"
      case .low: return "Low"
    }
  }
  
  static func color(for priority: TaskPriority) -> Color {
    switch priority {
      case .high: return Color(.systemRed)
      case .medium: return Color(.systemOrange)
      case .low: return Color(.systemBlue)
    }
  }
  
  static var values: [TaskPriority] {
    return [.high, .medium, .low]
  }
  
  static func random() -> TaskPriority {
    let index = Int(arc4random_uniform(UInt32(TaskPriority.values.count)))
    return values[index]
  }
}


enum TaskError: Error {
  case empty
}
