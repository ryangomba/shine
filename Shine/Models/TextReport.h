//
//  TextReport.h
//  Shine
//
//  Created by Ryan Gomba on 2/23/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface TextReport : NSObject

#pragma mark - Properties

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *condition;
@property (strong, nonatomic) NSString *usDescription;
@property (strong, nonatomic) NSString *metricDescription;

#pragma mark - Accessors

@property (readonly) NSString *displayTitle;
@property (readonly) UIImage *displayCondition;
@property (readonly) NSString *displayDescription;

#pragma mark - Constructors

+ (TextReport *)report:(NSDictionary *)info;

@end
