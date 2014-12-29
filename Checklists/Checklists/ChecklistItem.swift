//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Hector Enrique Gomez Morales on 12/27/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
    var text = ""
    var checked = false
    
    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as String
        checked = aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    func toggleChecked() {
        checked = !checked
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
}
