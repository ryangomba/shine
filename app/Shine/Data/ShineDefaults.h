//
//  ShineDefaults.h
//  Shine
//
//  Created by Ryan Gomba on 2/24/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface ShineDefaults : NSObject

@property (weak, nonatomic) NSString *deviceToken;

@property (weak, nonatomic) NSNumber *selectedLocation;
@property (weak, nonatomic) NSNumber *badgedLocation;

@property (assign, nonatomic) BOOL metricTemp;
@property (assign, nonatomic) BOOL metricWind;
@property (assign, nonatomic) BOOL militaryClock;

+ (ShineDefaults *)shared;

+ (id)objectForKey:(NSString *)key;
+ (void)setObject:(id)object forKey:(NSString *)key;

@end
