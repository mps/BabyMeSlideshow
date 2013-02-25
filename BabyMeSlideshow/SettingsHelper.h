//
//  SettingsHelper.h
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/25/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsHelper : NSObject

+ (float)getPhotoDuration;
+ (float)getFadeDuration;
+ (void)setPhotoDuration:(float)duration;
+ (void)setFadeDuration:(float)duration;
- (void)saveToDisk;

@end
