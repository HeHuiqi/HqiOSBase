//
//  HqBase.m
//  HqiOSBase
//
//  Created by hehuiqi on 3/26/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import "HqBase.h"

@implementation HqBase
+ (void)operationDownload{
    
    HqDownloadOperation *hqOperation = [[HqDownloadOperation alloc] init];
    [hqOperation start];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:hqOperation];
    [hqOperation setCompletionBlock:^{
        NSLog(@"下载完成");
    }];
}

+ (void)findRepeatValues{
    NSMutableArray *arr = @[@(1),@(2),@(2),@(3),@(4),@(5),@(6),@(7),@(1),@(3)].mutableCopy;
    NSMutableArray *repeats = @[].mutableCopy;
    for (int i = 0; i<arr.count; i++) {
        for (int j = i+1; j<arr.count; j++) {
            NSNumber *num = arr[i];
            NSNumber *nextNum = arr[j];
            
            if (num.intValue == nextNum.intValue) {
                NSDictionary *repeat = @{@"preIndex":@(i),
                                         @"nextIndex":@(j),
                                         @"value":num,
                                         };
                [repeats addObject:repeat];
            }
        }
    }
    NSLog(@"repeats = %@",repeats);
}

@end

