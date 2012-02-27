//
//  HourlyWeatherViewController.h
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "HourView.h"
#import "TextView.h"

#define ListContentHourly 0
#define ListContextText 1

@protocol HoursViewControllerDelegate
- (void)hoursViewControllerDidDemandContext;
@end

@interface HoursViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *listView;
    WeatherReport *weatherReport;
    
    IBOutlet UIButton *hourlySwitch;
    IBOutlet UIButton *textSwitch;
    int listContentType;
}

@property (weak, nonatomic) id <HoursViewControllerDelegate> delegate;

- (void)update:(WeatherReport *)report;

- (IBAction)switched:(id)sender;
- (void)reswitch;

- (TextReport *)textReportForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
