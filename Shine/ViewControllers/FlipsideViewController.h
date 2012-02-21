//
//  FlipsideViewController.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@class FlipsideViewController;

#import "ShineNavigationBar.h"
#import "ShineTableViewHeader.h"
#import "ShineTableViewCell.h"

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UINavigationItem *navItem;
    IBOutlet UITableView *listView;
}

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
- (IBAction)add:(id)sender;

@end
