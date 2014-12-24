//
//  HudView.h
//  MyLocations
//
//  Created by Hector Enrique Gomez Morales on 6/30/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

@interface HudView : UIView

+ (instancetype)hudInView:(UIView *)view animated:(BOOL)animated;

@property (nonatomic, strong) NSString *text;

@end
