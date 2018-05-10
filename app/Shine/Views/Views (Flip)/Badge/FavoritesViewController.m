//
//  FavoritesViewController.m
//  Shine
//
//  Created by Ryan Gomba on 2/24/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "FavoritesViewController.h"

@implementation FavoritesViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"did load");
    [super viewDidLoad];
    shineAPIController = [[ShineAPIController alloc] init];
    shineAPIController.delegate = self;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-back"]]];
    self.tableView.sectionHeaderHeight = [ShineTableViewHeader height];
    self.tableView.rowHeight = [ShineTableViewCell height];    
    
    locations = [NSArray array];
    
    self.navigationItem.title = @"Icon Badge";
}

- (void)updateLocations
{
    locations = [[Data shared] allLocations];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"will apear");
    [self updateLocations];
    NSLog(@"%@", self.navigationItem.leftBarButtonItem.customView);
    NSLog(@"%f", self.navigationItem.leftBarButtonItem.customView.frame.origin.x);
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"did appear");
    NSLog(@"%f", self.navigationItem.leftBarButtonItem.customView.frame.origin.x);
    [self.navigationItem.leftBarButtonItem.customView shiftRight:100.0 down:4.0];
    NSLog(@"%f", self.navigationItem.leftBarButtonItem.customView.frame.origin.x);
    //self.navigationItem.leftBarButtonItem.customView = [[UIView alloc] init];
    /*[UIView animateWithDuration:0.25 animations:^{
        [self.navigationItem.leftBarButtonItem.customView shiftRight:-100.0 down:0.0];
    }];*/
}
     
- (void)dismiss:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"%f", self.navigationItem.leftBarButtonItem.customView.frame.origin.x);
    [UIView animateWithDuration:0.25 animations:^{
        [self.navigationItem.leftBarButtonItem.customView shiftRight:100.0 down:0.0];
    }];
}

#pragma mark - Table view data source

- (Location *)locationAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return nil;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShineTableViewHeader *header = [[ShineTableViewHeader alloc] init];
    [header setTitle:@"Location"];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShineTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) cell = [Constructor viewNamed:@"ShineTableViewCell" owner:self];
    cell.subtitle = nil;
    Location *location = [self locationAtIndexPath:indexPath];
    NSNumber *badgedLocation = [ShineDefaults shared].badgedLocation;
    if ((!location && !badgedLocation) || (location && badgedLocation && [location.uid isEqualToNumber:badgedLocation])) {
        cell.mark = [UIImage imageNamed:@"checked"];
    } else {
        cell.mark = nil;
    }
    switch (indexPath.row) {
        case 0:
            cell.title = @"Off";
            break;
        default:
            cell.title = [self locationAtIndexPath:indexPath].displayName;
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected!!!");
    if (indexPath.row == 0) {
        [shineAPIController disableTemperatureBadge];
    } else {
        [shineAPIController enableTemperatureBadgeWithLocation:[locations objectAtIndex:indexPath.row]];
    }
    //[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Shine API Delegate

- (void)shineAPIRequestDidSucceed
{
    NSLog(@"Shine success");
    [self.tableView reloadData];
}

- (void)shineAPIRequestDidFail
{
    NSLog(@"Shine fail");
}

@end
