//
//  Checklist.h
//  Checklists
//
//  Created by Hector Enrique Gomez Morales on 6/24/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, strong) NSMutableArray *items;

- (int)countUncheckedItems;

@end
