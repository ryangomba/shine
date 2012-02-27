//
//  DaysViewController.m
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "DaysView.h"

@implementation DaysView

#pragma mark - View lifecycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"Configuring days view");
        int numDays = 9;
        days = [NSMutableArray arrayWithCapacity:numDays];
        int width = [DayView width];
        for (int i=0; i<numDays; i++) {
            DayView *day = [Constructor viewNamed:@"DayView" owner:self];
            [day shiftRight:(width * i) down:0.0];
            [days addObject:day];
            [self addSubview:day];
        }
        [self setContentSize:CGSizeMake(width * numDays, 372.0)];
        [self setShowsHorizontalScrollIndicator:NO];
    }
    return self;
}

- (void)awakeFromNib
{
    // modify
}

- (void)update:(NSArray *)info
{
    NSLog(@"Updating all days");
    [days enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (info.count > idx) {
            [obj update:[info objectAtIndex:idx] darken:(idx % 2 == 1)];
        } else {
            NSLog(@"No weather for day");
        }
    }];
}

@end
