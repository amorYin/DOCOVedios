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

@interface DCCollectViewController ()
{
    UISegmentedControl *segment;
    UIScrollView  *scrollerView;
    char contentTag[2];
}
@end

@implementation DCCollectViewController

#pragma mark -
#pragma mark UISegmentedControl
- (void)reachableViewAtIndex:(NSInteger)index
{
    if (contentTag[index] == NO) {
        if (index==0) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"bundle:nil];
            DCTableViewController *tabletView = [storyboard instantiateViewControllerWithIdentifier:@"DCTableViewController" ];
            tabletView.view.tag = 1000+index;
            tabletView.view.backgroundColor = [UIColor redColor];
            contentTag[index]=YES;
            [(UIScrollView*)self.view addSubview:tabletView.view];
            [(UIScrollView*)self.view scrollRectToVisible:tabletView.view.frame animated:YES];
        }else if (index==1){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"bundle:nil];
            DCCollecttionViewControoler *collectView = [storyboard instantiateViewControllerWithIdentifier:@"DCCollecttionViewControoler"];
            collectView.view.tag = 1000+index;
            collectView.view.backgroundColor = [UIColor greenColor];
            contentTag[index]=YES;
            [(UIScrollView*)self.view addSubview:collectView.view];
            [(UIScrollView*)self.view scrollRectToVisible:collectView.view.frame animated:YES];
        }else{
        
        }
    }
    
    UIView *collectView = [self.view viewWithTag:1000+index];
    if (self.interfaceOrientation <UIInterfaceOrientationPortraitUpsideDown) {
        collectView.frame = CGRectMake(index*AppFrame.height, 0, AppFrame.height, AppFrame.width);
        [(UIScrollView*)self.view scrollRectToVisible:collectView.frame animated:YES];
    }else{
        collectView.frame = CGRectMake(index*AppFrame.height, 0, AppFrame.height, self.view.height-49);
        [(UIScrollView*)self.view scrollRectToVisible:collectView.frame animated:YES];
    }
}
//seg
- (void)changeNewView:(UISegmentedControl*)seg
{
    [self reachableViewAtIndex:seg.selectedSegmentIndex];
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
        scrollerView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        scrollerView.pagingEnabled = YES;
        self.view = scrollerView;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateViewController) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    }
    
    if (!segment) {
        segment = [[UISegmentedControl alloc] initWithItems:@[@"普通",@"网状"]];
        [segment addTarget:self
                    action:@selector(changeNewView:)
          forControlEvents:UIControlEventValueChanged];
        segment.frame = CGRectMake(0, 0, 200, 36);
        [self.navigationController.navigationBar addSubview:segment];
    }
    
    if (self.interfaceOrientation > UIInterfaceOrientationLandscapeLeft) {
        segment.center = CGPointMake(AppFrame.height*0.5,
                                     self.navigationController.navigationBar.centerY*0.5);
        ((UIScrollView*)self.view).contentSize = CGSizeMake(AppFrame.width*2,AppFrame.height);
    }else{
        segment.center = CGPointMake(AppFrame.width*0.5,
                                     self.navigationController.navigationBar.centerY*0.5);
        ((UIScrollView*)self.view).contentSize = CGSizeMake(AppFrame.width*2, AppFrame.width);
    }
}

- (void)rotateViewController
{
    [(UIScrollView*)self.view setPagingEnabled:YES];
    if (self.interfaceOrientation > UIInterfaceOrientationPortraitUpsideDown) {
        segment.center = CGPointMake(AppFrame.width*0.5,
                                     self.navigationController.navigationBar.centerY*0.5);
        ((UIScrollView*)self.view).contentSize = CGSizeMake(AppFrame.height*2, AppFrame.width);
//
//        UIView *tableView = [self.view viewWithTag:1000+0];
//        tableView.frame = CGRectMake(0, 0, AppFrame.width, AppFrame.height);
//        
//        UIView *collectView = [self.view viewWithTag:1000+1];
//        collectView.frame = CGRectMake(AppFrame.width, 0, AppFrame.width, AppFrame.height);
    }else{
        segment.center = CGPointMake(AppFrame.height*0.5,
                                     self.navigationController.navigationBar.centerY*0.5);
        ((UIScrollView*)self.view).contentSize = CGSizeMake(AppFrame.height*2,self.view.height);
        
//        UIView *tableView = [self.view viewWithTag:1000+0];
//        tableView.frame = CGRectMake(0, 0, AppFrame.height, AppFrame.width);
//        UIView *collectView = [self.view viewWithTag:1000+1];
//        collectView.frame = CGRectMake(AppFrame.height, 0, AppFrame.height, AppFrame.width);
    }
}
- (void)viewDidUnload
{
    segment =nil;
    memset(contentTag, 0, sizeof(NO));
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
