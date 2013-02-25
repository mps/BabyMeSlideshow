//
//  SettingsViewController.m
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/25/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsHelper.h"

@interface SettingsViewController () {
	
}

@property (nonatomic) IBOutlet UIButton *exitButton;

@property (nonatomic) IBOutlet UILabel *photoDurationLabel;
@property (nonatomic) IBOutlet UILabel *fadeDurationLabel;

@property (nonatomic) IBOutlet UISlider *photoDurationSlider;
@property (nonatomic) IBOutlet UISlider *fadeDurationSlider;

@end

@implementation SettingsViewController

#pragma mark - UIView Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self setupSliders];
}

- (void)viewWillAppear:(BOOL)animated {
	[self initializeSettings];
}

#pragma mark - Methods

- (void)setupSliders {
	[self.photoDurationSlider addTarget:self action:@selector(photoDurationSliderChanged:) forControlEvents:UIControlEventValueChanged];
	[self.fadeDurationSlider addTarget:self action:@selector(fadeDurationSliderChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)initializeSettings {
	self.photoDurationSlider.value = [SettingsHelper getPhotoDuration];
	[self photoDurationSliderChanged:self.photoDurationSlider];
	
	self.fadeDurationSlider.value = [SettingsHelper getFadeDuration];
	[self fadeDurationSliderChanged:self.fadeDurationSlider];
}

#pragma mark - IBActions

- (IBAction)exitSettings:(id)sender {
	[SettingsHelper setPhotoDuration:self.photoDurationSlider.value];
	[SettingsHelper setFadeDuration:self.fadeDurationSlider.value];
	[self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UISlider

- (void)photoDurationSliderChanged:(UISlider *)slider {
    self.photoDurationLabel.text = [NSString stringWithFormat:@"%.1lf seconds", slider.value];
}

- (void)fadeDurationSliderChanged:(UISlider *)slider {
    self.fadeDurationLabel.text = [NSString stringWithFormat:@"%.1lf Seconds", slider.value];
}

@end
