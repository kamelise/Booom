//
//  GameSettings.m
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "GameSettings.h"

@implementation GameSettings

- (id)init {
    self = [super init];
    if (self) {
        self.numberTeams = @2;
        self.teamDetails = [[NSMutableArray alloc] init];
        [self.teamDetails addObjectsFromArray:[NSArray arrayWithObjects:
                                               NSLocalizedString(@"Team 1", nil),
                                               NSLocalizedString(@"Team 2", nil),
                                               nil]];
        /*[[Teams alloc] initWithName:@" Команда 1"],
         [[Teams alloc] initWithName:@"Команда 2"],
         */
        self.categoryName = @"simpleWords";
        self.wordsNumber = @10;
        self.roundDuration = @30;
        NSString *language = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
        if ([language isEqualToString:@"ru"]) self.language = @"Russian";
        else if ([language isEqualToString:@"en"]) self.language = @"English";

        [GameSettings saveGame:self];
    }
    return self;
}

/*+ (Game *)updateTeamDetails:(Game *)gameObject WhenNumberChanged:(int)newNumber {
 int numberTeams = [gameObject.numberTeams intValue];
 Game *game = gameObject;
 Teams *test = gameObject.teamDetails[0];
 NSLog(@"team name is %@", test);
 if (numberTeams < newNumber)
 {
 NSRange nsrange = NSMakeRange(numberTeams, newNumber - numberTeams);
 NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:nsrange];
 //for (Teams *object in game.teamDetails) {
 //    NSLog(@"team name is ",object.teamName);
 //}
 if (game.numberTeams) {
 Teams *test = game.teamDetails[0];
 NSLog(@"team name is %@", test.teamName);
 }
 //[game.teamDetails removeObjectsAtIndexes:indexes];
 } else {
 
 NSMutableArray *addArray = [[NSMutableArray alloc] init];
 for (int i = numberTeams; i <= newNumber ; i++) {
 NSString *newTeamName = [NSString stringWithFormat:@"Команда %d", i];
 [addArray addObject:[[Teams alloc] initWithName:newTeamName]];
 }
 [gameObject.teamDetails addObjectsFromArray:addArray];
 }
 return gameObject;
 }
 */
- (GameSettings *)initWithCoder:(NSCoder *) aDecoder {
    self = [super init];
    if (self) {
        self.numberTeams = [aDecoder decodeObjectForKey:@"numberTeams"];
        self.teamDetails = [aDecoder decodeObjectForKey:@"teamDetails"];
        self.categoryName = [aDecoder decodeObjectForKey:@"categoryName"];
        self.wordsNumber = [aDecoder decodeObjectForKey:@"wordsNumber"];
        self.roundDuration = [aDecoder decodeObjectForKey:@"roundDuration"];
        self.language = [aDecoder decodeObjectForKey:@"language"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *) anEncoder {
    [anEncoder encodeObject:self.numberTeams forKey:@"numberTeams"];
    [anEncoder encodeObject:self.teamDetails forKey:@"teamDetails"];
    [anEncoder encodeObject:self.categoryName forKey:@"categoryName"];
    [anEncoder encodeObject:self.wordsNumber forKey:@"wordsNumber"];
    [anEncoder encodeObject:self.roundDuration forKey:@"roundDuration"];
    [anEncoder encodeObject:self.language forKey:@"language"];
}

+ (NSString *)getPathToSArchive {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    return [[paths objectAtIndex:0] stringByAppendingString:@"/gameSettings.model"];
}

+ (void)saveGame:(GameSettings *)aGame {
    [NSKeyedArchiver archiveRootObject:aGame toFile:[GameSettings getPathToSArchive]];
}
+ (GameSettings *)getGame {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[GameSettings getPathToSArchive]];
}

@end
