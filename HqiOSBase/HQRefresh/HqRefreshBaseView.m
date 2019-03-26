//
//  HqRefreshBaseView.m
//  HqiOSBase
//
//  Created by hehuiqi on 2018/3/10.
//  Copyright © 2018年 hehuiqi. All rights reserved.
//

#import "HqRefreshBaseView.h"

@implementation HqRefreshBaseView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.state = HqRefreshStateNormal;
    }
    return self;
}
+ (HqRefreshBaseView *)header{
    HqRefreshBaseView *header = [[HqRefreshBaseView alloc] init];
    return header;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    [self.superview removeObserver:self forKeyPath:HqRefreshContentOffset];
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:HqRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        _scrollview = (UIScrollView *)newSuperview;
        _originalInsetTop = _scrollview.mj_contentInsetTop;
        self.mj_y = -HqRefreshViewHeight;
        self.mj_width = newSuperview.bounds.size.width;
        self.mj_height = HqRefreshViewHeight;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (self.state == HqRefreshStateRefreshing) {
        return;
    }
    if ([HqRefreshContentOffset isEqualToString:keyPath]) {
        [self adjustHqRefreshState];
    }
}
- (void)adjustHqRefreshState{
    //如果是正在刷新，那就什么就不要做了
   
    //下拉时currentOffetY为负值
    CGFloat currentOffetY = self.scrollview.mj_contentOffsetY;
//    NSLog(@"inset==%f",self.scrollview.mj_contentInsetTop);
//    NSLog(@"currentOffetY==%f",currentOffetY);

    // 如果是向上滚动到看不见头部控件，直接返回
    if (currentOffetY>-_originalInsetTop) {
        return;
    }
    if (self.scrollview.isDragging) {
        
        CGFloat refreshHeight =  - HqRefreshViewHeight;
        
        //如果拉动的距离大于HqRefreshViewHeight证明下拉距离已经超过refreshHeight，
        //刷新头部已经完全露出
        if (self.state == HqRefreshStateNormal&&(currentOffetY<refreshHeight)) {
            //则该变状态为下拉状态
            self.state  = HqRefreshStatePull;
            
            //如果拉动的距离小于等于HqRefreshViewHeight证明拉距离在0~refreshHeight之间
        }else if(self.state == HqRefreshStatePull&&(currentOffetY>=refreshHeight)){
            //则改变状态为正常状态，因为这时候还没有达到刷新的程度
            self.state = HqRefreshStateNormal;
        }
    //如果不在拉动状态又是拖动状态则说明拉动的距离已经超过头部距离可以刷新了
    }else if(self.state == HqRefreshStatePull){
        NSLog(@"开始刷新了。。。。");
        self.state = HqRefreshStateRefreshing;
       
    }
    
}
- (void)endRefresh{
    self.state = HqRefreshStateNormal;
    NSLog(@"结束刷新了。。。。");
}
- (void)setState:(HqRefreshState)state{
    if (self.state == state) {
        return;
    }
    HqRefreshState oleState = self.state;
    _state = state;

    switch (state) {
        case HqRefreshStateNormal:
            {
                if (HqRefreshStateRefreshing == oleState) {
//                    NSLog(@"---%f",self.scrollview.mj_contentOffsetY);
                    [UIView animateWithDuration:HqRefreshDuration animations:^{
                        self.scrollview.mj_contentInsetTop = 0;
                    }];
                }else{
                    
                }
            }
            break;
        case HqRefreshStatePull:
        {
            
        }
            break;
        case HqRefreshStateRefreshing:
        {
            [UIView animateWithDuration:HqRefreshDuration animations:^{
                self.scrollview.mj_contentOffsetY = - HqRefreshViewHeight;
                self.scrollview.mj_contentInsetTop=  HqRefreshViewHeight;
                if (self.refreshComplete) {
                    self.refreshComplete();
                }
            }];
           
        }
            break;
            
        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
