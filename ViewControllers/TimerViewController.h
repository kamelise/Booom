//
//  TimerVC.h
//  Booom
//
//  Created by Samka on 17.06.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "Game.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AudioUnit/AudioUnit.h>
@import AVFoundation;

@interface TimerViewController : UIViewController

@property (strong,nonatomic) Game *game;
@property (strong,nonatomic) GameSettings *gameSettings;

@property (strong, nonatomic) NSTimer *timerObj;

@property (weak, nonatomic) IBOutlet UILabel *timer;
@property (weak, nonatomic) IBOutlet UILabel *guessWord;

@property (weak, nonatomic) IBOutlet UIButton *guessedButton;

-(IBAction)guessedButtonDidClicked:(id)sender;


@end
