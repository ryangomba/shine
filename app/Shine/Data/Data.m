//
//  Data.m
//  Shine
//
//  Created by Ryan Gomba on 2/21/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "Data.h"

@implementation Data

SINGLETON(Data);

- (id)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

+ (NSString *)databasePath
{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentDir stringByAppendingPathComponent:@"Shine.db"];
    return databasePath;
}

- (NSMutableArray *)allLocations
{
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[Data databasePath]];
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM locations ORDER BY list_index ASC"];
    
    while(results.next) {
        Location *location = [Location locationFromDB:results];
        [locations addObject:location];
    }
    
    if ([db hadError]) {
        NSLog(@"DB Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    [db close];
    return locations;
}

- (Location *)location:(NSNumber *)locationID
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Data databasePath]];
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM locations WHERE id = (?)", locationID];
    
    [results next];
    Location *location = [Location locationFromDB:results];
    
    if ([db hadError]) {
        NSLog(@"DB Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    [db close];
    return location;
}

- (BOOL)insertLocation:(Location *)location
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Data databasePath]];
    [db open];
    
    NSMutableDictionary *parameters = [location toDBDict];
    BOOL success = [db executeUpdate:@"INSERT INTO locations \
                    (city, state, country, latitude, longitude, list_index) \
                    VALUES (:city, :state, :country, :latitude, :longitude, :list_index)" withParameterDictionary:parameters];
    
    NSLog(@"INSERT? %d", success);
    if ([db hadError]) {
        NSLog(@"DB Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    } else {
        location.uid = [NSNumber numberWithInt:[db lastInsertRowId]];
    }
    
    [db close];
    return success;
    return YES;
}

- (BOOL)updateLocation:(Location *)location
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Data databasePath]];
    [db open];
    
    NSMutableDictionary *parameters = [location toDBDict];
    [parameters setObject:location.uid forKey:@"id"];
    
    BOOL success = [db executeUpdate:@"UPDATE locations SET \
                    city = (:city), state = (:state), country = (:country), \
                    latitude = (:latitude), longitude = (:longitude), \
                    list_index = (:list_index) \
                    WHERE id = (:id)" withParameterDictionary:parameters];
    
    NSLog(@"UPDATE? %d", success);
    if ([db hadError]) {
        NSLog(@"DB Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }

    [db close];
    return success;
}

- (BOOL)deleteLocation:(Location *)location
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Data databasePath]];
    [db open];
    
    BOOL success = [db executeUpdate:@"DELETE FROM locations WHERE id=?", location.uid];
    
    NSLog(@"DELETE? %d", success);
    if ([db hadError]) {
        NSLog(@"DB Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    [db close];
    return success;
}

@end
