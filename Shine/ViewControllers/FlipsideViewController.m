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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [navItem setTitle:@"Favorites"];
    [navItem setLeftBarButtonItem:[Constructor barButtonItemWithImageNamed:@"add" target:self action:@selector(add:)]];
    [navItem setRightBarButtonItem:[Constructor barButtonItemWithImageNamed:@"done" target:self action:@selector(done:)]];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-back"]]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    NSLog(@"DONE");
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)add:(id)sender {
    NSLog(@"ADD");
    [self performSegueWithIdentifier:@"Add" sender:sender];
}

#pragma mark - TableView Cells

- (ShineTableViewHeader *)headerCellWithTitle:(NSString *)title
{
    ShineTableViewHeader *header = [[ShineTableViewHeader alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Header"];
    [header setTitle:title];
    return header;
}

- (ShineTableViewCell *)cellWithTitle:(NSString *)title
{
    ShineTableViewCell *cell = [[ShineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    [cell setTitle:title];
    return cell;
}

- (UITableViewCell *)locationCellForRow:(NSInteger)row
{
    ShineTableViewCell *cell = [self cellWithTitle:@"Location"];
    return cell;
}

- (UITableViewCell *)preferenceCellForRow:(NSInteger)row
{
    NSString *title;
    switch (row) {
        case 0:
            title = @"Use metric temperature";
            break;
        case 1:
            title = @"Use metric wind speed";
            break;
        case 2:
            title = @"Use 24-hour clock";
            break;
    }
    ShineTableViewCell *cell = [self cellWithTitle:title];
    return cell;
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return 1; // header
        case 1: return 5; // locations
        case 2: return 1; // header
        case 3: return 3; // preferences
        case 4: return 1; // footer
        default: return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: return [ShineTableViewHeader height]; // header
        case 1: return [ShineTableViewCell height];   // locations
        case 2: return [ShineTableViewHeader height]; // header
        case 3: return [ShineTableViewCell height];   // preferences
        case 4: return 80; // footer
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: return [self headerCellWithTitle:@"Locations"];   // header
        case 1: return [self locationCellForRow:indexPath.row];   // locations
        case 2: return [self headerCellWithTitle:@"Preferences"]; // header
        case 3: return [self preferenceCellForRow:indexPath.row]; // preferences
        case 4: return [tableView dequeueReusableCellWithIdentifier:@"InfoCell"]; // footer
        default: return nil;
    }
}

#pragma mark - TableView Delegate (Selection)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

#pragma mark - TableView Delegate (Moving)

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row > 0) return YES;
    return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if ((sourceIndexPath.section != proposedDestinationIndexPath.section) || proposedDestinationIndexPath.row == 0) {
        return sourceIndexPath;
    }
    return proposedDestinationIndexPath;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // reorder locations
}

#pragma mark - TableView Delegate (Editing)

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) return YES;
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
}

@end
