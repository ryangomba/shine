//
//  CLController.h
//  Shine
//
//  Created by Ryan Gomba on 4/15/11.
//  Copyright 2011 AppThat. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@protocol CLControllerDelegate
- (void)didRecieveCurrentLocation:(CLLocation *)location;
- (void)currentLocationRequestDidFail;
- (void)currentLocationRequestDidGetRejected;
@end

@interface CLController : NSObject <CLLocationManagerDelegate> {
    BOOL shouldDelegate;
}

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *lastLocation;
@property (strong, nonatomic) id delegate;

+ (CLController *)shared;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;
- (void)requestCurrentLocation;
- (void)sendLocationIfValid;

@end
