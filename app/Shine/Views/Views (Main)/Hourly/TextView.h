//
//  TextView.h
//  Shine
//
//  Created by Ryan Gomba on 2/23/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "TextReport.h"

@interface TextView : UITableViewCell {
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *descriptionLabel;
    IBOutlet UIImageView *conditionIcon;
}

- (void)update:(TextReport *)info;

+ (NSInteger)heightWithDescription:(NSString *)description;

@end
