//
//  String+AddText.swift
//  MyLocations
//
//  Created by Hector Enrique Gomez Morales on 2/10/15.
//  Copyright (c) 2015 Hector Enrique Gomez Morales. All rights reserved.
//

import Foundation

extension String {
    mutating func addText(text: String?, withSeparator separator: String = "") {
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text
        }
    }
}