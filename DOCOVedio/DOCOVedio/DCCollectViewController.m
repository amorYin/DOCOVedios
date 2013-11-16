//
//  DCCollectViewController.m
//  DOCOVedio
//
//  Created by amor on 13-11-13.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCCollectViewController.h"
#import "DCCollecttionViewControoler.h"
#import "DCTableViewController.h"

@interface DCCollectViewController ()<UIScrollViewDelegate>
{
    UISegmentedControl *segment;
    UIScrollView *scrollerView;
    char contentTag[2];
    BOOL isSelect;
    DCTableViewController *tabletView;
    DCCollecttionViewControoler *collectView;
}
@end

@implementation DCCollectViewController
#pragma mark -
#pragma mark - UIBarButtonItem
- (void)setRightBarButton:(BOOL)y
{
    @autoreleasepool {
        if (!self.navigationItem.rightBarButtonItem) {
            UIBarButtonItem *edit_done = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(openDeleteView:)];
            [self.navigationItem setRightBarButtonItem:edit_done];
        }
    }
}
- (void)openDeleteView:(id)sender
{
    [self.navigationItem.rightBarButtonItem setTitle:@"完成"];
    [self.navigationItem.rightBarButtonItem setAction:@selector(cancleDone:)];
    [collectView layoutSubView:YES];
    [tabletView  layoutSubView:YES];
    
//    UIBarButtonItem *allSelect_done = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(openDeleteView:)];
//    
//    UIBarButtonItem *delete_done = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(deletePituresInRange:)];
}

- (void)deletePituresInRange:(NSRange)range
{
    
}

- (void)allSelect_done:(id)sender
{
    
}
- (void)cancleDone:(id)sender
{
    [self.navigationItem.rightBarButtonItem setTitle:@"编辑"];
    [self.navigationItem.rightBarButtonItem setAction:@selector(openDeleteView:)];
    [collectView layoutSubView:NO];
    [tabletView  layoutSubView:NO];
}
#pragma mark -
#pragma mark UISegmentedControl
- (void)reachableViewAtIndex:(NSInteger)index scroller:(BOOL)show
{
    segment.selectedSegmentIndex = index;
    [self setRightBarButton:index==1];
    if (contentTag[index] == NO) {
        if (index==0) {
            tabletView = [[DCTableViewController alloc] initWithNibName:nil bundle:nil];
            tabletView.view.size = CGSizeMake( self.view.height, self.view.width-49-71);
            collectView.view.origin = CGPointMake(0,0);
            tabletView.view.tag = 1000+index;
            contentTag[index]=YES;
            
            [(UIScrollView*)scrollerView addSubview:tabletView.view];
        }else if (index==1){
            collectView = [[DCCollecttionViewControoler alloc] initWithNibName:nil bundle:nil];
            collectView.view.tag = 1000+index;
            contentTag[index]=YES;
            collectView.view.size = CGSizeMake( self.view.width, self.view.height-56);
            collectView.view.origin = CGPointMake(self.view.width,0);
            
            [(UIScrollView*)scrollerView addSubview:collectView.view];
        }else{
        
        }
    }
    if (show) {
        UIView *tempView = [self.view viewWithTag:1000+index];
        [(UIScrollView*)scrollerView scrollRectToVisible:tempView.frame animated:YES];
    }
}
//seg
- (void)changeNewView:(UISegmentedControl*)seg
{
    isSelect = YES;
    [self reachableViewAtIndex:seg.selectedSegmentIndex scroller:YES];
}

#pragma mark -
#pragma mark - (void)scrollViewDidScroll:(UIScrollView *)scrollView;   
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isSelect) {return;}
    CGFloat indexf = scrollView.contentOffset.x/scrollView.width;
    NSInteger index = ceil(indexf);
    [self reachableViewAtIndex:index scroller:NO];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    isSelect = NO;
}
#pragma mark -
#pragma mark UIViewController
//view
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
	// Do any additional setup after loading the view.
    if (!scrollerView) {
            scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.height, self.view.width)];
            scrollerView.delegate = self;
            scrollerView.pagingEnabled = YES;
            [self.view addSubview:scrollerView];
    }
    
    if (!segment) {
            segment = [[UISegmentedControl alloc] initWithItems:@[@"普通",@"网状"]];
            segment.frame = CGRectMake(0, 0, 200, 36);
        
            [segment addTarget:self action:@selector(changeNewView:) forControlEvents:UIControlEventValueChanged];
            [self.navigationController.navigationBar addSubview:segment];
    }
    
    segment.center = CGPointMake(AppFrame.height*0.5,self.navigationController.navigationBar.centerY*0.5);
    scrollerView.contentSize = CGSizeMake(self.view.height*2, self.view.width-49-64);
    
    [self reachableViewAtIndex:0 scroller:YES];
}

- (void)viewDidUnload
{
    segment =nil;
    memset(contentTag, 0, sizeof(NO));
    scrollerView = nil;
    tabletView = nil;
    collectView = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
