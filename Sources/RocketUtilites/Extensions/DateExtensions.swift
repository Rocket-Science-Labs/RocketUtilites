//
//  DateExtensions.swift
//  RocketUtilites
//
//  Created by Николай on 03.03.2020.
//

import Foundation

public extension Date {
    
    var calendar: Calendar {
        return Calendar(identifier: Calendar.current.identifier) // Workaround to segfault on corelibs foundation https://bugs.swift.org/browse/SR-10147
    }
    
    var isInToday: Bool {
        return calendar.isDateInToday(self)
    }
    
    func isPassedMoreThan(days: Int, toDate date : Date) -> Bool {
        let unitFlags: Set<Calendar.Component> = [.day]
        let deltaD = calendar.dateComponents(unitFlags, from: self, to: date).day
        return (deltaD ?? 0 > days)
    }
    
}
