//
//  MainViewController.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-back"]]];
	
    navBarDropShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlay-drop-shadow"]];
    [self resetNavItem];
    
    scrollView = [[WeatherView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 416.0)];
    scrollView.delegate = self;
        
    locationsViewController = [[LocationsViewController alloc] initWithNibName:@"LocationsView" bundle:nil];
    [locationsViewController.view shiftRight:0.0 down:44.0];
    locationsViewController.delegate = self;
    locationsViewController.navController = self.navigationController;
    locationsViewController.navItem = self.navigationItem;
    
    [self.view addSubview:scrollView];
    [self.view addSubview:locationsViewController.view];
    [self.view addSubview:navBarDropShadow];
    
    NSNumber *selectedLocationID = [ShineDefaults shared].selectedLocation;
    selectedLocation = [[Data shared] location:selectedLocationID];
    [locationsViewController userChoseLocation:selectedLocation];
    
    scrollView.contentSize = CGSizeMake(320.0, 788.0);
}

- (void)resetNavItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button-settings"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(flip:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button-favorites"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(showLocationsView:)];
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish
{
    NSLog(@"flipside controller did finish; %@", lastReport);
    [scrollView update:lastReport];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"preparing");
    if ([segue.identifier isEqualToString:@"Flip"]) {
        UINavigationController *flipsideNavController = segue.destinationViewController;
        FlipsideViewController *flipsideViewController = (FlipsideViewController *)flipsideNavController.topViewController;
        flipsideViewController.delegate = self;
    }
}

- (void)didRecieveWeatherReport:(WeatherReport *)report
                    forLocation:(Location *)location
{
    selectedLocation = location;
    self.navigationItem.title = selectedLocation.displayName;
    lastReport = report;
    [scrollView update:lastReport];
}

- (void)locationsViewControllerDidHide
{
    [self resetNavItem];
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    //NSLog(@"%f", scrollView.contentOffset.y);
    navBarDropShadow.alpha = sqrt(1.0 - scrollView.contentOffset.y / 372.0);
    if (scrollView.contentOffset.y <= -50.0) {
        [scrollView setContentOffset:CGPointMake(0.0, -50.0)];
    } else if (scrollView.contentOffset.y <= 0.0) {
        [scrollView dismissHourly];
    } else if (scrollView.contentOffset.y >= 372.0) {
        [scrollView callHourly];
    }
}

#pragma mark - Actions

- (IBAction)flip:(id)sender
{
    [self performSegueWithIdentifier:@"Flip" sender:self];
}

- (IBAction)showLocationsView:(id)sender
{
    if (locationsViewController.isHidden) {
        [locationsViewController show];
    } else {
        [locationsViewController hide];
    }
}

@end
