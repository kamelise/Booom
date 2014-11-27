//
//  GetWordsDatabase.m
//  Booom
//
//  Created by Samka on 23.06.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "GetWordsDatabase.h"
#import "AFHTTPRequestOperation.h"

@implementation GetWordsDatabase

+(BOOL)checkWords:(NSString *)category {
    //get md5checksum or sie of category table
    //compare to data saved in %category%_category.plist
    //if the same, return TRUE, otherwise FALSE
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //NSLog(@"%@",[GetWordsDatabase getPathToCategory:category]);
    return [fileManager fileExistsAtPath:[GetWordsDatabase getPathToCategory:category]];
}

+(void)getWords:(NSString *)category {
    NSString *language = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    NSString *pathToCategoryDownload = [NSString stringWithFormat:@"http://gotidea.me/boom/boom.php?category=%@&lang=%@", category, language];
    NSURL *url = [[NSURL alloc] initWithString:pathToCategoryDownload];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id JSON) {
        NSDictionary *dict = JSON;

        [GetWordsDatabase saveCategoryWords:dict withCategory:category];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"wordsFinishedLoading" object:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"NSError: %@",[error localizedDescription]);
    }];
    
    [operation start];
    //NSLog(@"Started");
    //[operation waitUntilFinished];
}

+(void)saveCategoryWords:(NSDictionary *)data withCategory:(NSString *)category {
    [data writeToFile:[GetWordsDatabase getPathToCategory:category] atomically:YES];
    //NSLog(@"%@",[GetWordsDatabase getPathToCategory:category]);
}
+(NSString *)getPathToCategory:(NSString *)category {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *language = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    return [[paths objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@_category_%@.plist", category,language]];
}

+(NSDictionary *)getCategoryWords:(NSString *)category {// withLimit:(NSNumber *)limit {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[GetWordsDatabase getPathToCategory:category]]){
        NSDictionary *wordsDatabase  = [[NSDictionary alloc] initWithContentsOfFile:[GetWordsDatabase getPathToCategory:category]];
        //NSLog(@"GetWordsDatabase.m: %@",[GetWordsDatabase getPathToCategory:category]);
        //NSLog(@"GetWordsDatabase.m: this if.");
        return wordsDatabase;
    } else {
        [GetWordsDatabase getWords:category];
        NSDictionary *wordsDatabase  = [[NSDictionary alloc] initWithContentsOfFile:[GetWordsDatabase getPathToCategory:category]];
        //NSLog(@"GetWordsDatabase.m: %@",[GetWordsDatabase getPathToCategory:category]);
        //NSLog(@"GetWordsDatabase.m: this else.");
        return wordsDatabase;
    }

    
}


@end
