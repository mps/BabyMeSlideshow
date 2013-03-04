//
//  AboutViewController.m
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 3/3/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (nonatomic) IBOutlet UIButton *exitButton;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)exitAbout:(id)sender {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

@end
