//
//  Game.m
//  Booom
//
//  Created by Samka on 17.06.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "Game.h"
#import "stdlib.h"
#import "AFHTTPRequestOperation.h"
#import "GetWordsDatabase.h"

@implementation Game


- (id)init {
    self = [super init];
    if (self) {
        
        self.gameSettings = [GameSettings getGame];
        if (!self.gameSettings) {
            self.gameSettings = [[GameSettings alloc] init];
        }
        self.finished = @"FALSE";

        NSDictionary *wholeDictionary = [GetWordsDatabase getCategoryWords:self.gameSettings.categoryName];
        NSMutableArray *dict = [[NSMutableArray alloc] initWithArray:[wholeDictionary allValues]];

        
        self.wordsLeft = [NSMutableArray new];

                 for (int i = 0; i<self.gameSettings.wordsNumber.intValue; i++) {
                     int position = arc4random_uniform((int)dict.count)-1;

                     [self.wordsLeft addObject:[dict objectAtIndex:position]];
                     [dict removeObjectAtIndex:position];
                 }

                 self.wordsSet = [[NSArray alloc] initWithArray:self.wordsLeft];
            
                 self.roundNumber = @1;
                 self.currentTeam = [NSNumber numberWithInt:arc4random() % [self.gameSettings.numberTeams intValue]];
            
                 self.scores = [[NSMutableArray alloc] init];

                 for (int i = 0; i<self.gameSettings.teamDetails.count; i++) {
                    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithCapacity:2];
                     [tempDict setObject:[self.gameSettings.teamDetails objectAtIndex:i] forKey:@"teamName"];
                     [tempDict setObject:@0 forKey:@"teamScore"];
                     [self.scores addObject:tempDict];
                     tempDict = nil;
                 }
                 [Game saveGame:self];

            }
    return self;
}


- (Game *)initWithCoder:(NSCoder *) aDecoder {
    self = [super init];
    if (self) {
        self.wordsSet = [aDecoder decodeObjectForKey:@"wordsSet"];
        self.wordsLeft = [aDecoder decodeObjectForKey:@"wordsLeft"];
        self.roundNumber = [aDecoder decodeObjectForKey:@"roundNumber"];
        self.currentTeam = [aDecoder decodeObjectForKey:@"currentTeam"];
        self.finished = [aDecoder decodeObjectForKey:@"finished"];
        self.scores = [[NSMutableArray alloc] initWithContentsOfFile:[Game getPathToScoresPlist]];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *) anEncoder {
    [anEncoder encodeObject:self.wordsSet forKey:@"wordsSet"];
    [anEncoder encodeObject:self.wordsLeft forKey:@"wordsLeft"];
    [anEncoder encodeObject:self.roundNumber forKey:@"roundNumber"];
    [anEncoder encodeObject:self.currentTeam forKey:@"currentTeam"];
    [anEncoder encodeObject:self.finished forKey:@"finished"];
    [anEncoder encodeObject:self.scores forKey:@"scores"];
    [self.scores writeToFile:[Game getPathToScoresPlist] atomically:YES];

}

+ (NSString *)getPathToSArchive {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    return [[paths objectAtIndex:0] stringByAppendingString:@"/game.model"];
}

+ (NSString *)getPathToScoresPlist {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    return [[paths objectAtIndex:0] stringByAppendingString:@"/scores.plist"];
}

+ (void)saveGame:(Game *)aGame {
    [NSKeyedArchiver archiveRootObject:aGame toFile:[Game getPathToSArchive]];
}
+ (Game *)getGame {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[Game getPathToSArchive]];
}


+ (void)incrementScore:(Game *)game forTeam:(NSNumber *)currTeam {
    NSNumber *newScore = @([[[game.scores objectAtIndex:currTeam.intValue] objectForKey:@"teamScore"] intValue]+1);
    NSMutableDictionary *tempDict = [game.scores objectAtIndex:currTeam.intValue];
    [tempDict setObject:newScore forKey:@"teamScore"];
    tempDict = nil;
    newScore = nil;
}

+ (void)decrementScore:(Game *)game forTeam:(NSNumber *)currTeam {
    NSNumber *newScore = @([[[game.scores objectAtIndex:[currTeam intValue]] objectForKey:@"teamScore"] intValue]-1);
    [[game.scores objectAtIndex:[currTeam intValue]] setObject:newScore forKey:@"teamScore"];
    newScore = nil;
}

+(void)shiftUnguessedWordDown:(NSMutableArray *)array{

    for (int i = (int)[array count] - 2; i>=0; i--) {
        [array exchangeObjectAtIndex:i withObjectAtIndex:i+1];
    }
}

+ (NSMutableArray *)shuffleArray:(NSMutableArray *)array {
    for (int i = (int)[array count]-1; i > 0; i--) {
        int j = arc4random_uniform(i-1);
        [array exchangeObjectAtIndex:i withObjectAtIndex:j];
        
    }
    return array;
}

@end
