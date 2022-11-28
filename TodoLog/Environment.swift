//
//  Environment.swift
//  TodoLog
//
//  Created by 池田匡佑 on 2022/11/26.
//

import SwiftUI

class UserData: ObservableObject {
    @Published var title: String = ""
    @Published var isEditing: Bool = false
    @Published var date = Date()
    @Published var isModalEdit: Bool = false
}
