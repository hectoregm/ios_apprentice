//
//  ChecklistItem.m
//  Checklists
//
//  Created by Hector Enrique Gomez Morales on 6/22/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import "ChecklistItem.h"

@implementation ChecklistItem

- (void)toggleChecked
{
    self.checked = !self.checked;
}

@end
