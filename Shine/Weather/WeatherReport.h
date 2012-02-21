//
//  WeatherReport.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "Location.h"
#import "CurrentReport.h"
#import "DailyReport.h"
#import "HourlyReport.h"

@interface WeatherReport : NSObject

@property (strong, nonatomic) Location *location;
@property (strong, nonatomic) CurrentReport *current;
@property (strong, nonatomic) NSMutableArray *hours;
@property (strong, nonatomic) NSMutableArray *days;

+ (NSString *)windUnit;

+ (UIImage *)iconForCondition:(NSString *)condition
                         hour:(NSInteger)hour;

@end
