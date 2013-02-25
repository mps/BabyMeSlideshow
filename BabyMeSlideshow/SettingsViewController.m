//
//  SettingsViewController.m
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/25/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () {
	
}

@property (nonatomic) IBOutlet UIButton *exitButton;

@end

@implementation SettingsViewController

- (IBAction)exitSettings:(id)sender {
	[self dismissViewControllerAnimated:YES completion:NULL];	
}

@end
