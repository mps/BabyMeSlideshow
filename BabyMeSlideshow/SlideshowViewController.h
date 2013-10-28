//
//  SlideshowViewController.h
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/24/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GAI.h"

@interface SlideshowViewController : GAITrackedViewController

- (id)initWithPhotos:(NSMutableArray *)photoUrls;

- (IBAction)tapExit:(id)sender;

@end
