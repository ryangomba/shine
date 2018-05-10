//
//  NSNumber+Safe.h
//  Shine
//
//  Created by Ryan Gomba on 2/19/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface NSNumber (Safe)

+ (NSNumber *)numberWithString:(NSString *)string;

- (NSString *)hourValue;
- (NSNumber *)checkTempUnits;
- (NSNumber *)checkWindUnits;
- (NSString *)intStringValue;

@end
