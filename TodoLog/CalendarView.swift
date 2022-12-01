//
//  CalendarView.swift
//  TodoLog
//
//  Created by 池田匡佑 on 2022/12/01.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.dismiss)
    private var dismiss
    
    @EnvironmentObject
    var userData: UserData
    
    var body: some View {
        DatePicker("", selection: $userData.date,
              displayedComponents: [.date]
        )
        .onChange(of: self.userData.date) { val in
            dismiss()
        }
        .datePickerStyle(GraphicalDatePickerStyle())
        .padding()
        .environment(\.locale, Locale(identifier: "ja_JP"))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(
                    action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "arrow.backward")
                            Text("戻る")
                        }
                    }
                )
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
