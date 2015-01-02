//
//  Checklist.swift
//  Checklists
//
//  Created by Hector Enrique Gomez Morales on 12/30/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
    var name = ""
    var items = [ChecklistItem]()
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as String
        items = aDecoder.decodeObjectForKey("Items") as [ChecklistItem]
        super.init()
    }
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
    }
    
    func countUncheckedItems() -> Int {
        return reduce(items, 0) {
            cnt, item in
            return cnt + (item.checked ? 0 : 1)
        }
    }
}
