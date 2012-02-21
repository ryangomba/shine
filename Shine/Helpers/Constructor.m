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

+ (UIBarButtonItem *)barButtonItemWithImageNamed:(NSString *)imageName
                                          target:(id)target
                                          action:(SEL)action {
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:[imageName stringByAppendingString:@"-down"]] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButtonItem;
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
