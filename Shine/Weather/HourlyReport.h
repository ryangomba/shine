//
//  HourlyReport.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface HourlyReport : NSObject

#pragma mark - Properties

// time
@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSNumber *hour;

// condition
@property (strong, nonatomic) NSString *condition;

// temperatures
@property (strong, nonatomic) NSNumber *temp;
@property (strong, nonatomic) NSNumber *dewpoint;

// feels like
@property (strong, nonatomic) NSNumber *feelsLike;
@property (strong, nonatomic) NSNumber *windChill;
@property (strong, nonatomic) NSNumber *heatIndex;

// wind
@property (strong, nonatomic) NSNumber *windSpeed;
@property (strong, nonatomic) NSString *windDirection;

// precipitation
@property (strong, nonatomic) NSNumber *amountPre;
@property (strong, nonatomic) NSNumber *percentPre;
@property (strong, nonatomic) NSNumber *amountSnow;

// humidity
@property (strong, nonatomic) NSNumber *humidity;

#pragma mark - Accessors

@property (readonly) NSString *displayDay;
@property (readonly) NSString *displayHour;
@property (readonly) UIImage *displayCondition;
@property (readonly) NSString *displayTemp;
@property (readonly) NSString *displayWindSpeed;
@property (readonly) NSString *displayPop;

#pragma mark - Constructors

+ (HourlyReport *)report:(NSDictionary *)info;

@end
