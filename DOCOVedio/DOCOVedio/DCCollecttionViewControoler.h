//
//  DCCollecttionViewControoler.h
//  DOCOVedio
//
//  Created by amor on 13-11-13.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCollecttionViewControoler : UICollectionViewController
- (void)layoutSubView:(BOOL)edit;
- (void)deletePituresInRange:(BOOL)range;
- (void)allSelect_done:(BOOL)sender;
@end
