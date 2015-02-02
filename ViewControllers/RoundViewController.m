//
//  RoundVC.m
//  Booom
//
//  Created by Samka on 17.06.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "RoundViewController.h"
#import "Game.h"
#import "UILabel+Boldify.h"

@interface RoundViewController ()

@property (strong, nonatomic) IBOutlet UITextView *roundDescription;


@end

@implementation RoundViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //if (self.isViewLoaded && self.view.window) {
        // viewController is visible

    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wordsLoaded)
                                                 name:@"wordsFinishedLoading"
                                               object:nil];
     */
}

- (void)viewWillAppear:(BOOL)animated {
    self.game = [Game getGame];
    //NSLog(@"%i",(int)self.game.wordsLeft.count);


    if (![self.game.finished isEqualToString:@"TRUE"]) {
        //NSLog(@"oops");
        //[self dismissViewControllerAnimated:NO completion:nil];

    //} else {
    if (self.game.wordsLeft.count == 0) {
        if ([self.game.roundNumber intValue] == 3) {
            self.game.finished = @"TRUE";

            [Game saveGame:self.game];
            //[self performSegueWithIdentifier:@"showResults" sender:self];
        } else {
            self.game.wordsLeft = [NSMutableArray arrayWithArray:self.game.wordsSet];
            self.game.wordsLeft = [Game shuffleArray:self.game.wordsLeft];
            self.game.roundNumber = @(self.game.roundNumber.intValue + 1);
            self.roundNumber.text = [NSString stringWithFormat:NSLocalizedString(@"Round", nil), [self.game.roundNumber intValue]];
            
            //NSLog(@"roundVC. round # is %@",self.game.roundNumber);
            [Game saveGame:self.game];
            //[self performSegueWithIdentifier:@"showResults" sender:self];
        }
        //NSLog(@"RoundVC. finished now?: %@", self.game.finished);
    }
    
    
        //self.roundNumber.text = [NSString stringWithFormat:NSLocalizedString(@"Round", nil), [self.game.roundNumber intValue]];
        //NSLog(@"RoundVC. Раунд %@", self.game.roundNumber);
    
        self.wordsLeftNumber.text = [NSString stringWithFormat:NSLocalizedString(@"WordsLeft", nil), (int)self.game.wordsLeft.count];
    
        NSString *currentTeam = [[self.game.scores objectAtIndex:[self.game.currentTeam integerValue]] objectForKey:@"teamName"];
        self.currentTeam.text = [NSString stringWithFormat:NSLocalizedString(@"PlayTurn", nil), currentTeam];
        switch ([self.game.roundNumber intValue]) {
            case 1:
                self.roundDescription.text = NSLocalizedString(@"RoundOneShortDescription", nil);
                break;
            case 2: self.roundDescription.text = NSLocalizedString(@"RoundTwoShortDescription", nil);
                break;
                case 3: self.roundDescription.text = NSLocalizedString(@"RoundThreeShortDescription", nil);
                break;
            default:
                break;
        }
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)wordsLoaded
{
    self.game = [Game getGame];
    if (!self.game) {
        NSLog(@"how did you get to that page?");
    }

    self.roundNumber.text = [NSString stringWithFormat:NSLocalizedString(@"Round", nil), self.game.roundNumber.intValue];
    //NSLog(@"RoundVC. Раунд %@", self.game.roundNumber);
    NSString *currentTeam = [[self.game.scores objectAtIndex:[self.game.currentTeam integerValue]] objectForKey:@"teamName"];
    //NSString *currentTeam1 = [[self.game.scores objectAtIndex:1] objectForKey:@"teamName"];
    //NSString *currentTeam2 = [[self.game.scores objectAtIndex:2] objectForKey:@"teamName"];
    //NSString *currentTeam3 = [[self.game.scores objectAtIndex:3] objectForKey:@"teamName"];
    //NSLog(@"1- %@ 2 - %@ 3- %@",currentTeam1,currentTeam2,currentTeam3);
    self.currentTeam.text = [NSString stringWithFormat:NSLocalizedString(@"PlayTurn", nil), currentTeam];
    self.wordsLeftNumber.text = [NSString stringWithFormat:NSLocalizedString(@"WordsLeft", nil), (int)self.game.wordsLeft.count];
}

- (IBAction)exitGame:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"exitTitle", nil)
                                                        message:NSLocalizedString(@"exitMessage", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"exitCancelTitle", nil)
                                              otherButtonTitles:NSLocalizedString(@"exitOKTitle", nil),
                              nil];
    [alertView show];
    alertView.tag = ExitTagRoundView;

}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //NSLog(@"%li",(long)buttonIndex);
    if (buttonIndex == 1) {
        if (alertView.tag == ExitTagRoundView) {
            UINavigationController *gameVC = (UINavigationController *)[self presentingViewController];
            [self dismissViewControllerAnimated:NO completion:^{
                [gameVC popToRootViewControllerAnimated:YES];}
             ];
        }
    }
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
