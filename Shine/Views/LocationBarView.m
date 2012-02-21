//
//  LocationBar.m
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "LocationBarView.h"

@implementation LocationBarView

#pragma mark - View setup

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // custom
    }
    return self;
}

- (void)awakeFromNib
{
    [self clear];
}

#pragma mark - View generation

- (void)clear
{
    title.text = nil;
}

-(void)update:(Location *)location
{
    title.text = location.name;
}

@end
