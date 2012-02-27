//
//  FlipsideViewController.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "AddViewController.h"

#import "ShineTableViewHeader.h"
#import "ShineTableViewCell.h"
#import "FavoritesViewController.h"

#define FlipsideSectionPush 0
#define FlipsideSectionPreferences 1
#define FlipsideSectionFooter 2

#define FlipsideRowPushBadge 0
#define FlipsideRowPushReport 1

#define FlipsideRowMetricTemp 0
#define FlipsideRowMetricWind 1
#define FlipsideRow24HrClock 2

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish;
@end

@interface FlipsideViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate> {
    IBOutlet UINavigationItem *navItem;
    IBOutlet UITableView *listView;
    
    FavoritesViewController *_favoritesViewController;
    
    UIView *navBarLine;
    UIImageView *navBarDropShadow;
}

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

@property (strong, nonatomic) FavoritesViewController *favoritesViewController;

- (IBAction)done:(id)sender;

@end
