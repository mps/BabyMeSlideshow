//
//  SlideshowViewController.m
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/24/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import "SlideshowViewController.h"
#import "SettingsHelper.h"

@interface SlideshowViewController () <UIAlertViewDelegate> {
	NSMutableArray *_photos;
    NSTimer *timer;
    int currentImage;
}

@property (nonatomic) IBOutlet UIImageView *photoView;
@property (nonatomic) IBOutlet UIButton *exitButton;

@end

@implementation SlideshowViewController

- (id)initWithPhotos:(NSMutableArray *)photos {
	if (self = [super init]) {
		_photos = photos;
	}
	return self;
}

#pragma mark - UIView Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [longPress setMinimumPressDuration:3];
    [self.exitButton addGestureRecognizer:longPress];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self setImage:[_photos objectAtIndex:currentImage]];
	[self startTimer];
}

//- (BOOL)shouldAutorotate {
//    if (([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeLeft) ||
//        ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeRight))
//        return YES;
//    
//    return NO;
//}
//
//- (NSUInteger)supportedInterfaceOrientations {
//    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
//    if ((orientation == UIInterfaceOrientationLandscapeLeft) ||
//        (orientation == UIInterfaceOrientationLandscapeRight))
//        return YES;
//    
//    return NO;
//}

#pragma mark - Methods

- (void)setImage:(UIImage *)image {
	self.photoView.image = image;
}

- (void)startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:[SettingsHelper getPhotoDuration]
                                             target:self
                                           selector:@selector(handleTimer:)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)handleTimer:(NSTimer *)timer {
    currentImage++;
    if ( currentImage >= _photos.count )
        currentImage = 0;
	
	UIImage * toImage = [_photos objectAtIndex:currentImage];
	[UIView transitionWithView:self.view
					  duration:[SettingsHelper getFadeDuration]
					   options:UIViewAnimationOptionTransitionCrossDissolve
					animations:^{
						[self setImage:toImage];
					} completion:NULL];
}

- (void)longPress:(UILongPressGestureRecognizer*)gesture {
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exit" message:@"Are you sure you want to exit this slideshow?" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Exit", nil];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[self dismissViewControllerAnimated:YES completion:NULL];		
	}
}

@end
