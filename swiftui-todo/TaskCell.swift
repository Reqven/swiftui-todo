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
    var onCommit: (Result<Task, TaskError>) -> Void = { _ in }
  
    var body: some View {
        HStack {
            TextField("Title", text: self.$task.title, onCommit: {
                if !self.task.title.isEmpty {
                    self.onCommit(.success(self.task))
                } else {
                    self.onCommit(.failure(.empty))
                }
            })
            Spacer()
            Image(systemName: task.image)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color(.systemBlue))
                .onTapGesture {
                    self.task.done.toggle()
                }
        }
    }
}
