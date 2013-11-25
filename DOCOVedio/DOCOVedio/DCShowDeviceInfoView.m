//
//  DCShowDeviceInfoView.m
//  DOCOVedio
//
//  Created by amor on 13-11-24.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCShowDeviceInfoView.h"
#include "BaseTools.h"

@interface DCShowDeviceInfoView()
{
    UILabel *contentBg;
    UILabel *otherSize;
    UILabel *usedSize;
    UILabel *freeSize;
    
//    UILabel *des1;
//    UILabel *des2;
//    UILabel *des3;
//    
//    UILabel *col1;
//    UILabel *col2;
//    UILabel *col3;
//    
    CGFloat  maxWidth;
    CGFloat  orginx;
    CGFloat  orginy;
    CGFloat  padding;
}
@end

@implementation DCShowDeviceInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initlized];
        //reset
        [self refresh];
    }
    return self;
}

- (void)initlized
{
    //
    maxWidth = self.width*0.8;
    orginx = self.width*0.1;
    orginy = (self.height-20-14)*0.3;
    
    contentBg = [[UILabel alloc] initWithFrame:CGRectMake(orginx, orginy, maxWidth, 20)];
    contentBg.layer.cornerRadius =2;
    contentBg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    contentBg.layer.borderWidth = 1;
    
    padding = 0;
    otherSize = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxWidth*0.3, 20)];
    otherSize.backgroundColor = [UIColor blueColor];
    otherSize.textColor = [UIColor whiteColor];
    otherSize.font = [UIFont systemFontOfSize:14.];
    [contentBg addSubview:otherSize];
    
    padding = maxWidth*0.3;
    usedSize = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, maxWidth*0.3, 20)];
    usedSize.backgroundColor = [UIColor orangeColor];
    usedSize.textColor = [UIColor whiteColor];
    usedSize.font = [UIFont systemFontOfSize:14.];
    [contentBg addSubview:usedSize];
    
    padding = maxWidth*0.6;
    freeSize = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, maxWidth*0.4, 20)];
    freeSize.backgroundColor = [UIColor greenColor];
    freeSize.textColor = [UIColor whiteColor];
    freeSize.font = [UIFont systemFontOfSize:14.];
    [contentBg addSubview:freeSize];
    
    [self addSubview:contentBg];

//    CGFloat margin = (self.width-(28+42+28+20*3+10*3+20*2))*0.5;
//    
//    des1 = [[UILabel alloc] initWithFrame:CGRectMake(margin, orginy*2+20, 28, 14)];
//    des1.text = @"其他";
//    des1.font = [UIFont systemFontOfSize:14.];
//    des1.backgroundColor = [UIColor clearColor];
//    [self addSubview:des1];
//    
//    margin = margin+28+10;
//    col1 = [[UILabel alloc] initWithFrame:CGRectMake(margin, orginy*2+20-3, 20, 20)];
//    col1.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    col1.layer.borderWidth = 1;
//    col1.layer.backgroundColor = [UIColor blueColor].CGColor;
//    [self addSubview:col1];
//    
//    margin = margin+20+20;
//    des2 = [[UILabel alloc] initWithFrame:CGRectMake(margin, orginy*2+20, 42, 14)];
//    des2.text = @"已使用";
//    des2.font = [UIFont systemFontOfSize:14.];
//    des2.backgroundColor = [UIColor clearColor];
//    [self addSubview:des2];
//    
//    margin = margin+42+10;
//    col2 = [[UILabel alloc] initWithFrame:CGRectMake(margin, orginy*2+20-3, 20, 20)];
//    col2.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    col2.layer.borderWidth = 1;
//    col2.layer.backgroundColor = [UIColor orangeColor].CGColor;
//    [self addSubview:col2];
//    
//    margin = margin+20+20;
//    des3 = [[UILabel alloc] initWithFrame:CGRectMake(margin, orginy*2+20, 28, 14)];
//    des3.text = @"剩余";
//    des3.font = [UIFont systemFontOfSize:14.];
//    des3.backgroundColor = [UIColor clearColor];
//    [self addSubview:des3];
//    
//    margin = margin+28+10;
//    col3 = [[UILabel alloc] initWithFrame:CGRectMake(margin, orginy*2+20-3, 20, 20)];
//    col3.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    col3.layer.borderWidth = 1;
//    col3.layer.backgroundColor = [UIColor greenColor].CGColor;
//    [self addSubview:col3];
}

- (void)refresh
{
    double  toltal = systemDiskInBytes();
    double  free = freeDiskSpaceInBytes();
    double  other = fileDiskInBytes();

    [UIView animateWithDuration:0.25  animations:^{
        otherSize.text = [NSString stringWithFormat:@"其他%.2fG",other/1024];
        otherSize.size = CGSizeMake(other/toltal*maxWidth, 20);
        padding = other/toltal*maxWidth;
        
        usedSize.text = [NSString stringWithFormat:@"   已使用%.2fG",(toltal-free-other)/1024];
        usedSize.origin = CGPointMake(padding, 0);
        usedSize.size = CGSizeMake((toltal-free-other)/toltal*maxWidth, 20);
        padding = padding + (toltal-free-other)/toltal*maxWidth;
        
        freeSize.text = [NSString stringWithFormat:@"   可用%.2fG",free/1024];
        freeSize.origin = CGPointMake(padding, 0);
        freeSize.size = CGSizeMake(free/toltal*maxWidth, 20);
    } completion:^(BOOL finished) {
        
    }];
    

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
