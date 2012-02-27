//
//  ShineAPIController.h
//  Shine
//
//  Created by Ryan Gomba on 2/24/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

#import "HTTPConnection.h"
#import "JSONKit.h"

@protocol ShineAPIControllerDelegate
- (void)shineAPIRequestDidSucceed;
- (void)shineAPIRequestDidFail;
@end

@interface ShineAPIController : NSObject <HTTPConnectionDelegate>

@property (nonatomic, weak) id <ShineAPIControllerDelegate> delegate;

- (void)enableTemperatureBadgeWithLocation:(Location *)location;
- (void)disableTemperatureBadge;

@end
