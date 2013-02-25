//
//  SlideshowViewController.m
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/24/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import "SlideshowViewController.h"

@interface SlideshowViewController () <UIAlertViewDelegate> {
	NSArray *_photos;
}

@property (nonatomic) IBOutlet UIImageView *photoView;
@property (nonatomic) IBOutlet UIButton *exitButton;

@end

@implementation SlideshowViewController

- (id)initWithPhotos:(NSArray *)photos {
	if (self = [super init]) {
		_photos = photos;
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.photoView.image = [_photos objectAtIndex:0];
}

- (IBAction)exitSlideshow:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exit" message:@"Are you sure you want to exit this slideshow?" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Exit", nil];
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[self dismissViewControllerAnimated:YES completion:NULL];		
	}
}

@end
