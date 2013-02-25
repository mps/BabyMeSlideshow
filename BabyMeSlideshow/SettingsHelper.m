//
//  SettingsHelper.m
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/25/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import "SettingsHelper.h"

#define KEY_FOR_PHOTO_DURATION @"BabyMeSlideshowPhotoDuration"
#define KEY_FOR_FADE_DURATION @"BabyMeSlideshowFadeDuration"

@implementation SettingsHelper

+ (float)getPhotoDuration {
	if ([[NSUserDefaults standardUserDefaults] objectForKey:KEY_FOR_PHOTO_DURATION] == nil) {
		return DEFAULT_PHOTO_DURATION;
	}
	
	return [[NSUserDefaults standardUserDefaults] floatForKey:KEY_FOR_PHOTO_DURATION];
}

+ (float)getFadeDuration {
	if ([[NSUserDefaults standardUserDefaults] objectForKey:KEY_FOR_FADE_DURATION] == nil) {
		return DEFAULT_FADE_DURATION;
	}
	
	return [[NSUserDefaults standardUserDefaults] floatForKey:KEY_FOR_FADE_DURATION];
}

+ (void)setPhotoDuration:(float)duration {
	[[NSUserDefaults standardUserDefaults] setFloat:duration forKey:KEY_FOR_PHOTO_DURATION];
}

+ (void)setFadeDuration:(float)duration {
	[[NSUserDefaults standardUserDefaults] setFloat:duration forKey:KEY_FOR_FADE_DURATION];
}

- (void)saveToDisk {
	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
