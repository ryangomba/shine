//
//  LocationBar.h
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "Location.h"

@interface LocationBarView : UIView {
    IBOutlet UILabel *title;
    IBOutlet UIButton *previous;
    IBOutlet UIButton *next;
}

- (void)clear;
- (void)update:(Location *)location;

@end
