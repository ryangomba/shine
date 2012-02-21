//
//  HourlyWeatherViewController.m
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "HoursViewController.h"

@implementation HoursViewController


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [listView setScrollsToTop:YES];
    [listView setShowsVerticalScrollIndicator:NO];
    hourlyInfo = [NSArray array];
}

#pragma mark - View generation

- (void)update:(NSArray *)info
{
    NSLog(@"Updating all hours");
    hourlyInfo = info;
    [listView reloadData];
}

#pragma mark - Sections

- (UIView *)headerWithTitle:(NSString *)title
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, -100, 320, 44)];
    [header setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dayNameCell.png"]]];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [titleLabel setTextColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
    [titleLabel setShadowColor:[UIColor blackColor]];
    [titleLabel setShadowOffset:CGSizeMake(0, -1)];
    [titleLabel setText:title];
    [header addSubview:titleLabel];
    return header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (hourlyInfo.count < 4) return hourlyInfo.count;
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerWithTitle:[(HourlyReport *)[[hourlyInfo objectAtIndex:section] objectAtIndex:0] day]];
}

#pragma mark - Rows

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[hourlyInfo objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HourView height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HourView *cell = [tableView dequeueReusableCellWithIdentifier:@"HourView"];
    if (!cell) cell = [Constructor viewNamed:@"HourView" owner:self];
    NSArray *section = [hourlyInfo objectAtIndex:indexPath.section];
    if ([section count] > indexPath.row) {
        [cell update:[section objectAtIndex:indexPath.row]];
    } else {
        NSLog(@"No weather for hour");
    }
    return cell;
}

@end
