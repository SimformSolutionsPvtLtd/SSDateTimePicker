//
//  String+Extension.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 12/12/23.
//

import Foundation

extension String {

    func localized(withComment comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

}
