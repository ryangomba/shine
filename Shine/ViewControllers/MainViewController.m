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
	
    UINavigationItem *navItem = [navBar.items objectAtIndex:0];
    [navItem setTitle:@"Weather"];
    [navItem setLeftBarButtonItem:[Constructor barButtonItemWithImageNamed:@"favorites" target:self action:@selector(flip:)]];
    [navItem setRightBarButtonItem:[Constructor barButtonItemWithImageNamed:@"locate" target:self action:@selector(locate:)]];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-back"]]];
    
    scrollView = [[WeatherView alloc] initWithFrame:CGRectMake(0.0, 44.0, 320.0, 416.0)];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    locationBar = [Constructor viewNamed:@"LocationBarView" owner:self];
    [locationBar shiftRight:0.0 down:44.0];
    [self.view addSubview:locationBar];
    
    weatherController = [[WeatherController alloc] init];
    [weatherController setDelegate:self];
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Flip"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark - Actions

- (IBAction)flip:(id)sender {
    [self performSegueWithIdentifier:@"Flip" sender:self];
}

- (IBAction)locate:(id)sender {
    //NSLog(@"Locating");
    NSLog(@"Sending request");
    [weatherController getWeather];
    //[scrollView update:nil];
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    int offset = scrollView.contentOffset.y;
    if (offset <= 200 && offset >= 0) {
        double quad = offset/100.0;
        [locationBar setAlpha:1.0 - (quad*quad*quad*quad)];
    }
}

#pragma mark - Weather

- (void)didRecieveWeather:(WeatherReport *)weather
{
    NSLog(@"%@", weather);
    [locationBar update:weather.location];
    [scrollView update:weather];
}

@end
