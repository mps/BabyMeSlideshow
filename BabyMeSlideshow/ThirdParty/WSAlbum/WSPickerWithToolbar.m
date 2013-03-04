//
//  WSPickerWithToolbar.m
//  WSAssetPickerController
//
//  Created by Wesley Smith on 1/10/13.
//  Copyright (c) 2013 Wesley D. Smith. All rights reserved.
//

#import "WSPickerWithToolbar.h"

@interface WSPickerWithToolbar ()

@end

@implementation WSPickerWithToolbar

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Setup toolbar items.
    UIBarButtonItem *selectAllItem = [[UIBarButtonItem alloc] initWithTitle:@"Select up to 15 Photos"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self    
                                                                     action:@selector(selectAll)];
    
    UIBarButtonItem *selectNoneItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear"
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(selectNone)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil action:NULL];
    
    self.toolbarItems = @[selectAllItem, flexibleSpace, selectNoneItem];
}

@end
