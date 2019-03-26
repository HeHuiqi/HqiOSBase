//
//  ViewController.m
//  HqiOSBase
//
//  Created by hehuiqi on 2018/3/10.
//  Copyright © 2018年 hehuiqi. All rights reserved.
//

#import "HqRefreshVC.h"
//#import <objc/message.h>
#import "UIScrollView+HqRefresh.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
@interface HqRefreshVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HqRefreshVC
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//    [self.view addSubview:self.tableView];
    
    /*
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    */
    
//    self.navigationController.navigationBarHidden = YES;
    HqRefreshBaseView *header = nil;
//    header = [[HqRefreshBaseView alloc] initWithFrame:CGRectMake(0, -HqRefreshViewHeight, self.view.bounds.size.width, HqRefreshViewHeight)];
    
    header = [HqRefreshBaseView header];
    header.backgroundColor = [UIColor redColor];

    __weak typeof(header) weakHeader = header;
    [self.tableView addRefreshHeader:header refreshComplete:^{
        
        NSLog(@"正在请求数据。。。");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"数据请求完成。。。。");
            NSLog(@"更新页面");
            [weakHeader endRefresh];
        });
    }];
    
    //MJ0.0.1
//    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
  
    //MJ3.5.1
    /*
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing ];
        });
    }];
   */
    
    UIView *aniView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 200, 200)];
    [self.view addSubview: aniView];
    aniView.backgroundColor = [UIColor redColor];
    [self animationWithLayer:aniView.layer];
}
- (void)animationWithLayer:(CALayer *)layer{
    
    CGPathRef aPath = CGPathCreateWithEllipseInRect(CGRectMake(0, 0, 200, 200), NULL);
    
    [CATransaction begin];
    
    CAKeyframeAnimation * arcAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    [arcAnimation setBeginTime:CACurrentMediaTime()];
    [arcAnimation setDuration: 3.0];
    [arcAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [arcAnimation setAutoreverses: NO];
    [arcAnimation setRepeatCount:HUGE_VALF];
    arcAnimation.removedOnCompletion = NO;
    arcAnimation.fillMode = kCAFillModeRemoved;
    [arcAnimation setCalculationMode:kCAAnimationPaced];
    [arcAnimation setPath: aPath];
    [layer addAnimation: arcAnimation forKey: @"position"];
    
    [CATransaction commit];
    CFRelease(aPath);
}
- (void)headerRereshing{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView headerEndRefreshing];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
