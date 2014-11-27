//
//  GameSettings.h
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Teams.h"

@interface GameSettings : NSObject <NSCoding>

@property (strong, nonatomic) NSNumber *numberTeams;
@property (strong, nonatomic) NSMutableArray *teamDetails;
@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSNumber *wordsNumber;
@property (strong, nonatomic) NSNumber *roundDuration;
@property (strong, nonatomic) NSString *language;
/*
@property (strong, nonatomic) NSArray *wordsSet;
@property (strong, nonatomic) NSMutableArray *wordsLeft;
@property (strong, nonatomic) NSNumber *roundNumber;
@property (strong, nonatomic) NSString *currentTeam;
*/
+ (NSString *)getPathToSArchive;

+ (void)saveGame:(GameSettings *)aGame;

+ (GameSettings *)getGame;

@end
