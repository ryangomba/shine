//
//  CurrentWeatherView.h
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "WeatherReport.h"
#import "CurrentReport.h"

@interface CurrentView : UIView {
    IBOutlet UIImageView *conditionIcon;
    IBOutlet UILabel *tempLabel;
    IBOutlet UILabel *windSpeedLabel;
    IBOutlet UILabel *windUnitLabel;
}

- (void)clear;
- (void)update:(CurrentReport *)currentReport;

@end
