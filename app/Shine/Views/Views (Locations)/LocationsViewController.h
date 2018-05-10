//
//  LocationsViewController.h
//  Shine
//
//  Created by Ryan Gomba on 2/21/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "Geocoder.h"
#import "WeatherController.h"
#import "AddViewController.h"

#import "ErrorBarView.h"
#import "LocationCellView.h"

@protocol LocationsViewControllerDelegate
- (void)locationsViewControllerDidHide;
- (void)didRecieveWeatherReport:(WeatherReport *)report forLocation:(Location *)location;
@end

@interface LocationsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, CLControllerDelegate, WeatherControllerDelegate, ShineGeocoderDelegate, UITextFieldDelegate, AddViewControllerDelegate> {
    IBOutlet UIView *slideView;
    IBOutlet UITableView *listView;
    IBOutlet UITextField *searchField;
    IBOutlet UIActivityIndicatorView *searchFieldActivityIndicator;
    UITapGestureRecognizer *dismissSearchFieldTap;
    UIView *listViewOverlayView;
    
    UIBarButtonItem *reorderButton;
    UIBarButtonItem *addButton;
    
    ErrorBarView *errorBar;
    
    NSMutableArray *locations;
    Location *selectedLocation;
    CLController *locationController;
    WeatherController *weatherController;
    Geocoder *geocoder;
}

@property (weak, nonatomic) id <LocationsViewControllerDelegate> delegate;

@property (strong, nonatomic) AddViewController *addViewController;

@property (weak, nonatomic) UINavigationController *navController;
@property (weak, nonatomic) UINavigationItem *navItem;

@property (readonly) BOOL isHidden;

- (void)userChoseLocation:(Location *)location;
- (void)updateLocations;

- (void)show;
- (void)hide;

- (void)showError:(NSString *)error;

- (IBAction)submitSearchField:(id)sender;
- (void)dismissSearchField:(id)sender;

- (Location *)locationForIndexPath:(NSIndexPath *)indexPath;

- (void)startEditing;
- (void)endEditing;

- (IBAction)reorderLocations:(id)sender;
- (IBAction)addFavorite:(id)sender;

@end
