//
//  SlideshowViewController.m
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/24/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import "SlideshowViewController.h"

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
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self setImage:[_photos objectAtIndex:currentImage]];
	[self startTimer];
}

#pragma mark - Methods

- (void)setImage:(UIImage *)image {
	self.photoView.image = image;
}

- (void)startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:DEFAULT_PHOTO_DURATION // TODO: allow user to set this timer
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
					  duration:DEFAULT_FADE_DURATION
					   options:UIViewAnimationOptionTransitionCrossDissolve
					animations:^{
						[self setImage:toImage];
					} completion:NULL];
}

#pragma mark - IBActions

- (IBAction)exitSlideshow:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exit" message:@"Are you sure you want to exit this slideshow?" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Exit", nil];
	[alert show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[self dismissViewControllerAnimated:YES completion:NULL];		
	}
}

@end
