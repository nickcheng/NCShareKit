//
//  NCShareKit.m
//  ActivityTest
//
//  Created by nickcheng on 15/1/4.
//  Copyright (c) 2015年 nickcheng.com. All rights reserved.
//

#import "NCShareKit.h"
#import <UIKit/UIKit.h>
#import "NCActivityInstagram.h"
#import "NCActivityWeibo.h"
#import "NCActivityWeChatSession.h"
#import "NCActivityWeChatTimeline.h"

@implementation NCShareKit {
  NSString *_configWeiboAuthScope;
  NSString *_configWeiboAuthAccessToken;
}

#pragma mark -
#pragma mark Init

+ (instancetype)shared {
  static NCShareKit *sharedNCShareKit = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedNCShareKit = [[NCShareKit alloc] init];
  });
  return sharedNCShareKit;
}

- (id)init {
  self = [super init];
  if (self == nil) return nil;

  //
  
  return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)config:(NSDictionary *)activityConfigDict {
  // Get configuration from dict
  for (NSString *configKey in activityConfigDict.allKeys) {
    NSString *k = configKey.lowercaseString;
    if ([k isEqualToString:@"weiboauthscope"]) {
      _configWeiboAuthScope = activityConfigDict[@"weiboauthscope"];
    } else if ([k isEqualToString:@"weiboauthaccesstoken"]) {
      _configWeiboAuthAccessToken = activityConfigDict[@"weiboauthaccesstoken"];
    }
  }
}

- (void)shareItems:(NSArray *)items onVC:(UIViewController *)vc {
  [self shareItems:items onVC:vc completionHandler:nil];
}

- (void)shareItems:(NSArray *)items onVC:(UIViewController *)vc completionHandler:(void (^)(NSString *, BOOL))completionHandler {
  //
  NCActivityInstagram *activityInstagram = [[NCActivityInstagram alloc] init];
  NCActivityWeibo *activityWeibo = [[NCActivityWeibo alloc] init];
  NCActivityWeChatSession *activityWeChatSession = [[NCActivityWeChatSession alloc] init];
  NCActivityWeChatTimeline *activityWeChatTimeline = [[NCActivityWeChatTimeline alloc] init];
  //
  NSArray *appActivitiesArray = @[
                                  activityWeibo,
                                  activityInstagram,
                                  activityWeChatTimeline,
                                  activityWeChatSession
                                  ];
  NSArray *excActivitiesArray = @[
                                  UIActivityTypeAssignToContact,
                                  UIActivityTypeCopyToPasteboard,
                                  UIActivityTypePrint,
                                  UIActivityTypePostToWeibo //
                                  ];
  //
  UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
                                                      initWithActivityItems:items
                                                      applicationActivities:appActivitiesArray];
  activityViewController.excludedActivityTypes = excActivitiesArray;
  // Configurate activities
  // Instagram
  activityInstagram.avc = activityViewController;
  activityInstagram.view = vc.view;
  // Weibo
  activityWeibo.authScope = _configWeiboAuthScope;
  activityWeibo.authAccessToken = _configWeiboAuthAccessToken;
  // Other activities
  
  // Share completion handler
  if (completionHandler) {
    activityViewController.completionHandler = completionHandler;
    // todo: Use completionWithItemsHandler in iOS 8
  }
  // Present
  [vc presentViewController:activityViewController animated:YES completion:nil];
}

@end
