//
//  ViewController.m
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/24/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import "ViewController.h"
#import "WSAssetPicker.h"
#import "SettingsViewController.h"
#import "SlideshowViewController.h"
#import <AssetsLibrary/ALAsset.h>
#import "SVProgressHUD.h"

#define NEWSLIDESHOW_PRIMARY_POSITION			IS_IPHONE_5_SCREEN ? CGRectMake(360, 164, 157, 49) : CGRectMake(312, 164, 157, 49);
#define SETTINGS_PRIMARY_POSITION				IS_IPHONE_5_SCREEN ? CGRectMake(360, 220, 157, 30) : CGRectMake(312, 220, 157, 30);
#define SETTINGS_SECONDARY_POSITION				IS_IPHONE_5_SCREEN ? CGRectMake(360, 260, 157, 30) : CGRectMake(312, 260, 157, 30);

@interface ViewController ()<WSAssetPickerControllerDelegate> {
	NSArray *_selectedPhotos;
}

@property (nonatomic) IBOutlet UIButton *selectPhotosButton;
@property (nonatomic) IBOutlet UIButton *usePreviousPhotosButton;
@property (nonatomic) IBOutlet UIButton *showSettingsButton;
@property (nonatomic) WSAssetPickerController *picker;

@end

@implementation ViewController

#pragma mark - UIView Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.selectPhotosButton.frame = NEWSLIDESHOW_PRIMARY_POSITION;
	
	if ([self hasPhotos]) {
		self.usePreviousPhotosButton.hidden = NO;
		self.usePreviousPhotosButton.frame = SETTINGS_PRIMARY_POSITION;
		self.showSettingsButton.frame = SETTINGS_SECONDARY_POSITION;
	} else {
		self.usePreviousPhotosButton.hidden = YES;
		self.showSettingsButton.frame = SETTINGS_PRIMARY_POSITION;
	}
	
	self.usePreviousPhotosButton.hidden = ![self hasPhotos];
}

#pragma mark - Methods

- (BOOL)hasPhotos {
	return _selectedPhotos != nil && [_selectedPhotos count] > 0;
}

- (void)setPhotos:(NSArray *)assets {
	NSMutableArray *tmpPhotos = [[NSMutableArray alloc] init];
	
	for (ALAsset *asset in assets) {		
		ALAssetRepresentation* representation = [asset defaultRepresentation];
		
		// Retrieve the image orientation from the ALAsset
		UIImageOrientation orientation = UIImageOrientationUp;
		NSNumber* orientationValue = [asset valueForProperty:@"ALAssetPropertyOrientation"];
		if (orientationValue != nil) {
			orientation = [orientationValue intValue];
		}
		
		CGFloat scale  = 1;
		UIImage* image = [UIImage imageWithCGImage:[representation fullResolutionImage]
											 scale:scale
									   orientation:orientation];
		[tmpPhotos addObject:image];
	}
	_selectedPhotos = tmpPhotos;
}

- (void)showSlideshow {	
	SlideshowViewController *slideshow = [[SlideshowViewController alloc] initWithPhotos:[_selectedPhotos mutableCopy]];
	[self presentModalViewController:slideshow animated:YES];
}

#pragma mark - IBActions

- (IBAction)selectPhotosForSlideshow:(id)sender {
	self.picker = [[WSAssetPickerController alloc] initWithDelegate:self];
	[self presentModalViewController:self.picker animated:YES];
}

- (IBAction)usePreviousPhotosForSlideshow:(id)sender {
	if ([self hasPhotos]) {
		[self showSlideshow];
	}
}

- (IBAction)showSettings:(id)sender {
	SettingsViewController *settings = [[SettingsViewController alloc] init];
	[self presentModalViewController:settings animated:YES];
	
}

#pragma mark - WSAssetPickerControllerDelegate

- (void)assetPickerControllerDidCancel:(WSAssetPickerController *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)assetPickerController:(WSAssetPickerController *)sender didFinishPickingMediaWithAssets:(NSArray *)assets {
	if ([assets count] > 0) {
		[self showProgress];
	}
	
    // Hang on to the picker to avoid ALAssetsLibrary from being released (see note below).
    self.picker = sender;
	
    // Dismiss the WSAssetPickerController.
    __block id weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
		
		[self setPhotos:assets];
		
		if ([self hasPhotos]) {
			[self showSlideshow];
		}
		
		[self hideProgress];
		
        // Release the picker.
        [weakSelf setPicker:nil];
    }];
}

#pragma mark - SVProgressHUD

- (void)showProgress {
	[SVProgressHUD showWithStatus:@"Loading Slideshow..."];
}

- (void)hideProgress {
	[SVProgressHUD dismiss];
}

@end
