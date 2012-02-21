//
//  MainViewController.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "FlipsideViewController.h"
#import "ShineNavigationBar.h"
#import "LocationBarView.h"
#import "WeatherView.h"

#import "WeatherController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, WeatherControllerDelegate, UIScrollViewDelegate> {
    
    IBOutlet ShineNavigationBar *navBar;
    LocationBarView *locationBar;
    WeatherView *scrollView;
    
    WeatherController *weatherController;
}

- (IBAction)flip:(id)sender;
- (IBAction)locate:(id)sender;

@end
