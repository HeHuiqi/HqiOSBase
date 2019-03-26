//
//  HqRefreshBaseView.h
//  HqiOSBase
//
//  Created by hehuiqi on 2018/3/10.
//  Copyright © 2018年 hehuiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqRefreshConst.h"
#import "UIScrollView+MJExtension.h"
#import "UIView+MJExtension.h"

typedef NS_ENUM(NSInteger,HqRefreshState){
    HqRefreshStateNormal,
    HqRefreshStatePull,
    HqRefreshStateRefreshing,
};

typedef void(^HqRefreshComplete)(void);
@interface HqRefreshBaseView : UIView

@property (nonatomic,assign) HqRefreshState state;
@property (nonatomic,strong) UIScrollView *scrollview;
@property (nonatomic,assign) CGFloat originalOffsetY;
@property (nonatomic,assign) CGFloat originalInsetTop;
@property (nonatomic,copy) HqRefreshComplete refreshComplete;
+ (HqRefreshBaseView *)header;

- (void)endRefresh;

@end
