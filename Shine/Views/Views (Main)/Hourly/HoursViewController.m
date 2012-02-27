//
//  HourlyWeatherViewController.m
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "HoursViewController.h"

@implementation HoursViewController

@synthesize delegate;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [listView setScrollsToTop:YES];
    [listView setShowsVerticalScrollIndicator:NO];
    [hourlySwitch addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab-selected"]]];
    [textSwitch addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab-selected"]]];
}

#pragma mark - View generation

- (void)update:(WeatherReport *)report
{
    NSLog(@"Updating all hours");
    weatherReport = report;
    [listView reloadData];
}

- (void)switched:(id)sender
{    
    if (sender) {
        UIButton *this = (UIButton *)sender;
        UIButton *other;
        if (sender == hourlySwitch) {
            listContentType = ListContentHourly;
            other = textSwitch;
        } else {
            listContentType = ListContextText;
            other = hourlySwitch;
        }
        [UIView animateWithDuration:0.2 animations:^{
            [other.subviews.lastObject setAlpha:0.0];
            [this.subviews.lastObject setAlpha:1.0];
        }];
        [this setSelected:YES];
        [other setSelected:NO];
        [self.delegate hoursViewControllerDidDemandContext];
        [listView setContentOffset:CGPointMake(0.0, 0.0) animated:NO];
        [listView reloadData];
    }
}

- (void)reswitch
{
    switch (listContentType) {
        case ListContentHourly:
            hourlySwitch.selected = YES;
            break;
        case ListContextText:
            textSwitch.selected = YES;
            break;
        default:
            break;
    }
}

#pragma mark - Sections

- (UIView *)headerWithTitle:(NSString *)title
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 36)];
    //[header setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dayNameCell.png"]]];
    [header setBackgroundColor:[UIColor colorWithRed:53.0/255.0 green:55.0/255.0 blue:60.0/255.0 alpha:0.9]];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:15]];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [titleLabel setTextColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
    [titleLabel setShadowColor:[UIColor blackColor]];
    [titleLabel setShadowOffset:CGSizeMake(0, -1)];
    [titleLabel setText:title];
    [header addSubview:titleLabel];
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0.0, 35.0, 320.0, 1.0)];
    [bottom setBackgroundColor:[UIColor colorWithWhite:0.15 alpha:1.0]];
    [header addSubview:bottom];
    return header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (listContentType) {
        case ListContentHourly:
            if (weatherReport.hours.count < 4) return weatherReport.hours.count;
            else return 4;
        case ListContextText:
            return 1;
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (listContentType) {
        case ListContentHourly:
            return 36;
        default:
            return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (listContentType) {
        case ListContentHourly:
            return [self headerWithTitle:[(HourlyReport *)[[weatherReport.hours objectAtIndex:section] objectAtIndex:0] day]];
        default:
            return nil;
    }
}

#pragma mark - Rows

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (listContentType) {
        case ListContentHourly:
            return [[weatherReport.hours objectAtIndex:section] count];
        case ListContextText:
            return weatherReport.text.count;
        default:
            return 0;
    }
}

- (NSInteger)heightForTextRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *description = [self textReportForRowAtIndexPath:indexPath].displayDescription;
    return [TextView heightWithDescription:description];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (listContentType) {
        case ListContentHourly:
            return [HourView height];
        case ListContextText:
            return [self heightForTextRowAtIndexPath:indexPath];
        default:
            return 0;
    }
}

- (TextReport *)textReportForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [weatherReport.text objectAtIndex:indexPath.row];
}

- (UITableViewCell *)hourlyCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HourView *cell = [listView dequeueReusableCellWithIdentifier:@"HourView"];
    if (!cell) cell = [Constructor viewNamed:@"HourView" owner:self];
    NSArray *section = [weatherReport.hours objectAtIndex:indexPath.section];
    if ([section count] > indexPath.row) {
        [cell update:[section objectAtIndex:indexPath.row]];
    } else {
        NSLog(@"No weather for hour");
    }
    return cell;
}

- (UITableViewCell *)textCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextView *cell = [listView dequeueReusableCellWithIdentifier:@"TextView"];
    if (!cell) cell = [Constructor viewNamed:@"TextView" owner:self];
    TextReport *report = [self textReportForRowAtIndexPath:indexPath];
    [cell update:report];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell %d", indexPath.row);
    switch (listContentType) {
        case ListContentHourly:
            return [self hourlyCellForRowAtIndexPath:indexPath];
        case ListContextText:
            return [self textCellForRowAtIndexPath:indexPath];
        default:
            return nil;
    }
}

@end
