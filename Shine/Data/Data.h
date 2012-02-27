//
//  Data.h
//  Shine
//
//  Created by Ryan Gomba on 2/21/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "FMDatabase.h"
#import "FMResultSet.h"

#import "Location.h"

@interface Data : NSObject

+ (Data *)shared;

+ (NSString *)databasePath;

- (NSMutableArray *)allLocations;

- (Location *)location:(NSNumber *)locationID;

- (BOOL)insertLocation:(Location *)location;
- (BOOL)updateLocation:(Location *)location;
- (BOOL)deleteLocation:(Location *)location;

@end
