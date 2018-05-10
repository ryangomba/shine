//
//  ShineTableViewCell.m
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "ShineTableViewCell.h"

@implementation ShineTableViewCell

@synthesize mark;

- (void)awakeFromNib
{
    UIView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list-item"]];
    self.backgroundView = background;
    
    UIView *backgroundDown = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list-item-down"]];
    self.selectedBackgroundView = backgroundDown;
}

+ (NSInteger)height
{
    return 50;
}

- (NSString *)title
{
    return titleLabel.text;
}

- (void)setTitle:(NSString *)title
{
    titleLabel.text = title;
}

- (NSString *)subtitle
{
    return detailLabel.text;
}

- (void)setSubtitle:(NSString *)subtitle
{
    detailLabel.text = subtitle;
}

- (UIImage *)mark
{
    return markView.image;
}

- (void)setMark:(UIImage *)aMark
{
    markView.image = aMark;
}

- (BOOL)marked
{
    return !markView.isHidden;
}

- (void)setMarked:(BOOL)marked
{
    markView.hidden = !marked;
}

@end
