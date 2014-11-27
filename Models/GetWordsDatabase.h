//
//  GetWordsDatabase.h
//  Booom
//
//  Created by Samka on 23.06.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetWordsDatabase : NSObject

+(BOOL)checkWords:(NSString *)category;
+(void)getWords:(NSString *)category;
+(void)saveCategoryWords:(NSDictionary *)data withCategory:(NSString *)category;
+ (NSString *)getPathToCategory:(NSString *)category;
+ (NSDictionary *)getCategoryWords:(NSString *)category;// withLimit:(NSNumber *)limit;

@end
