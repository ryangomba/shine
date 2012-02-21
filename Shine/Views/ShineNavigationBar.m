//
//  ShineNavigationController.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "ShineNavigationBar.h"

@implementation ShineNavigationBar

- (void)drawRect:(CGRect)rect
{
    NSLog(@"Drawing custom NavBar");
    [super drawRect:rect];
    UIImage *imageBackground = [UIImage imageNamed: @"top-bg"];
    [imageBackground drawInRect: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) ];
}

@end
