//
//  DCLastViewController.m
//  DOCOVedio
//
//  Created by amor on 13-11-13.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCLastViewController.h"
#import "DCMPMoviePlayerView.h"
#import "MJRefresh.h"

@interface DCLastViewController ()<MJRefreshBaseViewDelegate>
{
    char contentTag[3];
    BOOL isSelect;
    MJRefreshHeaderView *_header;
}
@end

@implementation DCLastViewController

#pragma mark -
#pragma mark UISegmentedControl
- (void)reachableViewAtIndex:(NSInteger)index scroller:(BOOL)show
{
    self.segment.selectedSegmentIndex = index;
    if (contentTag[index] == NO) {
        if (index==0) {
            DCMPMoviePlayerView *today = [[DCMPMoviePlayerView alloc] initWithNibName:nil bundle:nil];
            today.view.size = CGSizeMake( self.view.height, self.view.width-49-71);
            today.view.origin = CGPointMake(self.view.width*index,0);
            today.view.tag = 1000+index;
            today.view.backgroundColor = [UIColor colorWithRed:(50*index)/255. green:(50*index)/255. blue:(50*index)/255. alpha:1];
            contentTag[index]=YES;
            [(UIScrollView*)self.scrollerView addSubview:today.view];
        }else{
            DCMPMoviePlayerView *other = [[DCMPMoviePlayerView alloc] initWithNibName:nil bundle:nil];
            other.view.size = CGSizeMake( self.view.width, self.view.height-56);
            other.view.origin = CGPointMake(self.view.width*index,0);
            other.view.tag = 1000+index;
            other.view.backgroundColor = [UIColor colorWithRed:(50*index)/255. green:(50*index)/255. blue:(50*index)/255. alpha:1];
            contentTag[index]=YES;
            [(UIScrollView*)self.scrollerView addSubview:other.view];
        }
    }
    UIScrollView *tempView = (UIScrollView*)[self.view viewWithTag:1000+index];
    _header.scrollView = (UIScrollView*)tempView;
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
        // 2秒后刷新表格
        [self performSelector:@selector(reloadDeals) withObject:nil afterDelay:2];
    }
}

#pragma mark - refresh
- (void)reloadDeals
{
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
#pragma mark viewController

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
    //refresh
    if (!_header) {
        _header = [MJRefreshHeaderView header];
        _header.delegate = self;
    }
    //segment
    if (!self.segment) {
        self.segment = [[UISegmentedControl alloc] initWithItems:@[@"今天",@"昨天",@"前天"]];
        self.segment.frame = CGRectMake(0, 0, 300, 36);
        
        [self.segment addTarget:self action:@selector(changeNewView:) forControlEvents:UIControlEventValueChanged];
        [self.navigationController.navigationBar addSubview:self.segment];
    }
    
    self.segment.center = CGPointMake(AppFrame.height*0.5,self.navigationController.navigationBar.centerY*0.5);
    self.scrollerView.contentSize = CGSizeMake(self.view.height*3, self.view.width-49-64);

    [self reachableViewAtIndex:0 scroller:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
