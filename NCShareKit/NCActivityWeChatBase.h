//
//  NCActivityWeChatBase.h
//  ActivityTest
//
//  Created by nickcheng on 15/1/8.
//  Copyright (c) 2015年 nickcheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <libWeChatSDK/WXApi.h>

@interface NCActivityWeChatBase : UIActivity

@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) NSString *shareStringTitle;
@property (nonatomic, strong) NSURL *shareURL;
@property (nonatomic, strong) UIImage *shareThumbImage;
@property (nonatomic, strong) NSString *shareStringDesc;

@property (nonatomic, assign) enum WXScene scene;

@end
