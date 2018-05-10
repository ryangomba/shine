//
//  UAController.h
//  Shine
//
//  Created by Ryan Gomba on 2/23/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface UAController : NSObject <NSURLConnectionDataDelegate>

- (void)registerDevice:(NSString *)token;

@end
