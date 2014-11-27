//
//  UIView+FrameAdditions.m
//  Booom
//
//  Created by Samka on 14/10/14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "UIView+FrameAdditions.h"


@implementation UIView (FrameAdditions)
-(float) x {
    return self.frame.origin.x;
}

-(void) setX:(float) newX {
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

-(float) y {
    return self.frame.origin.y;
}

-(void) setY:(float) newY {
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

-(float) width {
    return self.frame.size.width;
}

-(void) setWidth:(float) newWidth {
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}

-(float) height {
    return self.frame.size.height;
}

-(void) setHeight:(float) newHeight {
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}
/*
-(float) leftX {
    return self.frame.origin.x+self.frame.size.width;
}

-(float) downY {
    return self.frame.origin.y+self.frame.size.height;
}

-(void) setLeftX:(float) newX {
}

-(void) setDownY:(float) newY {
}
*/
@end
