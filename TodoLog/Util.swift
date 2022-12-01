//
//  Util.swift
//  TodoLog
//
//  Created by 池田匡佑 on 2022/11/26.
//

import Foundation

class Util {
    
    // 引数の日付を文字列型に変換して返却
    class func dateToString(date: Date, format: String) -> String {
        let f: DateFormatter = DateFormatter()
        f.locale = Locale(identifier: "ja_JP")
        f.dateFormat = format
        return f.string(from: date)
    }
    
    // 引数の日付と時刻を結合して返却
    class func concatDateAndTime(date: Date, time: Date) -> Date {
        let strDate = self.dateToString(date: date, format: "yyyy/MM/dd")
        let strTime = self.dateToString(date: time, format: "HH:mm:ss")
        let strDateTime = strDate + " " + strTime
        let f: DateFormatter = DateFormatter()
        f.locale = Locale(identifier: "ja_JP")
        f.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let result = f.date(from: strDateTime)
        return result!
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
