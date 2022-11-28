//
//  Draft.swift
//  TodoLog
//
//  Created by 池田匡佑 on 2022/11/26.
//

import SwiftUI

struct Draft: View {

    @FocusState
    var nameFieldIsForcused: Bool
    
    @Environment(\.managedObjectContext)
    var viewContext
    
    @EnvironmentObject
    var userData: UserData
    
    var body: some View {
        TextField("タスクを入力してください", text: $userData.title, onCommit: { addTask() })
            .focused($nameFieldIsForcused)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.nameFieldIsForcused = true
                }
            }
    }
    
    // タスクの追加処理
    func addTask() {
        //　編集フラグを初期化
        self.userData.isEditing = false
        
        // 入力チェック
        if (self.userData.title.isEmpty) {
            return
        }
        
        // タスク情報を設定
        let newTask = Task(context: viewContext)
        newTask.id = UUID()
        newTask.title = self.userData.title
        newTask.memo = ""
        newTask.checked = false
        newTask.createdAt = Date()
        
        // タスクの保存処理
        do {
            try viewContext.save()
        } catch {
            fatalError("データの保存に失敗しました。")
        }
    }
}

struct Draft_Previews: PreviewProvider {
    static var previews: some View {
        Draft()
    }
}
