//
//  NCActivityWeibo.h
//  ActivityTest
//
//  Created by nickcheng on 15/1/5.
//  Copyright (c) 2015年 nickcheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCActivityWeibo : UIActivity

@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) NSString *shareString;

@property (nonatomic, strong) NSString *authRedirectURI;
@property (nonatomic, strong) NSString *authScope;
@property (nonatomic, strong) NSString *authAccessToken;

@end
