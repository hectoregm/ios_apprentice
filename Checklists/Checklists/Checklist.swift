//
//  Checklist.swift
//  Checklists
//
//  Created by Hector Enrique Gomez Morales on 12/30/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

import UIKit

class Checklist: NSObject {
    var name = ""
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
