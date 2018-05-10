//
//  ShineTableViewCell.h
//  Shine
//
//  Created by Ryan Gomba on 2/20/12.
//  Copyright (c) 2012 AppThat. All rights reserved.
//

@interface ShineTableViewCell : UITableViewCell {
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *detailLabel;
    IBOutlet UIImageView *markView;
}

+ (NSInteger)height;

@property (nonatomic, weak) NSString *title;
@property (nonatomic, weak) NSString *subtitle;
@property (nonatomic, weak) UIImage *mark;
@property (nonatomic, assign) BOOL marked;

@end
