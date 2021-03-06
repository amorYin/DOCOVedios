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
    //
    UIBarButtonItem *all_done;
    UIBarButtonItem *edit_done;
    UIBarButtonItem *delete_done;
}
@end

@implementation DCCollectViewController
#pragma mark -
#pragma mark - UIBarButtonItem
- (void)setRightBarButton:(BOOL)y
{
    @autoreleasepool {
        
        if (!edit_done) {
            edit_done = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(openDeleteView:)];
        }
        
        if (!delete_done) {
            delete_done = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deletePituresInRange:)];
        }
        
        if (!all_done) {
            all_done = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(allSelect_done:)];
        }
        
        [self.navigationItem
         setRightBarButtonItems:[NSArray arrayWithObject:edit_done] animated:YES];
    }
}
- (void)openDeleteView:(id)sender
{
    [collectView layoutSubView:YES];
    [tabletView  layoutSubView:YES];
    segment.hidden = YES;
    scrollerView.scrollEnabled = NO;
    [edit_done setTitle:@"完成"];
    [edit_done setAction:@selector(cancleDone:)];
    [self.navigationItem setRightBarButtonItems:
    [NSArray arrayWithObjects:edit_done,all_done,delete_done, nil] animated:YES];
}

- (void)deletePituresInRange:(id)range
{
    [collectView deletePituresInRange:YES];
    [tabletView  deletePituresInRange:YES];
}

- (void)allSelect_done:(id)sender
{
    [collectView allSelect_done:YES];
    [tabletView  allSelect_done:YES];
}

- (void)cancleDone:(id)sender
{
    [edit_done setTitle:@"编辑"];
    [edit_done setAction:@selector(openDeleteView:)];
    [self.navigationItem
     setRightBarButtonItems:[NSArray arrayWithObject:edit_done] animated:YES];
    [collectView layoutSubView:NO];
    [tabletView  layoutSubView:NO];
    segment.hidden = NO;
    scrollerView.scrollEnabled = YES;
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
            tabletView.tableView.tag = 1000+index;
            contentTag[index]=YES;
            tabletView.tableView.size = CGSizeMake( self.view.height, self.view.width-49-71);
            tabletView.tableView.origin = CGPointMake(0,0);
            
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
