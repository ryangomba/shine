//
//  ShineTableViewCell.m
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "ShineTableViewCell.h"

@implementation ShineTableViewCell

+ (NSInteger)height
{
    return 50;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.frame.size.width, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor lightTextColor];
        label.shadowColor = [UIColor blackColor];
        label.shadowOffset = CGSizeMake(0, -1);
        [self addSubview:label];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"Drawing custom cell");
    [super drawRect:rect];
    UIImage *imageBackground = [UIImage imageNamed: @"list-item"];
    [imageBackground drawInRect: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (void)setTitle:(NSString *)title
{
    [label setText:title];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
