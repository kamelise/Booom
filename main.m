//
//  main.m
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

//#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "GameSettings.h"

int main(int argc, char * argv[])
{
    GameSettings *gameSettings = [GameSettings getGame];
    if (gameSettings) {

        NSString *language = @"";
        if ([gameSettings.language isEqualToString:@"Russian"])
            language = @"ru";
        else if ([gameSettings.language isEqualToString:@"English"])
            language = @"en";
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObject:language] forKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
