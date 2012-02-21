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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        label =[[UILabel alloc] initWithFrame:CGRectMake(20, 22, self.frame.size.width, 30)];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
