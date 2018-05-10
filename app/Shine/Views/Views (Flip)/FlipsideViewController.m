//
//  FlipsideViewController.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "FlipsideViewController.h"

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize favoritesViewController = _favoritesViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    [navItem setTitle:@"Settings"];
    //[navItem setLeftBarButtonItem:[Constructor barButtonItemWithImageNamed:@"add" target:self action:@selector(add:)]];
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button-done"]
                                                                  style:UIBarButtonItemStylePlain 
                                                                 target:self
                                                                 action:@selector(done:)];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-back"]]];
    
    navBarLine = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 1.0)];
    navBarLine.backgroundColor = [UIColor colorWithWhite:255.0 alpha:0.1];
    [self.view addSubview:navBarLine];
    navBarDropShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlay-drop-shadow"]];
    navBarDropShadow.alpha = 0.0;
    [self.view addSubview:navBarDropShadow];
    
    listView.separatorColor = [UIColor clearColor];
}

- (FavoritesViewController *)favoritesViewController
{
    if (!_favoritesViewController) {
        _favoritesViewController = [[FavoritesViewController alloc] initWithNibName:@"FavoritesView" bundle:nil];
    }
    return _favoritesViewController;
}

- (void)viewDidAppear:(BOOL)animated
{
    [listView reloadRowsAtIndexPaths:listView.indexPathsForSelectedRows withRowAnimation:UITableViewRowAnimationNone];
    [super viewDidAppear:animated];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float percent = sqrt(scrollView.contentOffset.y / 60.0);
    if (percent <= 1.0) {
        navBarLine.alpha = 1.0 - percent;
        navBarDropShadow.alpha = percent;
    }
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    NSLog(@"DONE");
    NSLog(@"%@", self.delegate);
    [self.delegate flipsideViewControllerDidFinish];
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - TableView Cells

- (ShineTableViewCell *)pushNotificationCellWithTitle:(NSString *)title subtitle:(NSString *)subtitle
{
    ShineTableViewCell *cell = [listView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) cell = [Constructor viewNamed:@"ShineTableViewCell" owner:self];
    cell.mark = [UIImage imageNamed:@"ios-disclosure-indicator"];
    cell.title = title;
    cell.subtitle = subtitle;
    return cell;
}

- (ShineTableViewCell *)preferencesCellWithTitle:(NSString *)title
{
    ShineTableViewCell *cell = [listView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) cell = [Constructor viewNamed:@"ShineTableViewCell" owner:self];
    cell.mark = [UIImage imageNamed:@"checked"];
    cell.title = title;
    cell.subtitle = nil;
    return cell;
}

- (UITableViewCell *)pushNotificationCellForRow:(NSInteger)row
{
    NSString *title;
    NSString *subtitle;
    switch (row) {
        case FlipsideRowPushBadge:
            title = @"Temperature Badge";
            if ([ShineDefaults shared].badgedLocation) subtitle = @"On";
            else subtitle = @"Off";
            break;
        case FlipsideRowPushReport:
            title = @"Weather Reports";
            subtitle = @"None";
            break;
        default:
            break;
    }
    ShineTableViewCell *cell = [self pushNotificationCellWithTitle:title subtitle:subtitle];
    return cell;
}

- (UITableViewCell *)preferenceCellForRow:(NSInteger)row
{
    NSString *title;
    BOOL checked;
    switch (row) {
        case FlipsideRowMetricTemp:
            title = @"Use metric temperature";
            checked = [[ShineDefaults shared] metricTemp];
            break;
        case FlipsideRowMetricWind:
            title = @"Use metric wind speed";
            checked = [[ShineDefaults shared] metricWind];
            break;
        case FlipsideRow24HrClock:
            title = @"Use 24-hour clock";
            checked = [[ShineDefaults shared] militaryClock];
            break;
        default:
            break;
    }
    ShineTableViewCell *cell = [self preferencesCellWithTitle:title];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.marked = checked;
    return cell;
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case FlipsideSectionFooter:
            return 0;
        default:
            return [ShineTableViewHeader height];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShineTableViewHeader *header = [[ShineTableViewHeader alloc] init];
    switch (section) {
        case FlipsideSectionPush:
            [header setTitle:@"Push Notifications"];
            break;
        case FlipsideSectionPreferences:
            [header setTitle:@"Preferences"];
            break;
        default:
            break;
    }
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case FlipsideSectionPush:
            return 2;
        case FlipsideSectionPreferences:
            return 3;
        case FlipsideSectionFooter:
            return 1;
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case FlipsideSectionFooter:
            return 80;
        default:
            return [ShineTableViewCell height];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case FlipsideSectionPush:
            return [self pushNotificationCellForRow:indexPath.row];
        case FlipsideSectionPreferences:
            return [self preferenceCellForRow:indexPath.row];
        case FlipsideSectionFooter:
            return [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
        default:
            return nil;
    }
}

#pragma mark - TableView Delegate (Selection)

- (void)didSelectPushNotificationRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case FlipsideRowPushBadge:
            [self.navigationController pushViewController:self.favoritesViewController animated:YES];
            break;
        case FlipsideRowPushReport:
            break;
        default:
            break;
    }
}

- (void)didSelectPreferenceRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case FlipsideRowMetricTemp:
            [ShineDefaults shared].metricTemp = ![ShineDefaults shared].metricTemp;
            break;
        case FlipsideRowMetricWind:
            [ShineDefaults shared].metricWind = ![ShineDefaults shared].metricWind;
            break;
        case FlipsideRow24HrClock:
            [ShineDefaults shared].militaryClock = ![ShineDefaults shared].militaryClock;
            break;
        default:
            break;
    }
    [listView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case FlipsideSectionPush:
            [self didSelectPushNotificationRowAtIndexPath:indexPath];
            break;
        case FlipsideSectionPreferences:
            [self didSelectPreferenceRowAtIndexPath:indexPath];
            break;
        default:
            break;
    }
}

#pragma mark - TableView Delegate (Moving)

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - TableView Delegate (Editing)

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
