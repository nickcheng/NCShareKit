//
//  NCActivityWeChatSession.m
//  ActivityTest
//
//  Created by nickcheng on 15/1/8.
//  Copyright (c) 2015年 nickcheng.com. All rights reserved.
//

#import "NCActivityWeChatSession.h"

@implementation NCActivityWeChatSession

- (NSString *)activityType {
  return @"UIActivityTypePostToWeChatSession";
}

- (UIImage *)activityImage {
  return [UIImage imageNamed:@"wechatsession"];
}

- (NSString *)activityTitle {
  return @"微信好友"; // todo
}

@end
