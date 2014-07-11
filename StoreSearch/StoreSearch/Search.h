//
//  Search.h
//  StoreSearch
//
//  Created by Hector Enrique Gomez Morales on 7/10/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SearchBlock)(BOOL success);

@interface Search : NSObject
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, readonly, strong) NSMutableArray *searchResults;

- (void)performSearchForText:(NSString *)text
                    category:(NSInteger)category
                  completion:(SearchBlock)block;
@end
