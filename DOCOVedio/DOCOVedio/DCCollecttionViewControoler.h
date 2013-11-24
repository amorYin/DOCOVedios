//
//  DCCollecttionViewControoler.h
//  DOCOVedio
//
//  Created by amor on 13-11-13.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCollecttionViewControoler : UICollectionViewController
@property (nonatomic,strong)NSMutableArray *arrayData;
- (void)layoutSubView:(BOOL)edit;
- (void)deletePituresInRange:(BOOL)range callback:(void (^)(NSMutableArray *data))callbak;
- (void)allSelect_done:(BOOL)sender;
@end
