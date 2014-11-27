//
//  ResultsVC.m
//  Booom
//
//  Created by Samka on 17.06.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "ResultsViewController.h"
#import "UIView+FrameAdditions.h"

#define CELL_HEIGHT_TEAM_NAMES 30.0f

@interface ResultsViewController ()

@end

@implementation ResultsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.game = [Game getGame];

    if ([self.game.finished isEqualToString:@"TRUE"]) {

        int winnerScore = 0;
        //NSString *winner = @"";
        NSMutableArray *winnerArray = [NSMutableArray array];
        for (NSDictionary *dict in self.game.scores) {
            int currentTeamScore = [[dict objectForKey:@"teamScore"] intValue];
            if (winnerScore < currentTeamScore) winnerScore = currentTeamScore;
        }
        for (NSDictionary *dict in self.game.scores) {
            int currentTeamScore = [[dict objectForKey:@"teamScore"] intValue];
            if (winnerScore == currentTeamScore) [winnerArray addObject:[dict objectForKey:@"teamName"]];
        }
        if (winnerArray.count == 1) self.finalResult.text = [NSString stringWithFormat:NSLocalizedString(@"Won", nil), winnerArray[0]];
        else if (winnerArray.count > 1) {

            NSString *winnerTeamNames = @"";
            for (NSString *winnerName in winnerArray) winnerTeamNames = [winnerTeamNames stringByAppendingString:[NSString stringWithFormat:@"%@, ",winnerName]];

            winnerTeamNames = [winnerTeamNames substringToIndex:[winnerTeamNames length]-2];
            self.finalResult.text = [NSString stringWithFormat:NSLocalizedString(@"Winners are:", nil), winnerTeamNames];
            float i = [self.finalResult.text sizeWithAttributes: @{NSFontAttributeName: self.finalResult.font, UIFontDescriptorTraitsAttribute: @(UIFontDescriptorTraitBold)}].width;
            if (i>250) {
                self.finalResult.height = 60;
                self.finalResult.numberOfLines = 2;
                self.finalResult.lineBreakMode = NSLineBreakByWordWrapping;
                
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.finalResult.text];
                NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
                [paragraphStyle setLineSpacing:10];
                [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.finalResult.text length])];
                self.finalResult.attributedText = attributedString;
                self.finalResult.textAlignment = NSTextAlignmentCenter;

                [self.resultsTableView setY:CGRectGetMaxY(self.finalResult.frame)+20];
            }
        };
        
        [self.nextRoundButton setTitle:NSLocalizedString(@"EndGame", nil) forState:UIControlStateNormal];

    }
    self.resultsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.resultsTableView.delegate = self;
    self.resultsTableView.dataSource = self;

    


    //CGRect frame = [[[self.resultsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] layer] frame];
    //NSLog(@"%f,%f,%f",frame.size.height,self.resultsTableView.sectionHeaderHeight,self.game.scores.count*30+self.resultsTableView.sectionHeaderHeight+self.resultsTableView.sectionFooterHeight);
    /*
    self.resultsTableView.frame = CGRectMake(20,
                                             92,
                                             self.view.frame.size.width-40,
                                             self.game.scores.count*30);*/
    [self.resultsTableView setWidth:self.view.frame.size.width-40];
    [self.resultsTableView setHeight:self.game.scores.count*30];
    [self.resultsTableView reloadData];
    
    [self.nextRoundButton setY:MAX(CGRectGetMaxY(self.resultsTableView.frame)+10,self.view.height*0.6)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.game.scores.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT_TEAM_NAMES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResCell"];
    
    // Configure the cell...
    cell.textLabel.text = [[self.game.scores objectAtIndex:indexPath.row] objectForKey:@"teamName"];

    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",
                                 [[self.game.scores objectAtIndex:indexPath.row] objectForKey:@"teamScore"]];

    return cell;
}

- (IBAction)nextButtonDidClicked:(UIButton *)sender {
    
    
    if ([self.game.finished isEqualToString:@"TRUE"]) {
        UIViewController *presentingVC = self.presentingViewController;
        UINavigationController *gameVC = (UINavigationController *)[presentingVC presentingViewController];
        [self dismissViewControllerAnimated:NO completion:^{
            [presentingVC dismissViewControllerAnimated:NO completion:^{
                [gameVC popToRootViewControllerAnimated:YES];
            }];}];
    } else {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
- (IBAction)exitGame:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"exitTitle", nil)
                                                        message:NSLocalizedString(@"exitMessage", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"exitCancelTitle", nil)
                                              otherButtonTitles:NSLocalizedString(@"exitOKTitle", nil),
                              nil];
    [alertView show];
    alertView.tag = ExitTagResultsView;
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == ExitTagResultsView) {
            UIViewController *roundVC = self.presentingViewController;
            UINavigationController *gameVC = (UINavigationController *)[roundVC presentingViewController];
            [self dismissViewControllerAnimated:NO completion:^{
                [roundVC dismissViewControllerAnimated:NO completion:^{
                   [gameVC popToRootViewControllerAnimated:YES];
                }];
            }];
        }
    }
}
@end