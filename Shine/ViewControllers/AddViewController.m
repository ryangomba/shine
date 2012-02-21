//
//  AddViewController.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "AddViewController.h"

@implementation AddViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [navItem setTitle:@"Add Location"];
    //[navItem setLeftBarButtonItem:[Constructor barButtonItemWithImageNamed:@"add" target:self action:@selector(add:)]];
    [navItem setRightBarButtonItem:[Constructor barButtonItemWithImageNamed:@"done" target:self action:@selector(getLocation:)]];
    
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

- (void)didGeocodeLocation:(Location *)location
{
    if (location) {
        NSLog(@"DONE GEOCODING");
        NSLog(@"%@", location.description);
        [self done:self];
    } else {
        [instructions setText:@"No location found. Try again,"];
        [mapInstructions setText:@"or use the map to choose a location."];
        [mapInstructions setHidden:NO];
    }
}

@end
