//
//  ShineTableViewHeader.m
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "ShineTableViewHeader.h"

@implementation ShineTableViewHeader

+ (NSInteger)height
{
    return 60;
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0.0, 0.0, 320.0, 60.0)];
    if (self) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(18, 22, self.frame.size.width, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textColor = [[UIColor alloc] initWithRed:(125/255.0) green:(183/255.0) blue:(200/255.0) alpha:1.0];
        label.shadowColor = [UIColor blackColor];
        label.shadowOffset = CGSizeMake(0, -1);
        [self addSubview:label];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    [label setText:[title uppercaseString]];
}

@end
