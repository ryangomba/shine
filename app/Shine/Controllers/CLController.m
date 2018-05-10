//
//  CLController.m
//  Shine
//
//  Created by Ryan Gomba on 4/15/11.
//  Copyright 2011 AppThat. All rights reserved.
//

#import "CLController.h"

@implementation CLController

SINGLETON(CLController);

@synthesize locationManager;
@synthesize lastLocation;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        shouldDelegate = NO;
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
    }
    return self;
}

- (void)startUpdatingLocation
{
    NSLog(@"Starting to update location");
    [locationManager startUpdatingLocation];
}

- (void)stopUpdatingLocation
{
    NSLog(@"Stopping location updates");
    [locationManager stopUpdatingLocation];
    shouldDelegate = NO;
}

- (void)requestCurrentLocation
{
    NSLog(@"Requested current location");
    [self startUpdatingLocation];
    shouldDelegate = YES;
    if (self.lastLocation) [self sendLocationIfValid];
    // otherwise, wait for update
}

- (void)sendLocationIfValid
{
    if ([[NSDate date] timeIntervalSinceDate:[self.lastLocation timestamp]] < 60) {
        [self.delegate didRecieveCurrentLocation:self.lastLocation];
        shouldDelegate = NO;
        // we responded, so we're done
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.lastLocation = newLocation;
    if (shouldDelegate) {
        [self sendLocationIfValid];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
    if ([error code] == kCLErrorDenied) {
        [self.delegate currentLocationRequestDidGetRejected];
    } else {
        [self.delegate currentLocationRequestDidFail];
    }
}

@end
