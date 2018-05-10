//
//  UIView+Extra.h
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface UIView (Extra)

- (void)resizeWidth:(CGFloat)width
             height:(CGFloat)height;

- (void)moveToX:(CGFloat)x
              y:(CGFloat)y;

- (void)shiftRight:(CGFloat)x
              down:(CGFloat)y;

@end
