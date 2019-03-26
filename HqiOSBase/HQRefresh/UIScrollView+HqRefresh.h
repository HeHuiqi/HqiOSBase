//
//  UIScrollView+HqRefresh.h
//  HqiOSBase
//
//  Created by hehuiqi on 2018/3/10.
//  Copyright © 2018年 hehuiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqRefreshBaseView.h"

@interface UIScrollView (HqRefresh)

- (void)addRefreshHeader:(HqRefreshBaseView *)header;
- (void)addRefreshHeader:(HqRefreshBaseView *)header refreshComplete:(HqRefreshComplete)complete;
@end
