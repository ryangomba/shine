//
//  DailyReport.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "WeatherReport.h"

@interface DailyReport : NSObject

#pragma mark - Properties

// day
@property (strong, nonatomic) NSString *day;

// condition
@property (strong, nonatomic) NSString *condition;

// temperatures
@property (strong, nonatomic) NSNumber *minTemp;
@property (strong, nonatomic) NSNumber *maxTemp;

// wind
@property (strong, nonatomic) NSNumber *windSpeed;
@property (strong, nonatomic) NSString *windDirection;

// precipitation
@property (strong, nonatomic) NSNumber *amountPre;
@property (strong, nonatomic) NSNumber *percentPre;
@property (strong, nonatomic) NSNumber *amountSnow;

// humidity
@property (strong, nonatomic) NSNumber *humidity;

#pragma mark - Displays

@property (readonly) NSString *displayDay;
@property (readonly) UIImage *displayCondition;
@property (readonly) NSString *displayMinTemp;
@property (readonly) NSString *displayMaxTemp;
@property (readonly) NSString *displayPop;

#pragma mark - Constructors

+ (DailyReport *)report:(NSDictionary *)info;

@end
