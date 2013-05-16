//
//  SlideshowViewController.m
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/24/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import "SlideshowViewController.h"
#import "SettingsHelper.h"
#import <AssetsLibrary/ALAsset.h>
#import "WSPickerWithToolbar.h"

#define EXIT_BUTTON_POSITION	IS_IPHONE_5_SCREEN ? CGRectMake(460, 20, 30, 30) : CGRectMake(400, 20, 30, 30);
#define EXIT_MESSAGE_POSITION	IS_IPHONE_5_SCREEN ? CGRectMake(192, 21, 184, 28) : CGRectMake(148, 21, 184, 28);

@interface SlideshowViewController () <UIAlertViewDelegate> {
	NSMutableArray *_photoUrls;
    NSTimer *timer;
    NSTimer *exitLabelTimer;
    int currentImageUrlIndex;
    BOOL exitLabelTapped;
}

@property (nonatomic) IBOutlet UIImageView *photoView;
@property (nonatomic) IBOutlet UIImageView *exitView;
@property (nonatomic) IBOutlet UIButton *exitButton;

@end

@implementation SlideshowViewController

- (id)initWithPhotos:(NSMutableArray *)photoUrls {
	if (self = [super init]) {
		_photoUrls = photoUrls;
	}
	return self;
}

#pragma mark - UIView Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [longPress setMinimumPressDuration:2];
    [self.exitButton addGestureRecognizer:longPress];
	
	self.photoView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {    
		self.exitButton.frame = EXIT_BUTTON_POSITION;
		self.exitView.frame = EXIT_MESSAGE_POSITION;
	}
    
    self.exitView.hidden = YES;
	
	[self setImageForUrl:[_photoUrls objectAtIndex:currentImageUrlIndex]];
	[self startTimer];
}

#pragma mark - Methods

- (void)setImageForUrl:(NSURL *)imageUrl {
	ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
			self.photoView.image = [UIImage imageWithCGImage:iref];
        }
    };
	
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"cannot load image - %@",[myerror localizedDescription]);
    };
	
	ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
	[assetslibrary assetForURL:imageUrl
				   resultBlock:resultblock
				  failureBlock:failureblock];
}

- (void)startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:[SettingsHelper getPhotoDuration]
                                             target:self
                                           selector:@selector(handleTimer:)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)handleTimer:(NSTimer *)timer {
    currentImageUrlIndex++;
    if ( currentImageUrlIndex >= _photoUrls.count )
        currentImageUrlIndex = 0;
	
	[UIView transitionWithView:self.view
					  duration:[SettingsHelper getFadeDuration]
					   options:UIViewAnimationOptionTransitionCrossDissolve
					animations:^{
						[self setImageForUrl:[_photoUrls objectAtIndex:currentImageUrlIndex]];
					} completion:NULL];
}

- (void)startExitLabelTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:2.5
                                             target:self
                                           selector:@selector(handleLabelExitTimer:)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)handleLabelExitTimer:(NSTimer *)timer {
    self.exitView.hidden = YES;
    exitLabelTapped = NO;
}

- (void)longPress:(UILongPressGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
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

#pragma mark - IBActions

- (IBAction)tapExit:(id)sender {
    if (exitLabelTapped) return;
    
    exitLabelTapped = YES;
    self.exitView.hidden = NO;
    
    [self startExitLabelTimer];
}

@end
