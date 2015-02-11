//
//  NCShareKit.h
//  ActivityTest
//
//  Created by nickcheng on 15/1/4.
//  Copyright (c) 2015年 nickcheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;

@interface NCShareKit : NSObject

+ (instancetype)shared;

// activityConfigDict
// {
//   @"weiboauthscope": @"",
//   @"weiboauthaccesstoken": @"",
//   @"": @"",
// }
- (void)config:(NSDictionary *)activityConfigDict;
- (void)shareItems:(NSArray *)items onVC:(UIViewController *)vc;
- (void)shareItems:(NSArray *)items onVC:(UIViewController *)vc completionHandler:(void(^)(NSString *activityType, BOOL completed))completionHandler;

@end
