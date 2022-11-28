//
//  EditModalView.swift
//  TodoLog
//
//  Created by 池田匡佑 on 2022/11/28.
//

import SwiftUI
import CoreData

struct EditModalView: View {
    @EnvironmentObject
    var userData: UserData
    
    @FocusState
    var nameFieldIsForcused: Bool
    
    @Environment(\.managedObjectContext)
    var viewContext
    
    @State
    var id: UUID

    @State
    var title: String
    
    @State
    var memo: String
    
    var body: some View {
        NavigationView {
            VStack {
                // タイトル欄
                Text("タイトル")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("タスクを入力してください", text: $title)
                    .focused($nameFieldIsForcused)
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.nameFieldIsForcused = true
                        }
                    }
                // メモ欄
                Text("メモ")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("メモを入力してください", text: $memo)
            }
            .toolbar {
                // キャンセルボタン
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.userData.isModalEdit = false
                    }) {
                        Text("キャンセル")
                    }
                }
                // 完了ボタン
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.updateTask()
                    }) {
                        Text("保存")
                    }
                }
            }
        }
    }
    
    // タスクの更新処理
    func updateTask() {
        // id指定でタスク情報を検策
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "self.id == %@", self.id as NSUUID as CVarArg)
        
        do {
            // タスクの更新処理
            let result = try viewContext.fetch(fetchRequest)
            result[0].title = self.title
            result[0].memo = self.memo
            try viewContext.save()
        } catch {
            fatalError("データの保存に失敗しました。")
        }
        
        // モーダル画面を閉じる
        self.userData.isModalEdit = false
    }
}

struct EditModalView_Previews: PreviewProvider {
    static var previews: some View {
        EditModalView(id: UUID(), title: "test title", memo: "test memo")
    }
}
