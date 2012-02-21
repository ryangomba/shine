//
//  Constructor.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface Constructor : NSObject

+ (id)viewNamed:(NSString *)viewName owner:(id)owner;

+ (UIBarButtonItem *)barButtonItemWithImageNamed:(NSString *)imageName
                                          target:(id)target
                                          action:(SEL)action;
+ (NSDateFormatter *)rfc822Formatter;

@end
