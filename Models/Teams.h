//
//  Teams.h
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Teams : NSObject

@property (strong, nonatomic) NSString *teamName;

-(id)init;

-(id)initWithName:(NSString *)name;

@end
