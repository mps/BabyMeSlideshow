//
//  ViewController.m
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/24/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import "ViewController.h"
#import "WSAssetPicker.h"
#import "WSPickerWithToolbar.h"
#import "AboutViewController.h"
#import "SettingsViewController.h"
#import "SlideshowViewController.h"
#import <AssetsLibrary/ALAsset.h>
#import "SVProgressHUD.h"
#import "WSAssetWrapper.h"

#define NEWSLIDESHOW_PRIMARY_POSITION	IS_IPHONE_5_SCREEN ? CGRectMake(90, 140, 123, 123) : CGRectMake(47, 140, 123, 123);
#define USEPREVIOUS_PRIMARY_POSITION	IS_IPHONE_5_SCREEN ? CGRectMake(354, 140, 123, 123) : CGRectMake(311, 140, 123, 123);
#define SETTINGS_PRIMARY_POSITION		IS_IPHONE_5_SCREEN ? CGRectMake(248, 166, 71, 71) : CGRectMake(205, 166, 71, 71);
#define ABOUT_PRIMARY_POSITION          IS_IPHONE_5_SCREEN ? CGRectMake(540, 270, 18, 19)  : CGRectMake(420, 270, 18, 19);

@interface ViewController ()<WSAssetPickerControllerDelegate> {
	NSArray *_selectedPhotos;
}

@property (nonatomic) IBOutlet UIButton *selectPhotosButton;
@property (nonatomic) IBOutlet UIButton *usePreviousPhotosButton;
@property (nonatomic) IBOutlet UIButton *showSettingsButton;
@property (nonatomic) IBOutlet UIButton *aboutButton;
@property (nonatomic) IBOutlet UIImageView *backgroundImage;
@property (nonatomic) WSAssetPickerController *picker;

@end

@implementation ViewController

#pragma mark - UIView Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!IS_IPHONE_5_SCREEN) {
        self.backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home"]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.selectPhotosButton.frame = NEWSLIDESHOW_PRIMARY_POSITION;
    self.showSettingsButton.frame = SETTINGS_PRIMARY_POSITION;
	
	if ([self hasPhotos]) {
		self.usePreviousPhotosButton.hidden = NO;
		self.usePreviousPhotosButton.frame = USEPREVIOUS_PRIMARY_POSITION;
	} else {
		self.usePreviousPhotosButton.hidden = YES;
	}
	
	self.usePreviousPhotosButton.hidden = ![self hasPhotos];
    
    self.aboutButton.frame = ABOUT_PRIMARY_POSITION;
}

#pragma mark - Methods

- (BOOL)hasPhotos {
	return _selectedPhotos != nil && [_selectedPhotos count] > 0;
}

- (void)setPhotos:(NSArray *)assets {
	NSMutableArray *tmpPhotos = [[NSMutableArray alloc] init];
    
    for (ALAsset *asset in assets) {
        ALAssetRepresentation *rep = [asset defaultRepresentation];		
		[tmpPhotos addObject:[rep url]];
    }
	_selectedPhotos = tmpPhotos;
}

- (void)showSlideshow {	
	SlideshowViewController *slideshow = [[SlideshowViewController alloc] initWithPhotos:[_selectedPhotos mutableCopy]];
	[self presentViewController:slideshow animated:YES completion:nil];
}

#pragma mark - IBActions

- (IBAction)selectPhotosForSlideshow:(id)sender {
	self.picker = [[WSPickerWithToolbar alloc] initWithDelegate:self];
	[self presentViewController:self.picker animated:YES completion:nil];
}

- (IBAction)usePreviousPhotosForSlideshow:(id)sender {
	if ([self hasPhotos]) {
		[self showSlideshow];
	}
}

- (IBAction)showAbout:(id)sender {
	AboutViewController *about = [[AboutViewController alloc] init];
	[self presentViewController:about animated:YES completion:nil];
}

- (IBAction)showSettings:(id)sender {
	SettingsViewController *settings = [[SettingsViewController alloc] init];
	[self presentViewController:settings animated:YES completion:nil];
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
