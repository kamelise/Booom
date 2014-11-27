//
//  CALayer+XibConfiguration.h
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (XibConfiguration)

// This assigns a CGColor to borderColor.
@property(nonatomic, assign) UIColor* borderUIColor;
@property(nonatomic, assign) UIColor* backgroundUIColor;

@end
