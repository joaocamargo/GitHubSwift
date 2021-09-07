//
//  Date+Ext.swift
//  GitHub
//
//  Created by joao camargo on 07/09/21.
//

import Foundation

extension Date {
    func converToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
