//
//  DCCollectionCell.m
//  DOCOVedio
//
//  Created by 91aiche on 13-11-14.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCCollectionCell.h"
@interface DCCollectionCell ()

@end
@implementation DCCollectionCell
//  - (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        self.contentView.layer.cornerRadius = 10.0;
//        [self.contentView setFrame:CGRectMake(0, 0, cellSizeWidth, cellSizeHight)];
////        self.contentView.layer.borderWidth = 1.0f;
//        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
//        
//        self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)),30, 30)];
//        self.imageView.origin = CGPointMake(30, 5);
//        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        [self.contentView addSubview:self.imageView];
//    }
//    return self;
//}

-(void)prepareForReuse
{
    [super prepareForReuse];
    [self setImage:nil];
}

-(void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}
@end
