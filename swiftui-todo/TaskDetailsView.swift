//
//  TaskDetailsView.swift
//  swiftui-todo
//
//  Created by Reqven on 11/07/2020.
//  Copyright © 2020 Manu Marchand. All rights reserved.
//

import SwiftUI

struct TaskDetailsView: View {
  
  @Binding private var task: Task
  @State private var useDate: Bool
  @State private var date: Date
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  private var datePicker: DatePicker<Text> {
    DatePicker(
      selection: Binding<Date>(
        get: { return self.date },
        set: { self.date = $0 }
      ),
      in: Date()...
    ){
      Text("Date")
    }
  }
  
  init(task: Binding<Task>) {
    self._task = task
    
    guard let taskDate = task.date.wrappedValue else {
      self._useDate = .init(initialValue: false)
      self._date = .init(initialValue: Date())
      return
    }
    self._useDate = .init(initialValue: true)
    self._date = .init(initialValue: taskDate)
  }
  
  private func updateDate() {
    let taskDate = self.useDate ? self.date : nil
    self.task.date = taskDate
  }
  
  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section(
            header: Text("Details")
          ){
            TextField("Title", text: self.$task.title)
            Toggle(isOn: self.$useDate) { Text("Remind me on a day") }
              .onReceive([self.datePicker].publisher.first()) {_ in
                self.updateDate()
              }
            if self.useDate {
              self.datePicker
            }
          }
          Section(
            header: Text("Priority")
          ){
            ForEach (TaskPriority.values, id: \.self) { priority in
              HStack {
                Text(TaskPriority.title(for: priority))
                Spacer()
                if self.task.priority == priority {
                  Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color(.systemBlue))
                }
              }
              .contentShape(Rectangle())
              .onTapGesture {
                self.task.priority = self.task.priority != priority
                  ? priority
                  : nil
              }
            }
          }
        }
        .navigationBarTitle("Details", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
          self.presentationMode.wrappedValue.dismiss()
        }){
          Text("Done")
        })
      }
    }
  }
}


struct TaskDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }
  
  struct PreviewWrapper: View {
    @State var task: Task = Task(title: "Preview", priority: TaskPriority.random())
    
    var body: some View {
      TaskDetailsView(task: self.$task)
    }
  }
}

