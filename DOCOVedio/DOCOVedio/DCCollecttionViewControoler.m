//
//  DCCollecttionViewControoler.m
//  DOCOVedio
//
//  Created by amor on 13-11-13.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCCollecttionViewControoler.h"
#import "UIView+Positioning.h"
#import "DCCollectionCell.h"
#import "DCCollectionLayout.h"
#import "AFCollectionViewFlowLargeLayout.h"

static NSString *CellIdentifierLandscape = @"CellIdentifierLandscape";
@interface DCCollecttionViewControoler ()
{
    NSIndexPath *lastAccessed;
    BOOL  editing;
    NSMutableDictionary *selectedIdx;
}
@property (nonatomic, strong) DCCollectionLayout *largeLayout;
@end

@implementation DCCollecttionViewControoler

#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)loadView
{
        selectedIdx = [[NSMutableDictionary alloc] init];
    self.largeLayout = [[DCCollectionLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.largeLayout];
    [self.collectionView registerClass:[DCCollectionCell class] forCellWithReuseIdentifier:CellIdentifierLandscape];
    [self.collectionView setAllowsMultipleSelection:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//    [self.view addGestureRecognizer:gestureRecognizer];
//    [gestureRecognizer setMinimumNumberOfTouches:1];
//    [gestureRecognizer setMaximumNumberOfTouches:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)layoutSubView:(BOOL)edit;
{
    editing = edit;
    [self.collectionView reloadData];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return numOfimg * 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DCCollectionCell *cell = (DCCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierLandscape forIndexPath:indexPath];
    
    if (![cell viewWithTag:selectedTag])
    {
        UILabel *selected = [[UILabel alloc] initWithFrame:CGRectMake(0, cellSizeHight - textLabelHeight, cellSizeWidth, textLabelHeight)];
        selected.backgroundColor = [UIColor darkGrayColor];
        selected.textColor = [UIColor whiteColor];
        selected.text = @"SELECTED";
        selected.textAlignment = NSTextAlignmentCenter;
        selected.font = [UIFont systemFontOfSize:defaultFontSize];
        selected.tag = selectedTag;
        selected.alpha = cellAHidden;
        
        [cell.contentView addSubview:selected];
    }
    
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", [indexPath row] % numOfimg]];
    
    if (editing)
    {
        [[cell viewWithTag:selectedTag] setAlpha:cellAHidden];
        cell.imageView.alpha = cellADeactive;
    }

    
    // You supposed to highlight the selected cell in here; This is an example
    bool cellSelected = [selectedIdx objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]];
    [self setCellSelection:cell selected:cellSelected];
    
    return cell;
}
//
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCCollectionCell *cell = (DCCollectionCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [self setCellSelection:cell selected:YES];
    
    [selectedIdx setValue:@"1" forKey:[NSString stringWithFormat:@"%d", indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCCollectionCell *cell = (DCCollectionCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [self setCellSelection:cell selected:NO];
    
    [selectedIdx removeObjectForKey:[NSString stringWithFormat:@"%d", indexPath.row]];
}

- (void) setCellSelection:(DCCollectionCell *)cell selected:(bool)selected
{
    if (editing)
    {
        cell.imageView.alpha = selected ? cellAAcitve : cellADeactive;
        [cell viewWithTag:selectedTag].alpha = selected ? cellAAcitve : cellAHidden;
        
    }else
    {
        
    }

}

- (void) resetSelectedCells
{
    for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
        [self deselectCellForCollectionView:self.collectionView atIndexPath:[self.collectionView indexPathForCell:cell]];
    }
}

- (void) handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    float pointerX = [gestureRecognizer locationInView:self.collectionView].x;
    float pointerY = [gestureRecognizer locationInView:self.collectionView].y;
    
    for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
        float cellSX = cell.frame.origin.x;
        float cellEX = cell.frame.origin.x + cell.frame.size.width;
        float cellSY = cell.frame.origin.y;
        float cellEY = cell.frame.origin.y + cell.frame.size.height;
        
        if (pointerX >= cellSX && pointerX <= cellEX && pointerY >= cellSY && pointerY <= cellEY)
        {
            NSIndexPath *touchOver = [self.collectionView indexPathForCell:cell];
            
            if (lastAccessed != touchOver)
            {
                if (cell.selected)
                    [self deselectCellForCollectionView:self.collectionView atIndexPath:touchOver];
                else
                    [self selectCellForCollectionView:self.collectionView atIndexPath:touchOver];
            }
            
            lastAccessed = touchOver;
        }
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        lastAccessed = nil;
        self.collectionView.scrollEnabled = YES;
    }
    
    
}

- (void) selectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
{
    [collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [self collectionView:collection didSelectItemAtIndexPath:indexPath];
}

- (void) deselectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
{
    [collection deselectItemAtIndexPath:indexPath animated:YES];
    [self collectionView:collection didDeselectItemAtIndexPath:indexPath];
}
@end
