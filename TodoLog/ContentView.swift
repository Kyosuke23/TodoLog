//
//  ContentView.swift
//  TodoLog
//
//  Created by 池田匡佑 on 2022/11/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State
    var enable = true
    
    @EnvironmentObject
    var userData: UserData
    
    @Environment(\.managedObjectContext)
    var viewContext

    var body: some View {

        NavigationView {
            // Todoリスト部
            TaskList(date: self.userData.date)
//            .navigationTitle("Todoリスト")
            .toolbar {
                // 日付表示部
                ToolbarItem(placement: .principal) {
                    Text(Util.getStrDate(date: self.userData.date))
                }
                
                // カレンダー遷移ボタン
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "chevron.backward")
                                .disabled(true)
                            Text("Calendar")
                                .disabled(true)
                        }
                    }
                }
                
                // タスク追加ボタン
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.userData.title = ""
                        self.userData.isEditing = true
                    }) {
                        Text("+")
                            .font(.title)
                    }
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    // バックワードボタン
                    Button(action: {
                        self.moveDate(value: -1)
                    })
                    { Image(systemName: "arrow.uturn.backward") }
                    
                    Spacer()
                    
                    // Todayボタン
                    Button(action: {
                        self.userData.date = Date()
                        self.enable = true
                    })
                    { Text("Today") }
                    .disabled(enable)
                    
                    Spacer()
                    
                    // フォワードボタン
                    Button(action: {
                        self.moveDate(value: 1)
                    })
                    { Image(systemName: "arrow.uturn.forward") }
                }
            }
        }
    }
    // 日付の更新処理
    func moveDate(value: Int) {
        // 日付を更新
        self.userData.date = Calendar.current.date(byAdding: .day, value: value, to: self.userData.date)!
        // 日付が今日になればTodayボタンを非活性化
        self.enable = Calendar.current.isDate(self.userData.date, equalTo: Date(), toGranularity: .day)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
    }
}
