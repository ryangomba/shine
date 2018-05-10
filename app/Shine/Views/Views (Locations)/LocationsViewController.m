//
//  LocationsViewController.m
//  Shine
//
//  Created by Ryan Gomba on 2/21/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "CLController.h"
#import "LocationsViewController.h"

@implementation LocationsViewController

@synthesize delegate;
@synthesize addViewController = _addViewController;
@synthesize navController, navItem;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.hidden = YES;
    
    reorderButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button-reorder"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(reorderLocations:)];
    addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button-add"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(addFavorite:)];
    
    errorBar = [Constructor viewNamed:@"ErrorBarView" owner:self];
    [errorBar shiftRight:0.0 down:-44.0];
    errorBar.hidden = YES; // TODO
    [self.view addSubview:errorBar];
    
    listViewOverlayView = [[UIView alloc] initWithFrame:listView.frame];
    [listViewOverlayView moveToX:0.0 y:0.0];
    listViewOverlayView.backgroundColor = [UIColor blackColor];
    listViewOverlayView.alpha = 0.0;
    listViewOverlayView.hidden = YES;
    [listView addSubview:listViewOverlayView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
    
    [self updateLocations];
    
    [CLController shared].delegate = self;
    
    weatherController = [[WeatherController alloc] init];
    [weatherController setDelegate:self];
    geocoder = [[Geocoder alloc] init];
    geocoder.delegate = self;
    
    dismissSearchFieldTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSearchField:)];
}

- (void)updateLocations
{
    NSNumber *selectedLocationID = [ShineDefaults shared].selectedLocation;
    locations = [[Data shared] allLocations];
    NSLog(@"NUM LOCATIONS: %d", locations.count);
    [locations enumerateObjectsUsingBlock:^(Location *loc, NSUInteger i, BOOL *stop) {
        NSLog(@"%@: %@", loc.listIndex, loc.displayName);
        if ([loc.uid isEqualToNumber:selectedLocationID]) {
            NSLog(@"FOUND IT");
            selectedLocation = loc;
        }
    }];
    [listView reloadData];
}

#pragma mark - Show & Hide

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isEqual:self.view]) return YES;
    return NO;
}

- (void)tapped:(UITapGestureRecognizer *)recognizer {
    [self hide];
}

- (BOOL)isHidden
{
    return self.view.isHidden;
}

- (void)show
{
    navItem.title = @"Locations";
    navItem.leftBarButtonItem = reorderButton;
    navItem.rightBarButtonItem = addButton;
    
    [self updateLocations];
    if (self.view.isHidden) {
        float maxHeight = 360.0;
        float height = locations.count * 56.0 + 4.0;
        if (height > maxHeight) {
            height = maxHeight;
            listView.bounces = YES;
        } else {
            listView.bounces = NO;
        }
        [slideView resizeWidth:320.0 height:height + 56.0];
        [slideView moveToX:0.0 y:(-height - 56.0 - 44.0)];
        self.view.hidden = NO;
                
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75];
            [slideView shiftRight:0.0 down:(height + 56.0)];
        } completion:^(BOOL finished) {
            //
        }];
    }
}

- (void)hide
{
    navItem.title = selectedLocation.displayName;
    
    [weatherController cancelAllRequests];
    [self dismissSearchField:self];
    [self endEditing];
    
    [listView reloadData];
    
    if (!self.view.isHidden) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            [slideView shiftRight:0.0 down:(-slideView.frame.size.height)];
        } completion:^(BOOL finished) {
            self.view.hidden = YES;
        }];
    }
    [self.delegate locationsViewControllerDidHide];
}

- (void)addFavorite:(id)sender
{
    [self.navController pushViewController:self.addViewController animated:YES];
}

#pragma mark - Search

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    listViewOverlayView.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        listViewOverlayView.alpha = 0.75;
    }];
    [listView addGestureRecognizer:dismissSearchFieldTap];
}

- (void)dismissSearchField:(id)sender
{
    NSLog(@"dismiss");
    [searchFieldActivityIndicator stopAnimating];
    [searchField resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        listViewOverlayView.alpha = 0.0;
    } completion:^(BOOL finished) {
        listViewOverlayView.hidden = YES;
        [listView removeGestureRecognizer:dismissSearchFieldTap];
    }];
}

- (void)submitSearchField:(id)sender
{
    NSLog(@"submitted");
    [searchFieldActivityIndicator startAnimating];
    [geocoder locationForSearchString:searchField.text];
}

- (void)geocoderReturnedLocation:(Location *)location
{
    if (location) {
        NSLog(@"got searhed location");
        [weatherController getWeatherForLocation:location];
    } else {
        NSLog(@"geocoder failed");
        // error TODO
    }
}

#pragma mark - Weather

- (void)userChoseLocation:(Location *)location
{
    NSLog(@"chose!");
    navItem.title = @"Loading...";
    if (location.isCurrentLocation) {
        [locationController requestCurrentLocation];
    } else {
        [weatherController getWeatherForLocation:location];
    }
}

- (void)didRecieveWeather:(WeatherReport *)weather
              forLocation:(Location *)location
{
    NSLog(@"%@", weather);
    selectedLocation = location;
    NSNumber *locationID = location.uid;
    if (!locationID) locationID = [NSNumber numberWithInt:0];
    [ShineDefaults shared].selectedLocation = locationID;
    [self.delegate didRecieveWeatherReport:weather forLocation:location];
    [self hide];
}

