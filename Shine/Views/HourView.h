//
//  HourViewController.h
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "WeatherReport.h"
#import "HourlyReport.h"

@interface HourView : UITableViewCell {
    IBOutlet UILabel *hourLabel;
    IBOutlet UIImageView *conditionIcon;
    IBOutlet UILabel *tempLabel;
    IBOutlet UILabel *popLabel;
    IBOutlet UILabel *windSpeedLabel;
    IBOutlet UILabel *windUnitLabel;
}

+ (NSInteger)height;

- (void)clear;
- (void)update:(HourlyReport *)hourlyReport;

@end
