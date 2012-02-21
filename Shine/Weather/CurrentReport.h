//
//  HourlyReport.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface CurrentReport : NSObject

#pragma mark - Properties

// time
@property (strong, nonatomic) NSDate *date;

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

// humidity
@property (strong, nonatomic) NSNumber *relHumidity;

#pragma mark - Displays

@property (readonly) UIImage *displayCondition;
@property (readonly) NSString *displayTemp;
@property (readonly) NSString *displayWindSpeed;

#pragma mark - Constructors

+ (CurrentReport *)report:(NSDictionary *)info;

@end
