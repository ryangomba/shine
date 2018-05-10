//
//  LocationCellView.m
//  Shine
//
//  Created by Ryan Gomba on 2/21/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "LocationCellView.h"

@implementation LocationCellView

@synthesize checked, thinking;
@synthesize leftIconView, rightIconView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionOld context:nil];
        [self.contentView removeObserver:self forKeyPath:@"frame"];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)title
{
    return titleLabel.text;
}

- (void)setTitle:(NSString *)title
{
    titleLabel.text = title;
}

- (BOOL)checked
{
    return !rightIconView.isHidden;
}

- (void)setChecked:(BOOL)check
{
    if (check) {
        self.thinking = NO;
        titleLabel.textColor = [UIColor colorWithRed:(45/255.0) green:(137/255.0) blue:(170/255.0) alpha:1.0];
        //titleLabel.font = [UIFont boldSystemFontOfSize:16];
    } else {
        titleLabel.textColor = [UIColor darkTextColor];
        //titleLabel.font = [UIFont systemFontOfSize:16];
    }
    rightIconView.hidden = !check;
}

- (BOOL)thinking
{
    return thinkingIndicator.isAnimating;
}

- (void)setThinking:(BOOL)think
{
    if (think) {
        //self.checked = NO;
        [thinkingIndicator startAnimating];
    }
    else [thinkingIndicator stopAnimating];
}

- (void)disable
{
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
        leftIconView.alpha = 0.5;
        titleLabel.alpha = 0.5;
        rightIconView.alpha = 0.5;
    }];
}

- (void)enable
{
    self.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.2 animations:^{
        leftIconView.alpha = 1.0;
        titleLabel.alpha = 1.0;
        rightIconView.alpha = 1.0;
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = CGRectMake(0,                                          
                                        self.contentView.frame.origin.y,
                                        self.contentView.frame.size.width, 
                                        self.contentView.frame.size.height);
    
    if (self.editing) 
    {
        float indentPoints = self.indentationLevel * self.indentationWidth;
        
        self.contentView.frame = CGRectMake(indentPoints,
                                            self.contentView.frame.origin.y,
                                            self.contentView.frame.size.width - indentPoints, 
                                            self.contentView.frame.size.height);    
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing) {
        [UIView animateWithDuration:0.2 animations:^{
            rightIconView.alpha = 0.0;
            leftIconView.alpha = 0.0;
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            rightIconView.alpha = 1.0;
            leftIconView.alpha = 1.0;
        }];
    }
}

@end
