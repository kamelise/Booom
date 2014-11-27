//
//  RulesVC.h
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

//#import <UIKit/UIKit.h>

@interface RulesViewController : UIViewController

@property (strong, nonatomic) UIScrollView *contentSubview;
@property (strong, nonatomic) UITextView *descriptionTextView;
@property (strong, nonatomic) UIButton *gotItButton;
@property (strong, nonatomic) UILabel *headerLabel;

- (void)gotItTapped:(id)sender;

@end
