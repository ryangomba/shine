//
//  AddViewController.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "Geocoder.h"
#import <Mapkit/Mapkit.h>

@protocol AddViewControllerDelegate
- (void)addViewControllerDidFinishWithNewLocation:(Location *)location;
@end

@interface AddViewController : UIViewController <ShineGeocoderDelegate, MKMapViewDelegate> {
    IBOutlet UITextField *textField;
    IBOutlet UILabel *instructions;
    IBOutlet UILabel *mapInstructions;
    IBOutlet MKMapView *mapView;
    
    Geocoder *geocoder;
    
    BOOL displayLatLon;
}

@property (weak, nonatomic) id <AddViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
- (IBAction)getLocation:(id)sender;

- (void)reset;

- (IBAction)userDidBeginEditing:(id)sender;

@end
