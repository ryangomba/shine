//
//  UIView+Extra.m
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "UIView+Extra.h"

@implementation UIView (Extra)

- (void)shiftRight:(CGFloat)x
              down:(CGFloat)y
{
    self.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
}

@end
