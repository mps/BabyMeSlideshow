//
//  UIImage+iPhone5.m
//  BabyMeSlideshow
//
//  Created by Matthew Strickland on 3/2/13.
//  Copyright (c) 2013 Idle Fusion. All rights reserved.
//

#import "UIImage+iPhone5.h"

@implementation UIImage (iPhone5)

+ (BOOL)isTall {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone
        && [UIScreen mainScreen].bounds.size.height == 568)
    {
        return YES;
    }
    return NO;
}

+ (UIImage *)tallImageNamed:(NSString *)name {
    
    UIImage *image;
    if ([self isTall]) {
        NSString *fileName = [[[NSFileManager defaultManager] displayNameAtPath:name] stringByDeletingPathExtension];
        NSString *extension = [name pathExtension];
        
        NSString *nameTall = [NSString stringWithFormat:@"%@-568h", fileName];
        if (extension) {
            nameTall = [nameTall stringByAppendingFormat:@".%@", extension];
        }
        image = [UIImage imageNamed:nameTall];
    }
    
    if (!image) {
        image = [UIImage imageNamed:name];
    }
    
    return image;
}

@end
