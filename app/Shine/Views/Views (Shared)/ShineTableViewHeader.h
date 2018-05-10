//
//  ShineTableViewHeader.h
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface ShineTableViewHeader : UIView {
    UILabel *label;
}

+ (NSInteger)height;

- (void)setTitle:(NSString *)title;

@end
