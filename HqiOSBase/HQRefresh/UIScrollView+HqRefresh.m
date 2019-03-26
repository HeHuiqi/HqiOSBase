//
//  UIScrollView+HqRefresh.m
//  HqiOSBase
//
//  Created by hehuiqi on 2018/3/10.
//  Copyright © 2018年 hehuiqi. All rights reserved.
//

#import "UIScrollView+HqRefresh.h"

@implementation UIScrollView (HqRefresh)

- (void)addRefreshHeader:(HqRefreshBaseView *)header{
    [self addSubview:header];
}
- (void)addRefreshHeader:(HqRefreshBaseView *)header refreshComplete:(HqRefreshComplete)complete{
    header.refreshComplete = complete;
    [self addSubview:header];
}

@end
