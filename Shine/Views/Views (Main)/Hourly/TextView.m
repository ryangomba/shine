//
//  TextView.m
//  Shine
//
//  Created by Ryan Gomba on 2/23/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "TextView.h"

@implementation TextView

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-pattern"]];
}

- (void)update:(TextReport *)info
{
    titleLabel.text = info.displayTitle;
    descriptionLabel.text = info.displayDescription;
    conditionIcon.image = info.displayCondition;
    
    [descriptionLabel sizeToFit];
}

+ (NSInteger)heightWithDescription:(NSString *)description
{
    CGSize size = [description sizeWithFont:[UIFont systemFontOfSize:15]
                          constrainedToSize:CGSizeMake(240.0, 999.9)
                              lineBreakMode:UILineBreakModeWordWrap];
    return size.height + 52;
}

@end
