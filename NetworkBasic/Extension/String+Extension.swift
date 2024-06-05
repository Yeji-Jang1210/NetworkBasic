//
//  String+Extension.swift
//  NetworkBasic
//
//  Created by 장예지 on 6/5/24.
//

import Foundation

extension String {
    func convertStringToDate(format: String) -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.date(from: self)
        
    }
}
