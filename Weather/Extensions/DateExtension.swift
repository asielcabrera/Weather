//
//  DateExtension.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import Foundation

extension Date {
    
    var formattedHour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: self)
    }
    
    var formattedDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
    
}

extension String {
    func toDate(withFormat format: String = "HH:mm") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("take a look your format")
        }
        return date
    }
}
