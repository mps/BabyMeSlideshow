//
//  ViewController.h
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/24/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GAI.h"

@interface ViewController : GAITrackedViewController

- (IBAction)selectPhotosForSlideshow:(id)sender;

- (IBAction)usePreviousPhotosForSlideshow:(id)sender;

- (IBAction)showAbout:(id)sender;

- (IBAction)showSettings:(id)sender;

@end
