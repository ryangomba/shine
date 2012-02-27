//
//  FavoritesViewController.h
//  Shine
//
//  Created by Ryan Gomba on 2/24/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "ShineTableViewCell.h"
#import "ShineAPIController.h"
#import "ShineTableViewHeader.h"

@interface FavoritesViewController : UITableViewController <ShineAPIControllerDelegate> {
    NSArray *locations;
    
    ShineAPIController *shineAPIController;
}

- (void)updateLocations;
- (IBAction)dismiss:(id)sender;

@end
