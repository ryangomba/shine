//
//  HourlyWeatherViewController.h
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "HourView.h"

@interface HoursViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *listView;
    NSArray *hourlyInfo;
}

- (void)update:(NSArray *)info;

@end
