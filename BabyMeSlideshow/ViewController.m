//
//  ViewController.m
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/24/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import "ViewController.h"
#import "WSAssetPicker.h"
#import "SlideshowViewController.h"
#import <AssetsLibrary/ALAsset.h>

@interface ViewController ()<WSAssetPickerControllerDelegate> {
	NSArray *_selectedPhotos;
}

@property (nonatomic) IBOutlet UIButton *selectPhotosButton;
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
	
	if ([self hasPhotos]) {
		// enable start slideshow w/ previous photos.
	}
}

#pragma mark - Methods

- (BOOL)hasPhotos {
	return _selectedPhotos != nil && [_selectedPhotos count] > 0;
}

#pragma mark - IBActions

- (IBAction)selectPhotosForSlideshow:(id)sender {
	self.picker = [[WSAssetPickerController alloc] initWithDelegate:self];
	[self presentModalViewController:self.picker animated:YES];
}

#pragma mark - WSAssetPickerControllerDelegate

- (void)assetPickerControllerDidCancel:(WSAssetPickerController *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)assetPickerController:(WSAssetPickerController *)sender didFinishPickingMediaWithAssets:(NSArray *)assets {
    // Hang on to the picker to avoid ALAssetsLibrary from being released (see note below).
    self.picker = sender;
	
    // Dismiss the WSAssetPickerController.
    __block id weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
		
        // Do something with the assets here.
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
												 scale:scale orientation:orientation];
			[tmpPhotos addObject:image];
		}
		_selectedPhotos = tmpPhotos;
		
		if ([self hasPhotos]) {		
			SlideshowViewController *slideshow = [[SlideshowViewController alloc] initWithPhotos:[_selectedPhotos mutableCopy]];
			[self presentModalViewController:slideshow animated:YES];
		}
		
        // Release the picker.
        [weakSelf setPicker:nil];
    }];
}


@end
