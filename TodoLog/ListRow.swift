//
//  ListRow.swift
//  TodoLog
//
//  Created by 池田匡佑 on 2022/11/26.
//

import SwiftUI

struct ListRow: View {
    @EnvironmentObject var userData: UserData
    let id: UUID
    @State var title: String
    @State var checked: Bool
    @State var memo: String
    @State var sheet = false
    
    var body: some View {
        HStack {
            if self.checked {
                Text("☑︎")
                Text(self.title)
                    .strikethrough()
                    .fontWeight(.ultraLight)
                    .foregroundColor(.black)
            } else {
                Text("□")
                Text(self.title)
                    .foregroundColor(.black)
            }
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(id: UUID(), title: "料理", checked: false, memo: "テストメモ")
    }
}
