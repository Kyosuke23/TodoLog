//
//  Environment.swift
//  TodoLog
//
//  Created by 池田匡佑 on 2022/11/26.
//

import SwiftUI
import CoreData

class UserData: ObservableObject {
    // メイン画面制御
    @Published var title: String = ""
    @Published var isEditing: Bool = false
    @Published var date: Date = Date()
    @Published var isModalEdit: Bool = false
    
    // 更新モーダル画面受け渡しパラメータ
    @Published var updModalId: UUID = UUID()
    @Published var updModalTitle: String = ""
    @Published var updModalMemo: String = ""
    @Published var updModalTaskDateTime: Date = Date()
    @Published var updModalTaskDateFlg: Bool = false
    @Published var updModalTaskTimeFlg: Bool = false
}
