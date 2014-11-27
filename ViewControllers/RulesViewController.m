//
//  RulesVC.m
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "RulesViewController.h"

@interface RulesViewController ()

@end

@implementation RulesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.title = @"Правила";
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    //view.layer.borderColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0].CGColor;
    //view.layer.borderWidth = 1;
    view.layer.cornerRadius = 8;
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    
    self.contentSubview = [[UIScrollView alloc] init];
    self.contentSubview.layer.borderColor = [UIColor grayColor].CGColor;
    self.contentSubview.layer.borderWidth =1;
    self.contentSubview.layer.cornerRadius = 9;
    
    
    self.headerLabel = [[UILabel alloc] init];
    UIFontDescriptor *futura40 = [UIFontDescriptor fontDescriptorWithName:@"Futura" size:20.0f];
    UIFontDescriptor *futura40Condensed = [futura40 fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitCondensed];
    UIFontDescriptor *futura40CondensedBold = [futura40Condensed fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    self.headerLabel.font = [UIFont fontWithDescriptor:futura40CondensedBold size:futura40CondensedBold.pointSize];
    self.headerLabel.textAlignment = NSTextAlignmentCenter;
    self.headerLabel.backgroundColor = [UIColor clearColor];
    self.headerLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    [self.contentSubview addSubview:self.headerLabel];
    
    self.descriptionTextView = [[UITextView alloc] init];
    UIFontDescriptor *helvetica15 = [UIFontDescriptor fontDescriptorWithName:@"HelveticaNeue" size:11];
    self.descriptionTextView.font = [UIFont fontWithDescriptor:helvetica15 size:11];
    self.descriptionTextView.backgroundColor = [UIColor clearColor];
    self.descriptionTextView.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    self.descriptionTextView.editable = NO;
    self.descriptionTextView.textAlignment = NSTextAlignmentJustified;
    [self.contentSubview addSubview:self.descriptionTextView];
    
    self.gotItButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.gotItButton.titleLabel.font = [UIFont systemFontOfSize: 13];
    self.gotItButton.tintColor = [UIColor darkGrayColor];
    [self.gotItButton setTitle:NSLocalizedString(@"GotIt", nil) forState:UIControlStateNormal];
    self.gotItButton.layer.borderWidth = 1;
    self.gotItButton.layer.borderColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0].CGColor;
    self.gotItButton.layer.cornerRadius = 6;
    [self.gotItButton addTarget:self action:@selector(gotItTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentSubview addSubview:self.gotItButton];
    
    [view addSubview:self.contentSubview];
    
    
    self.view = view;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.contentSubview.frame = CGRectMake(0,
                                           0,
                                           CGRectGetWidth(self.view.frame),
                                           CGRectGetHeight(self.view.frame));
    self.contentSubview.backgroundColor = [UIColor whiteColor];
    
    /*CGSize labelSize = [self.headerLabel.text sizeWithAttributes:
     @{NSFontAttributeName: self.headerLabel.font,
     UIFontDescriptorTraitsAttribute: @(UIFontDescriptorTraitBold)}
     ];
     self.headerLabel.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);*/
    
    self.headerLabel.frame = CGRectMake(0,
                                        20,
                                        280,//self.headerLabel.frame.size.width,
                                        self.headerLabel.font.pointSize);
    
    self.descriptionTextView.frame = CGRectMake(10,
                                                CGRectGetMaxY(self.headerLabel.frame),
                                                CGRectGetWidth(self.contentSubview.frame) - 10,
                                                140);
    
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // TODO: use the ensureLayoutForTextContainer and usedRectForTextContainer methods to create a CGRect that will contain the exact width/height of the textContainer used to display the text
    [self.descriptionTextView.layoutManager ensureLayoutForTextContainer:self.descriptionTextView.textContainer];
    CGRect descriptionContainerRect = [self.descriptionTextView.layoutManager usedRectForTextContainer:self.descriptionTextView.textContainer];
    
    // TODO: use that CGRect to update notesView's frame height, and also consider the top and bottom textContainerInsets in the height calculation.  Don't forget to take the ceilf() of that entire calculation to make sure only a round number is used to set the notesView frame.
    self.descriptionTextView.frame = CGRectMake(5,
                                                CGRectGetMaxY(self.headerLabel.frame)+10,
                                                descriptionContainerRect.size.width,
                                                ceilf(descriptionContainerRect.size.height+
                                                      self.descriptionTextView.textContainerInset.top+
                                                      self.descriptionTextView.textContainerInset.bottom));
    float buttonWidth = 80;
    self.gotItButton.frame = CGRectMake(ceilf((280-buttonWidth)/2),
                                        //CGRectGetHeight(self.contentSubview.frame) - 40,
                                        CGRectGetMaxY(self.descriptionTextView.frame)+10,
                                        buttonWidth,
                                        30);
    self.contentSubview.contentSize = CGSizeMake(CGRectGetWidth(self.contentSubview.frame),
                                                 CGRectGetMaxY(self.gotItButton.frame)+20);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.headerLabel.text = NSLocalizedString(@"Rules", nil);
    
    self.descriptionTextView.text = NSLocalizedString(@"RulesDescription", nil);
    
    //NSAttributedString *formattedText = [[NSAttributedString alloc] initWithString:self.descriptionTextView.text attributes:@{NSShadowAttributeName: textShadow}];
    //self.descriptionTextView.attributedText = formattedText;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gotItTapped:(id)sender
{
    
    //[self.presentingViewController.view setBackgroundColor:[UIColor yellowColor]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
