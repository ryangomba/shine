//
//  MainViewController.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "CLController.h"

#import "FlipsideViewController.h"
#import "WeatherView.h"
#import "LocationsViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, LocationsViewControllerDelegate, UIScrollViewDelegate> {
    WeatherView *scrollView;
    
    Location *selectedLocation;
    LocationsViewController *locationsViewController;
    UIImageView *navBarDropShadow;
    WeatherReport *lastReport;
}

- (void)resetNavItem;

- (IBAction)flip:(id)sender;
- (IBAction)showLocationsView:(id)sender;

@end
