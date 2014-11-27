//
//  TimerVC.m
//  Booom
//
//  Created by Samka on 17.06.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "TimerViewController.h"
#import "ResultsViewController.h"
#import "RoundViewController.h"
#import "GameSettings.h"

@interface TimerViewController ()

@property (strong, nonatomic) IBOutlet UILabel *currentTeam;
@property (strong, nonatomic) NSString *lastGuessedWord;
@property (strong, nonatomic) AVAudioPlayer *guessedAVSound;
@property (strong, nonatomic) AVAudioPlayer *pauseAVSound;
@property (strong, nonatomic) AVAudioPlayer *buzzerAVSound;
@property (assign) SystemSoundID guessedSound;
@property (strong, nonatomic) IBOutlet UIButton *backWord;

@end

@implementation TimerViewController

-(id)initWithCoder:(NSCoder *)decoder{
    self = [super initWithCoder:decoder];
    if (self) {
        self.game = [Game getGame];
        self.gameSettings = [GameSettings getGame];
    }
    return self;
}

-(void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.lastGuessedWord = nil;
    [self.backWord setEnabled:NO];
    
    NSError *error;
    NSString *pathGuessedAVSound = [[NSBundle mainBundle] pathForResource:@"correct" ofType:@"caf"];
    self.guessedAVSound = [[AVAudioPlayer alloc]
                           initWithContentsOfURL:[NSURL fileURLWithPath:pathGuessedAVSound] error:&error];
    [self.guessedAVSound prepareToPlay];
    
    NSString *pathBuzzerAVSound = [[NSBundle mainBundle] pathForResource:@"buzzer" ofType:@"caf"];
    self.buzzerAVSound = [[AVAudioPlayer alloc]
                          initWithContentsOfURL:[NSURL fileURLWithPath:pathBuzzerAVSound] error:&error];
    [self.buzzerAVSound prepareToPlay];
    
    NSString *pathPauseAVSound = [[NSBundle mainBundle] pathForResource:@"pause" ofType:@"caf"];
    self.pauseAVSound = [[AVAudioPlayer alloc]
                           initWithContentsOfURL:[NSURL fileURLWithPath:pathPauseAVSound] error:&error];
    [self.pauseAVSound prepareToPlay];
    
    self.timerObj =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *currentTeam = [[self.game.scores objectAtIndex:[self.game.currentTeam integerValue]] objectForKey:@"teamName"];
    self.currentTeam.text = [NSString stringWithFormat:NSLocalizedString(@"PlayTurn", nil), currentTeam];
    self.guessWord.text = [self.game.wordsLeft lastObject];
    int intSeconds = [self.gameSettings.roundDuration intValue] % 60;
    int intMinutes = ([self.gameSettings.roundDuration intValue] - intSeconds) / 60;
    NSString *minutes = [NSString stringWithFormat:@"%i", intMinutes];
    NSString *seconds = [NSString stringWithFormat:@"%02d", intSeconds];
    self.timer.text = [[minutes stringByAppendingString:@":"] stringByAppendingString:seconds];
    self.timer.text = @"0:03";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //AudioServicesDisposeSystemSoundID(guessedSound);
    
    // Dispose of any resources that can be recreated.
}

-(void)countDown:(NSTimer *) aTimer {
    NSArray *list = [self.timer.text componentsSeparatedByString:@":"];
    int seconds = [list[0] intValue]*60+[list[1] intValue];
    if (seconds == 1) {
        

        [self.buzzerAVSound play];
        
        self.timer.text = @"0:00";

        int i = [self.game.currentTeam intValue];
        int numberTeams = [[[GameSettings getGame] numberTeams] intValue];
        self.game.currentTeam = @(i + 1 - ((i + 1)/numberTeams)*numberTeams);
        

        [Game shiftUnguessedWordDown:self.game.wordsLeft];
        [Game saveGame:self.game];
        [self dismissViewControllerAnimated:YES completion:nil];
        // ^{[presentingVC performSegueWithIdentifier:@"showResults" sender:presentingVC];}];

        [aTimer invalidate];
        
    } else {
        int newMinutes = (seconds - 1)/60;
        int newSeconds = seconds -1 - newMinutes*60;
        self.timer.text = [NSString stringWithFormat:@"%i:%02d",newMinutes, newSeconds];
    }
}

- (IBAction)guessedButtonDidClicked:(id)sender {
    self.lastGuessedWord = [self.game.wordsLeft lastObject];
    [self.game.wordsLeft removeLastObject];
    
    [self.guessedAVSound play];
    
    if (self.game.wordsLeft.count == 0) {
        
        [Game incrementScore:self.game forTeam:self.game.currentTeam];
        [Game saveGame:self.game];
        [self.timerObj invalidate];

        UIViewController *presentingVC = self.presentingViewController;
        [self dismissViewControllerAnimated:YES completion:^{
            [presentingVC performSegueWithIdentifier:@"showResults" sender:presentingVC];}];

    } else {

        
        
        //DO NOT REMOVE
        /*
        NSString *pathGuessedSound = [[NSBundle mainBundle] pathForResource:@"correct" ofType:@"caf"];

        NSLog(@"TimerVC.m: %@",pathGuessedSound);
        NSLog(@"TimerVC.m: %@",(__bridge CFURLRef)[NSURL fileURLWithPath:pathGuessedSound]);
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:pathGuessedSound], &_guessedSound);
        AudioServicesPlaySystemSound(self.guessedSound);
        */
        
        [Game incrementScore:self.game forTeam:self.game.currentTeam];
        
        self.guessWord.text = [self.game.wordsLeft lastObject];
        [self.backWord setEnabled:YES];
    }
}


- (IBAction)previousWord:(id)sender {
        [self.game.wordsLeft addObject:self.lastGuessedWord];
        self.guessWord.text = self.lastGuessedWord;
        [Game decrementScore:self.game forTeam:self.game.currentTeam];
        self.lastGuessedWord = nil;
        [self.backWord setEnabled:NO];
    
}

- (IBAction)endRound:(id)sender {
    [self.timerObj invalidate];
    self.timerObj = nil;
    
    [self.pauseAVSound play];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"endRoundTitle", nil)
                                                        message:NSLocalizedString(@"endRoundMessage", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"endRoundCancelTitle", nil)
                                              otherButtonTitles:NSLocalizedString(@"endRoundOKTitle", nil),
                              nil];
    [alertView show];
    alertView.tag = EndRoundTagTimerVC;
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //NSLog(@"%li",(long)buttonIndex);
    if (buttonIndex == 1) {
        if (alertView.tag == EndRoundTagTimerVC) {
            
            int i = [self.game.currentTeam intValue];
            int numberTeams = [[[GameSettings getGame] numberTeams] intValue];
            self.game.currentTeam = @(i + 1 - ((i + 1)/numberTeams)*numberTeams);
            
            [Game shiftUnguessedWordDown:self.game.wordsLeft];
            [Game saveGame:self.game];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        self.timerObj =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
        
    }
}


@end
