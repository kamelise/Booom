//
//  DismissSegue.m
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "DismissSegue.h"

@implementation DismissSegue

- (void)perform {
    UIViewController *sourceVC = self.sourceViewController;
    [sourceVC.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
