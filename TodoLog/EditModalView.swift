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
    
    @State var id: UUID
    @State var title: String
    @State var memo: String
    @State var taskDateTime: Date
    @State var datePicker: Date
    @State var timePicker: Date
    @State var taskDateFlg: Bool
    @State var taskTimeFlg: Bool
    @State var isDateEditing: Bool
    @State var isTimeEditing: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                // タイトル設定
                Text("タイトル")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("タスクを入力してください", text: $title)
                    .focused($nameFieldIsForcused)
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.nameFieldIsForcused = true
                        }
                    }
                
                // メモ設定
                Text("メモ")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("メモを入力してください", text: $memo)
                
                // 日付スイッチ
                Toggle(isOn: $isDateEditing) {
                    Text("日付")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                if (self.isDateEditing) {
                    //　日付設定
                    DatePicker("", selection: $datePicker,
                          displayedComponents: [.date]
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                    // 時刻スイッチ
                    Toggle(isOn: $isTimeEditing) {
                        Text("時刻")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    if (self.isTimeEditing) {
                        //　時刻設定
                        DatePicker("", selection: $timePicker,
                              displayedComponents: [.hourAndMinute]
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .environment(\.locale, Locale(identifier: "ja_JP"))
                    }
                }
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
                    .disabled(self.title.isEmpty)
                }
            }
        }
    }
    
    // タスクの更新処理
    func updateTask() {
        // 入力チェック
        if (self.title.isEmpty) {
            return
        }

        // 検索条件設定(id指定)
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "self.id == %@", self.id as NSUUID as CVarArg)

        // タスクの更新処理
        do {
            // 更新対象のタスク情報を取得
            let result = try viewContext.fetch(fetchRequest)
            // タイトル設定
            result[0].title = self.title
            // メモ設定
            result[0].memo = self.memo
            // 日付スイッチで日付フラグを設定
            result[0].taskDateFlg = self.isDateEditing
            // 日付スイッチがtrueの場合のみ日付と時刻を設定
            if (self.isDateEditing) {
                result[0].taskDateTime = Util.concatDateAndTime(date: self.datePicker, time: self.timePicker)
                result[0].taskTimeFlg = self.isTimeEditing
            } else {
                result[0].taskTimeFlg = false
            }
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
        EditModalView(
            id: UUID()
            , title: "test title"
            , memo: "test memo"
            , taskDateTime: Date()
            , datePicker: Date()
            , timePicker: Date()
            , taskDateFlg: false
            , taskTimeFlg: false
            , isDateEditing: false
            , isTimeEditing: false
        )
    }
}
