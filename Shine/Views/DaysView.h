//
//  DaysViewController.h
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "DayView.h"

@interface DaysView : UIScrollView {
    NSMutableArray *days;
}

- (void)update:(NSArray *)info;

@end
