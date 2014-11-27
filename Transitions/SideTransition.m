//
//  SideTransition.m
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "SideTransition.h"

@implementation SideTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext
                              viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext
                                viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:toVC.view];
    
    CGRect fullFrame = [transitionContext initialFrameForViewController:fromVC];
    //NSLog(@"y is %@ ",fullFrame.origin);
    
    /*toVC.view.frame = CGRectMake(
     //fullFrame.size.width + 20,
     fullFrame.origin.x + 20,
     //fullFrame.size.height,
     fullFrame.origin.y + 16 + 20,
     CGRectGetWidth(fullFrame) - 40,
     CGRectGetHeight(fullFrame) - 56);
     */
    CGFloat height = CGRectGetHeight(fullFrame);
    toVC.view.frame = CGRectMake(
                                 fullFrame.origin.x + 20, // Keep x = 0
                                 height + 16 + 20, // y = height + 16
                                 CGRectGetWidth(fullFrame) - 40, // same width
                                 height - 40 // same height
                                 );
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.6f
                        options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^{
                         toVC.view.frame = CGRectMake(20,20,
                                                      CGRectGetWidth(fullFrame) - 40,
                                                      CGRectGetHeight(fullFrame) - 40);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }
     ];
    
}

@end
