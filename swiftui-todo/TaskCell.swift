//
//  TaskCell.swift
//  swiftui-todo
//
//  Created by Reqven on 11/07/2020.
//  Copyright © 2020 Manu Marchand. All rights reserved.
//

import SwiftUI

struct TaskCell: View {
  @State var task: Task
  @State var isEditing = false
  @State var isShowingDetails = false
  
  var onCommit: (Result<Task, TaskError>) -> Void = { _ in }
  var hasPriority: Bool { self.task.priority != nil }
  var hasDate: Bool { self.task.date != nil }
  
  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .medium
    return formatter
  }
  
  func saveTask() -> Void {
    if !self.task.title.isEmpty {
      self.onCommit(.success(self.task))
    } else {
      self.onCommit(.failure(.empty))
    }
    self.isEditing = false
  }
  
  var body: some View {
    HStack(alignment: .top) {
      
      if self.hasPriority {
        Image(systemName: "chevron.up.circle.fill")
          .resizable()
          .frame(width: 25, height: 25)
          .foregroundColor(TaskPriority.color(for: self.task.priority!))
      }
      
      Spacer()
      VStack(alignment: .leading, spacing: 2) {
        TextField("Title", text: self.$task.title, onCommit: self.saveTask)
          .font(.headline)
          .onTapGesture { self.isEditing = true }
        
        if self.hasDate {
          Text(self.dateFormatter.string(from: self.task.date!)).font(.caption)
        }
      }
      
      if self.isEditing {
        Image(systemName: "info.circle")
          .resizable()
          .frame(width: 25, height: 25)
          .foregroundColor(Color(.systemBlue))
          .onTapGesture { self.isShowingDetails.toggle() }
          .sheet(isPresented: self.$isShowingDetails) {
            TaskDetailsView(task: self.$task)
          }
        
      } else {
        Image(systemName: task.image)
          .resizable()
          .frame(width: 25, height: 25)
          .foregroundColor(Color(.systemBlue))
          .onTapGesture { self.task.done.toggle() }
      }
    }
  }
}


struct TaskCell_Previews: PreviewProvider {
  static var previews: some View {
    TaskCell(task: Task(title: "Preview task", date: Date(), priority: TaskPriority.random()))
  }
}

