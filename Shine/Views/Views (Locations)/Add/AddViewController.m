//
//  AddViewController.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "AddViewController.h"

@implementation AddViewController

@synthesize delegate;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Add Favorite";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button-done"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(getLocation:)];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-back-split"]]];
    
    geocoder = [[Geocoder alloc] init];
    geocoder.delegate = self;
    
    displayLatLon = NO;
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)getLocation:(id)sender
{
    if (![textField.text isEqual:@""]) {
        NSLog(@"Getting location info");
        [geocoder locationForSearchString:textField.text];
        [instructions setText:@"Searching..."];
        [mapInstructions setHidden:YES];
    } else {
        [self reset];
    }
}

- (void)reset
{
    [instructions setText:@"Search for a location..."];
    [mapInstructions setHidden:YES];
}

#pragma mark - Delegates

- (IBAction)userDidBeginEditing:(id)sender {
    displayLatLon = NO;
    [self reset];
}

- (void)mapView:(MKMapView*)aMapView regionDidChangeAnimated:(BOOL)animated {
    if (displayLatLon) {
        textField.text = [NSString stringWithFormat:@"%f, %f",mapView.centerCoordinate.latitude, mapView.centerCoordinate.longitude];
        [instructions setText:@"Drag the map to choose a location,"];
        [mapInstructions setText:@"then tap \u2713 to add."];
        [mapInstructions setHidden:NO];
    }
    displayLatLon = YES;
}

#pragma mark - Location Gathering

- (void)geocoderReturnedLocation:(Location *)location
{
    if (location) {
        NSLog(@"DONE GEOCODING");
        NSLog(@"%@", location.description);
        location.listIndex = [NSNumber numberWithInt:999];
        [[Data shared] insertLocation:location];
        [self.delegate addViewControllerDidFinishWithNewLocation:location];
        [self done:self];
    } else {
        NSLog(@"location not found");
        [instructions setText:@"No location found. Try again,"];
        [mapInstructions setText:@"or use the map to choose a location."];
        [mapInstructions setHidden:NO];
    }
}

@end
