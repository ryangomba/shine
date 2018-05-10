//
//  Constructor.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface Constructor : NSObject

+ (id)viewNamed:(NSString *)viewName owner:(id)owner;

+ (NSDateFormatter *)rfc822Formatter;

@end
