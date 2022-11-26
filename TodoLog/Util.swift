//
//  Util.swift
//  TodoLog
//
//  Created by 池田匡佑 on 2022/11/26.
//

import Foundation

class Util {
    
    // 引数の日付を文字列型に変換して返却
    class func getStrDate(date: Date) -> String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ja_JP")
        f.dateFormat = "yyyy/MM/dd(EEE)"
        return f.string(from: date)
    }
    
    // 時刻が0の日付を返却
    class func getZeroTimeDate(date: Date) -> NSDate {
        let calendar :NSCalendar! = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let year = Calendar.current.component(.year, from: date)
        let month = Calendar.current.component(.month, from: date)
        let day = Calendar.current.component(.day, from: date)
        let targetedDay :NSDate! = calendar.date(era: 1, year: year, month: month, day: day, hour: 0, minute: 0, second: 0, nanosecond: 0) as NSDate?
        return targetedDay
    }
}
