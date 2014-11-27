//
//  CALayer+XibConfiguration.m
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(void)setBackgroundUIColor:(UIColor*)color
{
    self.backgroundColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

-(UIColor*)backgroundUIColor
{
    return [UIColor colorWithCGColor:self.backgroundColor];
}

@end
