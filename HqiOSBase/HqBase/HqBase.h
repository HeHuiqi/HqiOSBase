//
//  HqBase.h
//  HqiOSBase
//
//  Created by hehuiqi on 3/26/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define HOST @"www.host1.com"

#elif Qa
#define HOST @"www.host2.com"

#else
#define HOST @"www.host.com"

#endif


NS_ASSUME_NONNULL_BEGIN

@interface HqBase : NSObject

+ (void)operationDownload;
+ (void)findRepeatValues;

@end

NS_ASSUME_NONNULL_END
