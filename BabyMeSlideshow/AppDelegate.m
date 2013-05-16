//
//  AppDelegate.m
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 2/24/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UIImage+iPhone5.h"
#import <Crashlytics/Crashlytics.h>
#import "Appirater.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[Appirater setAppId:@"649351064"]; // iPad
	} else {
		[Appirater setAppId:@"612532871"];
	}
	
	[Appirater setUsesUntilPrompt:10];
    
	[Crashlytics startWithAPIKey:@"907acff10b7b639198aadbeb5eca1950ffbfb149"];
	
	[self applyStyleSheet];
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	self.viewController = [[ViewController alloc] init];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
	
	[Appirater appLaunched:YES];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	
	[Appirater appEnteredForeground:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applyStyleSheet {
	UIImage *minImage = [UIImage tallImageNamed:@"ipad-slider-fill"];
    UIImage *maxImage = [UIImage tallImageNamed:@"ipad-slider-track.png"];
    UIImage *thumbImage = [UIImage tallImageNamed:@"ipad-slider-handle.png"];
    
    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateHighlighted];
}

@end
