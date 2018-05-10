//
//  Constructor.m
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "Constructor.h"

@implementation Constructor

+ (id)viewNamed:(NSString *)viewName owner:(id)owner
{
    return [[[NSBundle mainBundle] loadNibNamed:viewName owner:owner options:nil] objectAtIndex:0];
}

+ (NSDateFormatter *)rfc822Formatter {
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"];
    }
    return formatter;
}

@end
