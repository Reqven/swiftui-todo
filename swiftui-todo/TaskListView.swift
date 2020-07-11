//
//  TaskListView.swift
//  swiftui-todo
//
//  Created by Reqven on 11/07/2020.
//  Copyright © 2020 Manu Marchand. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
  
  @State private var tasks = [Task]()
  @State private var isAdding = false
  
  private let title = "Tasks"
  private let titleFont = Font.system(size: 25, weight: .bold, design: .default)
  private let subtitleFont = Font.system(size: 20, weight: .regular, design: .default)
  
  private var addButton: some View {
    let size: CGFloat = 25
    let icon = self.isAdding ? "minus.circle.fill" : "plus.circle.fill"
    let image = Image(systemName: icon).resizable().frame(width: size, height: size)
    
    return Button(action: {
      self.isAdding.toggle()
    }) { image }
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        VStack {
          List {
            ForEach (self.tasks) { task in
              TaskCell(task: task) { result in
                if case .failure(_) = result {
                  self.deleteItem(task)
                }
              }.id(task.id)
            }
            .onDelete(perform: self.deleteItem)
            .onMove(perform: self.moveItem)
            
            if isAdding {
              TaskCell(task: Task()) { result in
                if case .success(let task) = result {
                  self.addItem(task)
                }
                self.isAdding.toggle()
              }.id(Task().id)
            }
          }
        }
        .navigationBarTitle(self.title)
        .navigationBarItems(leading: EditButton(), trailing: self.addButton)
        
        if self.tasks.isEmpty && !self.isAdding {
          VStack(alignment: .center) {
            Spacer().frame(height: 150)
            
            Text("No task found").font(self.titleFont)
            HStack {
              Text("Use the").font(self.subtitleFont)
              Image(systemName: "plus.circle.fill").foregroundColor(Color(.systemBlue))
              Text("button to add one").font(self.subtitleFont)
            }
            
            Spacer()
          }
        }
      }
    }
  }
  
  private func addItem(_ task: Task) {
    self.tasks.append(task)
  }
  
  private func deleteItem(_ task: Task) {
    self.tasks.removeAll { item -> Bool in
      return task.id == item.id
    }
  }
  
  private func deleteItem(at offsets: IndexSet) {
    self.tasks.remove(atOffsets: offsets)
  }
  
  private func moveItem(from source: IndexSet, destination: Int) {
    self.tasks.move(fromOffsets: source, toOffset: destination)
  }
}


struct TaskListView_Previews: PreviewProvider {
  static var previews: some View {
    TaskListView()
  }
}
