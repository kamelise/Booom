//
//  MainMenu.m
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "MainViewController.h"
#import "RulesViewController.h"
#import "SideTransition.h"
#import "SideDismissalTransition.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.playButton.layer.borderColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0].CGColor;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)rulesTapped:(id)sender {
    RulesViewController *rulesVC = [RulesViewController new];
    
    UIView *dimView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               CGRectGetWidth(self.view.frame),
                                                               CGRectGetHeight(self.view.frame))];
    dimView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
    dimView.tag = DIM_VIEW_TAG;
    [self.view addSubview:dimView];
    
    
    //self.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.5];
    rulesVC.modalPresentationStyle = UIModalPresentationCustom;
    rulesVC.transitioningDelegate = self;
    [self presentViewController:rulesVC animated:YES completion:nil];
     /*^{
        UIPanGestureRecognizer *gesture = [UIPanGestureRecognizer new];
        [gesture addTarget:self action:@selector(handleGesture:)];
        [rulesVC.view addGestureRecognizer:gesture];
    }];*/
}

- (id <UIViewControllerAnimatedTransitioning>)
animationControllerForPresentedController:(UIViewController *)presented
presentingController:(UIViewController *)presenting
sourceController:(UIViewController *)source
{
    return [[SideTransition alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)
animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[SideDismissalTransition alloc] init];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
