//
//  Location.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface Location : NSObject

@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *country;

@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;

@property (strong, nonatomic) NSNumber *uid;
@property (strong, nonatomic) NSNumber *listIndex;

@property (readonly) NSString *displayName;
@property (readonly) BOOL isCurrentLocation;

+ (Location *)locationWithCity:(NSString *)city
                         state:(NSString *)state
                       country:(NSString *)country
                      latitude:(NSNumber *)latitude
                     longitude:(NSNumber *)longitude;

+ (Location *)locationFromWU:(NSDictionary *)info;

+ (Location *)locationFromDB:(FMResultSet *)results;

- (NSMutableDictionary *)toDBDict;

@end
