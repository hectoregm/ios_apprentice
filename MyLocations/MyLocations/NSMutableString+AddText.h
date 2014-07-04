//
//  NSMutableString+AddText.h
//  MyLocations
//
//  Created by Hector Enrique Gomez Morales on 7/3/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (AddText)

- (void)addText:(NSString *)text withSeparator:(NSString *)separator;

@end
