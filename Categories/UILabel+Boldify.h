//
//  UILabel+Boldify.h
//  Booom
//
//  Created by Alena Shilova on 1/28/15.
//  Copyright (c) 2015 kamelise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Boldify)
- (void) boldSubstring: (NSString*) substring;
- (void) boldRange: (NSRange) range;
- (void) colorRange:(NSRange)range withColor:(UIColor*)color;
- (void) colorSubstring:(NSString*)substring withColor:(UIColor*)color;
@end