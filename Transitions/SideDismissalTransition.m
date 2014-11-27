//
//  SideDismissalTransition.m
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "SideDismissalTransition.h"

@implementation SideDismissalTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext
                                viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //CGRect fullFrame = [transitionContext initialFrameForViewController:fromVC];
    

    __block CGRect presentedFrame = [transitionContext initialFrameForViewController:fromVC];
    
    [UIView animateKeyframesWithDuration:1.0f delay:0.0 options:0 animations:^{

        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
            presentedFrame.origin.y += CGRectGetHeight(presentedFrame) + 20;
            fromVC.view.frame = presentedFrame;
            //fromVC.view.transform = CGAffineTransformMakeRotation(0.2);
        }];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    [[fromVC.presentingViewController.view viewWithTag:DIM_VIEW_TAG] removeFromSuperview];
    
}

@end
