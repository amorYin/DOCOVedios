//
//  DCTableViewCell.m
//  DOCOVedio
//
//  Created by amor on 13-11-15.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCTableViewCell.h"

@implementation DCTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DCTableViewCell" owner:self options:nil];
    for (id obj in nib) {
        if ([obj  isMemberOfClass:[DCTableViewCell class]]) {
            return obj;
        }
    }
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    
}

@end
