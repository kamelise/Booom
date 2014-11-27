//
//  GameVC.m
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "GameViewController.h"
#import "GetWordsDatabase.h"
#import "Constants.h"
#import "UIView+FrameAdditions.h"
#import "TeamListGameVCCell.h"

#define CELL_HEIGHT_TEAM_NAMES 30.0f

@interface GameViewController ()
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.frame = CGRectMake(40.0, 20.0, 100.0, 100.0);
    self.activityIndicator.center = self.view.center;

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(firedNotif)
                                                 name:@"wordsFinishedLoading"
                                               object:nil];
    
    // Do any additional setup after loading the view.
    self.gameSettings = [GameSettings getGame];
    if (!self.gameSettings) {
        self.gameSettings = [[GameSettings alloc] init];
    }
    
    self.numberTeams.text = [NSString stringWithFormat:NSLocalizedString(@"TeamsPlaying", nil), [self.gameSettings.numberTeams stringValue]];
    self.categoryName.text = [NSString stringWithFormat:NSLocalizedString(@"Category", nil), NSLocalizedString(self.gameSettings.categoryName, nil)];
    //NSLog(@"%@",self.gameSettings.categoryName);
    self.wordsNumber.text = [NSString stringWithFormat:NSLocalizedString(@"WordsPerRound", nil), [self.gameSettings.wordsNumber stringValue]];
    
    int intSeconds = [self.gameSettings.roundDuration intValue] % 60;
    int intMinutes = ([self.gameSettings.roundDuration intValue] - intSeconds) / 60;
    NSString *minutes = [NSString stringWithFormat:@"%i", intMinutes];
    NSString *seconds = [NSString stringWithFormat:@"%02d", intSeconds];
    NSString *roundDuration = [[minutes stringByAppendingString:@":"] stringByAppendingString:seconds];
    
    self.roundDuration.text = [NSString stringWithFormat:NSLocalizedString(@"RoundDuration", nil), roundDuration];
    

    self.teamDetails.delegate = self;
    self.teamDetails.dataSource = self;
    /*
    self.teamDetails.frame = CGRectMake(160,
                                        175,
                                        140,
                                        self.gameSettings.teamDetails.count*CELL_HEIGHT_TEAM_NAMES);

    [self.gameButton setY:MAX(175+ceilf(self.gameSettings.teamDetails.count*CELL_HEIGHT_TEAM_NAMES), 345)+20];
    float secondColumnHeight = 40+5+self.gameSettings.teamDetails.count*CELL_HEIGHT_TEAM_NAMES+20+40;
    if (CGRectGetMaxY(self.gameButton.frame) > self.view.height-60) {

        [self.teamNames setY:64 + (self.view.height - 64 - secondColumnHeight)/2];
        [self.teamDetails setY:CGRectGetMaxY(self.teamNames.frame)+5];
        [self.gameButton setY:CGRectGetMaxY(self.teamDetails.frame)+10];
    }*/
        
    [self.teamDetails reloadData];
    
    //[self.view addSubview:self.teamDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"wordsFinishedLoading" object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.gameSettings.teamDetails.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT_TEAM_NAMES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeamListGameVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TNCell"];
    
    // Configure the cell...
    
    cell.textLabel.text = (self.gameSettings.teamDetails)[indexPath.row];
    /*cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    cell.textLabel.textColor = [UIColor lightGrayColor];*/
    //NSLog(@"%@",(self.gameSettings.teamDetails)[indexPath.row]);
    return cell;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"createGame"]) {
    
        if ([[NSFileManager defaultManager] fileExistsAtPath:[GetWordsDatabase getPathToCategory:self.gameSettings.categoryName]])
        {
            //NSLog(@"GameVC: preparing to create Game instance");
            self.game = [Game new];
        }
        
    }
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if([identifier isEqualToString:@"createGame"]) {
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[GetWordsDatabase getPathToCategory:self.gameSettings.categoryName]])
        {
            //NSLog(@"GameVC: category file exists");
            return YES;
        }
        else {
            //NSLog(@"_____________________________");
            self.activityIndicator.hidden = NO;
            [self.activityIndicator startAnimating];
            [self.view addSubview:self.activityIndicator];

            [self performSelector:@selector(showingNoInternetMessage) withObject:nil afterDelay:5.0];
            
            [GetWordsDatabase getWords:self.gameSettings.categoryName];
            return NO;
            }
        }
    return YES;
}

-(void)showingNoInternetMessage {
    if ([self.activityIndicator isDescendantOfView:self.view]) {
        [self.activityIndicator stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"noInternetTitle", nil)
                                                        message:NSLocalizedString(@"noInternetMessage", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"noInternetCancelTitle", nil)
                                              otherButtonTitles:NSLocalizedString(@"noInternetOKTitle", nil), nil];
        [alertView show];
        alertView.tag = NO_INTERNET_TAG;
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //NSLog(@"%li",(long)buttonIndex);
    if (buttonIndex == 1) {
        if (alertView.tag == NO_INTERNET_TAG) {
            self.activityIndicator.hidden = NO;
            [self.activityIndicator startAnimating];
            [self.view addSubview:self.activityIndicator];
            [self performSelector:@selector(showingNoInternetMessage) withObject:nil afterDelay:5.0];
            
            [GetWordsDatabase getWords:self.gameSettings.categoryName];
        }
    } else if (buttonIndex == 0) {
            [self.activityIndicator stopAnimating];
    }
}

-(void)firedNotif{

    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
    //NSLog(@"fired");
    self.game = [[Game alloc] init];
    [self performSegueWithIdentifier:@"createGame" sender:self];
    
    
}



@end
