//
//  DailyWeatherView.h
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "DailyReport.h"

@interface DayView : UIView {
    IBOutlet UILabel *dayLabel;
    IBOutlet UIImageView *conditionIcon;
    IBOutlet UILabel *minTempLabel;
    IBOutlet UILabel *maxTempLabel;
    IBOutlet UILabel *popLabel;
}

+ (NSInteger)width;

- (void)clear;
- (void)update:(DailyReport *)info;

@end
