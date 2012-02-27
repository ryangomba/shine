//
//  UIView+Extra.m
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "UIView+Extra.h"

@implementation UIView (Extra)

- (void)resizeWidth:(CGFloat)width
             height:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
}

- (void)moveToX:(CGFloat)x y:(CGFloat)y
{
    self.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
}

- (void)shiftRight:(CGFloat)x
              down:(CGFloat)y
{
    self.frame = CGRectMake(self.frame.origin.x + x, self.frame.origin.y + y, self.frame.size.width, self.frame.size.height);
}

@end