- (void)didRecieveWeatherError:(NSError *)error forLocation:(Location *)location
{
    [self showError:@"Weather Request Failed"];
}

#pragma mark - Location Delegate

- (void)didRecieveCurrentLocation:(CLLocation *)location
{
    NSLog(@"Recieved needed location");
    NSLog(@"%@", location.description);
    [locationController stopUpdatingLocation];
    Location *currentLocation = [locations objectAtIndex:0];
    currentLocation.latitude = [NSNumber numberWithFloat:location.coordinate.latitude];
    currentLocation.longitude = [NSNumber numberWithFloat:location.coordinate.longitude];
    [weatherController getWeatherForLocation:currentLocation];
}

- (void)currentLocationRequestDidFail
{
    [self showError:@"Couldn't determine location"];
}

- (void)currentLocationRequestDidGetRejected
{
    [self showError:@"Location Services Disabled"];
    /*UIAlertView *locationServicesDisabled = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"Enable location services to retrieve weather for your current location" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
     [locationServicesDisabled show];*/
}

#pragma mark - Errors

- (void)showError:(NSString *)error
{
    NSLog(@"Showing error");
    errorBar.title = error;
    [UIView animateWithDuration:0.5 animations:^{
        [errorBar shiftRight:0.0 down:88.0];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:2.0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            [errorBar shiftRight:0.0 down:-88.0];
        } completion:^(BOOL finished) {
            // done
        }];
    }];
}

#pragma mark - TableView Data Source

- (Location *)locationForIndexPath:(NSIndexPath *)indexPath
{
    return [locations objectAtIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return locations.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *header = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list-separator"]];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationCellView *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"QuickLocationCell"];
        if (!cell) cell = [Constructor viewNamed:@"LocationCellView" owner:self];
        Location *location = [locations objectAtIndex:indexPath.row];
        if ([location isEqual:selectedLocation]) cell.checked = YES;
        else cell.checked = NO;
        cell.title = location.displayName;
        if (indexPath.row == 0) cell.leftIconView.image = [UIImage imageNamed:@"list-icon-location"];
        else cell.leftIconView.image = [UIImage imageNamed:@"list-icon-star"];
        cell.rightIconView.image = [UIImage imageNamed:@"checked-light"];
    }
    return cell;
}

#pragma mark - TableView Delegate (Selection)

- (AddViewController *)addViewController
{
    if (!_addViewController) {
        _addViewController = [[AddViewController alloc] initWithNibName:@"AddView" bundle:nil];
        _addViewController.delegate = self;
    }
    return _addViewController;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Location *location = [locations objectAtIndex:indexPath.row];
    if (![location isEqual:selectedLocation]) {
        LocationCellView *cell = (LocationCellView *)[listView cellForRowAtIndexPath:indexPath];
        [cell setThinking:YES];
        [ShineDefaults shared].selectedLocation = location.uid;
        [self userChoseLocation:location];
    } else {
        NSLog(@"Same location. Do nothing.");
        [self hide];
    }
}

#pragma mark - TableView Delegate (Moving)

- (void)reorderLocations:(id)sender
{
    if ([listView isEditing]) [self endEditing];
    else [self startEditing];
}

- (void)startEditing {    
    //reorderButton.selected = YES;
    [listView setEditing:YES animated:YES];
    [(LocationCellView *)[listView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] disable];
    [(LocationCellView *)[listView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]] disable];
}

- (void)endEditing {
    //reorderButton.selected = NO;
    [listView setEditing:NO animated:YES];
    [(LocationCellView *)[listView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] enable];
    [(LocationCellView *)[listView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]] enable];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) return YES;
    return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if ((sourceIndexPath.section != proposedDestinationIndexPath.section) || proposedDestinationIndexPath == 0) {
        return sourceIndexPath;
    }
    return proposedDestinationIndexPath;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath 
{
    Location *location = [self locationForIndexPath:sourceIndexPath];
    NSLog(@"%@", location);
    [locations removeObject:location];
    [locations insertObject:location atIndex:destinationIndexPath.row];
    [locations enumerateObjectsUsingBlock:^(Location *loc, NSUInteger i, BOOL *stop) {
        loc.listIndex = [NSNumber numberWithInt:i];
        NSLog(@"%@: %@", loc.listIndex, loc.displayName);
        [[Data shared] updateLocation:loc];
    }];
}

#pragma mark - TableView Delegate (Editing)

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) return YES;
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        NSArray *toDelete = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:toDelete withRowAnimation:UITableViewRowAnimationFade];
        Location *location = [locations objectAtIndex:indexPath.row];
        [locations removeObjectAtIndex:indexPath.row];
        [[Data shared] deleteLocation:location];
        [tableView endUpdates];
    }
}

#pragma mark - Delegate

- (void)addViewControllerDidFinishWithNewLocation:(Location *)location
 {
    NSLog(@"got new location. updating list");
    [listView beginUpdates];
    [locations addObject:location];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(locations.count - 1) inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [listView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [listView endUpdates];
    [locations enumerateObjectsUsingBlock:^(Location *loc, NSUInteger i, BOOL *stop) {
        NSLog(@"%@: %@", loc.listIndex, loc.displayName);
    }];
 }
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([[segue identifier] isEqualToString:@"Add"]) {
         [[segue destinationViewController] setDelegate:self];
     }
 }

@end
