//
//  LocationCellView.h
//  Shine
//
//  Created by Ryan Gomba on 2/21/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface LocationCellView : UITableViewCell {
    IBOutlet UILabel *titleLabel;
    IBOutlet UIActivityIndicatorView *thinkingIndicator;
}

@property (weak, nonatomic) IBOutlet UIImageView *leftIconView;
@property (weak, nonatomic) IBOutlet UIImageView *rightIconView;

@property (weak, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL checked;
@property (assign, nonatomic) BOOL thinking;

- (void)disable;
- (void)enable;

@end
