//
//  UILabel+Boldify.m
//  Booom
//
//  Created by Alena Shilova on 1/28/15.
//  Copyright (c) 2015 kamelise. All rights reserved.
//

#import "UILabel+Boldify.h"

@implementation UILabel (Boldify)
- (void)boldRange:(NSRange)range {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font.pointSize]} range:range];
    self.attributedText = attributedText;
}

- (void)colorRange:(NSRange)range withColor:(UIColor*)color {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    [attributedText setAttributes:@{NSForegroundColorAttributeName:color} range:range];
    self.attributedText = attributedText;
}

- (void)boldSubstring:(NSString*)substring {
    NSRange range = [self.text rangeOfString:substring];
    [self boldRange:range];
}
- (void)colorSubstring:(NSString*)substring withColor:(UIColor*)color{
    NSRange range = [self.text rangeOfString:substring];
    [self colorRange:range withColor:color];
}
@end