//
//  DCCollecttionViewControoler.m
//  DOCOVedio
//
//  Created by amor on 13-11-13.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCCollecttionViewControoler.h"

@interface DCCollecttionViewControoler ()
{
    DoCoOrientation orientation;
}
@end

@implementation DCCollecttionViewControoler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifierLandscape = @"CellIdentifierLandscape";
    static NSString *CellIdentifierPortrait = @"CellIdentifierPortrait";
    UICollectionViewCell *cell = (UICollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier: orientation == DoCoOrientationLandscape ? CellIdentifierLandscape:CellIdentifierPortrait  forIndexPath:indexPath];
    return cell;
}

@end
