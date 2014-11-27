//
//  Game.h
//  Booom
//
//  Created by Samka on 17.06.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameSettings.h"

@interface Game : NSObject <NSCoding>

@property (strong, nonatomic) GameSettings *gameSettings;

@property (strong, nonatomic) NSArray *wordsSet;
@property (strong, nonatomic) NSMutableArray *wordsLeft;
@property (strong, nonatomic) NSNumber *roundNumber;
@property (strong, nonatomic) NSNumber *currentTeam;
@property (strong, nonatomic) NSString *finished;

@property (strong, nonatomic) NSMutableArray *scores;

- (id)init;

+ (NSString *)getPathToSArchive;
+ (NSString *)getPathToScoresPlist;

+ (void)saveGame:(Game *)aGame;

+ (Game *)getGame;

+ (void)incrementScore:(Game *)game forTeam:(NSNumber *)currTeam;
+ (void)decrementScore:(Game *)game forTeam:(NSNumber *)currTeam;
+ (void)shiftUnguessedWordDown:(NSMutableArray *) array;
+ (NSMutableArray *)shuffleArray:(NSMutableArray *)array;

@end
