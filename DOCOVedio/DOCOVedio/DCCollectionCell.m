//
//  DCCollectionCell.m
//  DOCOVedio
//
//  Created by 91aiche on 13-11-14.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCCollectionCell.h"

@implementation DCCollectionCell
  - (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.layer.cornerRadius = 10.0;
        [self.contentView setFrame:CGRectMake(0, 0, cellSize, cellSize)];
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        
        _imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellSize, cellSize)];
        [_imgaeView.layer setMasksToBounds:YES];
        [_imgaeView setClipsToBounds:YES];
        [self.contentView addSubview:_imgaeView];
        

    }
    return self;
}
@end
