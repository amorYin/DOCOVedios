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
#import "MJRefresh.h"

@interface DCCollectViewController ()<MJRefreshBaseViewDelegate>
{
    char contentTag[2];
    BOOL isSelect;
    DCTableViewController *tabletView;
    DCCollecttionViewControoler *collectView;
    MJRefreshHeaderView *_header;
    //
    UIBarButtonItem *all_done;
    UIBarButtonItem *edit_done;
    UIBarButtonItem *delete_done;
    NSMutableArray  *arryData;//数据
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
    self.segment.hidden = YES;
    self.scrollerView.scrollEnabled = NO;
    [edit_done setTitle:@"完成"];
    [edit_done setAction:@selector(cancleDone:)];
    [self.navigationItem setRightBarButtonItems:
    [NSArray arrayWithObjects:edit_done,all_done,delete_done, nil] animated:YES];
}

- (void)deletePituresInRange:(id)range
{
    if (self.segment.selectedSegmentIndex==0) {
        [tabletView  deletePituresInRange:YES callback:^(NSMutableArray *data) {
            //if data change reset,nesscery?
            if (data.count<arryData.count) arryData = data;
        }];
    }else{
        [collectView deletePituresInRange:YES callback:^(NSMutableArray *data) {
            //if data change reset,nesscery?
            if (data.count<arryData.count) arryData = data;
        }];
    }


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
    self.segment.hidden = NO;
    self.scrollerView.scrollEnabled = YES;
}
#pragma mark -
#pragma mark UISegmentedControl
- (void)reachableViewAtIndex:(NSInteger)index scroller:(BOOL)show
{
    self.segment.selectedSegmentIndex = index;
    [self setRightBarButton:index==1];
    if (contentTag[index] == NO) {
        if (index==0) {
            tabletView = [[DCTableViewController alloc] initWithNibName:nil bundle:nil];
            tabletView.arrayData = arryData;
            tabletView.tableView.tag = 1000+index;
            contentTag[index]=YES;
            tabletView.tableView.size = CGSizeMake( self.view.height, self.view.width-49-71);
            tabletView.tableView.origin = CGPointMake(0,0);
            
            [(UIScrollView*)self.scrollerView addSubview:tabletView.view];
        }else if (index==1){
            collectView = [[DCCollecttionViewControoler alloc] initWithNibName:nil bundle:nil];
            collectView.arrayData = arryData;
            collectView.view.tag = 1000+index;
            contentTag[index]=YES;
            collectView.view.size = CGSizeMake( self.view.width, self.view.height-56);
            collectView.view.origin = CGPointMake(self.view.width,0);
            
            [(UIScrollView*)self.scrollerView addSubview:collectView.view];
        }else{
        
        }
    }
    UIScrollView *tempView = (UIScrollView*)[self.view viewWithTag:1000+index];
    _header.scrollView = tempView;
    if (show) {
        
        [(UIScrollView*)self.scrollerView scrollRectToVisible:tempView.frame animated:YES];
    }
}
//seg
- (void)changeNewView:(UISegmentedControl*)seg
{
    isSelect = YES;
    [self reachableViewAtIndex:seg.selectedSegmentIndex scroller:YES];
}

#pragma mark -  refresh view delegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _header) { // 下拉刷新
        //关闭界面切换
        self.segment.enabled = NO;
        self.scrollerView.scrollEnabled = NO;
        // 增加9个假数据
        for (int i = 0; i<7; i++) {
            [arryData insertObject:[NSString stringWithFormat:@"%d",arryData.count+i] atIndex:0];
        }
        
        // 2秒后刷新表格
        [self performSelector:@selector(reloadDeals) withObject:nil afterDelay:2];
    }
}

#pragma mark - refresh
- (void)reloadDeals
{
    //刷新数据
    [collectView layoutSubView:NO];
    [tabletView  layoutSubView:NO];
    // 结束刷新状态
    [_header endRefreshing];
    //打开界面切换
    self.segment.enabled = YES;
    self.scrollerView.scrollEnabled = YES;
    
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
    [super viewDidLoad];
    //initlied data
    arryData = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19", nil];
	// Do any additional setup after loading the view.
    //refresh
    if (!_header) {
        _header = [MJRefreshHeaderView header];
        _header.delegate = self;
    }
    //segment
    if (!self.segment) {
            self.segment = [[UISegmentedControl alloc] initWithItems:@[@"普通",@"网状"]];
            self.segment.frame = CGRectMake(0, 0, 200, 36);
        
            [self.segment addTarget:self action:@selector(changeNewView:) forControlEvents:UIControlEventValueChanged];
            [self.navigationController.navigationBar addSubview:self.segment];
    }
    self.segment.center = CGPointMake(AppFrame.height*0.5,self.navigationController.navigationBar.centerY*0.5);
    self.scrollerView.contentSize = CGSizeMake(self.view.height*2, self.view.width-49-64);
    
    [self reachableViewAtIndex:0 scroller:YES];
}

- (void)viewDidUnload
{
    memset(contentTag, 0, sizeof(NO));
    self.scrollerView = nil;
    self.segment =nil;
    tabletView = nil;
    collectView = nil;
    _header = nil;
    arryData = nil;
    all_done = nil;
    delete_done = nil;
    edit_done = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
