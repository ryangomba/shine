//
//  ErrorBarView.h
//  Shine
//
//  Created by Ryan Gomba on 2/21/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface ErrorBarView : UIView {
    IBOutlet UILabel *titleLabel;
}

@property (weak, nonatomic) NSString *title;

@end
