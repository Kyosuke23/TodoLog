//
//  TaskList.swift
//  TodoLog
//
//  Created by 池田匡佑 on 2022/11/26.
//

import SwiftUI

struct TaskList: View {
    var fetchRequest: FetchRequest<Task>
    var tasks: FetchedResults<Task> { fetchRequest.wrappedValue }
    
    @Environment(\.managedObjectContext)
    var viewContext
    
    @EnvironmentObject
    var userData: UserData
    
    init(date: Date) {
        // 表示日付の時刻を0に変換
        let zeroDate = Util.getZeroTimeDate(date: date)
        // 抽出条件
        let predicate = NSPredicate(
            format: "self.createdAt between {%@ , %@}",
            zeroDate,
            NSDate(timeInterval: 24 * 60 * 60 - 1, since: zeroDate as Date)
        )
        // ソート条件
        let sortDescriptors = [NSSortDescriptor(keyPath: \Task.createdAt, ascending: true)]
        // フェッチインスタンスを定義
        self.fetchRequest = FetchRequest<Task>(
            entity: Task.entity(),
            sortDescriptors: sortDescriptors,
            predicate: predicate,
            animation: .default
        )
    }
    
    
    var body: some View {
        List {
            ForEach(self.tasks) { task in
                Button(action: {
                    self.checkTask(task: task)
                    print(task)
                })
                {
//                    ListRow(id: task.id!, title: task.title!, checked: task.checked, memo: task.memo!)
                    HStack {
                        if (task.checked) {
                            Text("☑︎")
                            Text(task.title!)
                                .strikethrough()
                                .fontWeight(.ultraLight)
                                .foregroundColor(.black)
                        } else {
                            Text("□")
                            Text(task.title!)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Button(action: {
                            self.userData.isModalEdit = true
                        })
                        {
                            Image(systemName: "chevron.right")
                        }
                    }
                    .sheet(isPresented: $userData.isModalEdit) {
                        EditModalView(id: task.id!, title: task.title!, memo: task.memo!)
                    }
                }
            }.onDelete(perform: deleteTask)

            if (self.userData.isEditing) {
                Draft()
            }
        }
    }
    
    // タスクチェック時の処理
    func checkTask(task: Task) {
        // チェック状態を切り替える
        task.checked.toggle()
        // タスクの保存処理
        do {
            try viewContext.save()
        } catch {
            fatalError("データの保存に失敗しました。")
        }
    }
    
    // タスクの削除処理
    func deleteTask(offsets: IndexSet) {
        // オフセット指定でタスクを削除
        offsets.forEach({ viewContext.delete(tasks[$0]) })
        // タスクの保存処理
        do {
            try viewContext.save()
        } catch {
            fatalError("データの保存に失敗しました。")
        }
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList(date: Date())
    }
}

