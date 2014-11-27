//
//  Teams.m
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "Teams.h"

@implementation Teams

-(id)init {
    self = [super init];
    if (self) {
        self.teamName = @"Команда";
    }
    return self;
}

-(id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.teamName = name;
    }
    return self;
}

@end
