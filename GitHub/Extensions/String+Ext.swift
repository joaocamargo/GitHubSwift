//
//  String+Ext.swift
//  GitHub
//
//  Created by joao camargo on 07/09/21.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.converToMonthYearFormat()
    }
}
