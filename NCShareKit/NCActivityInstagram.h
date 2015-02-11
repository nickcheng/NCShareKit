//
//  NCActivityInstagram.h
//  ActivityTest
//
//  Created by nickcheng on 15/1/4.
//  Copyright (c) 2015年 nickcheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCActivityInstagram : UIActivity

@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) NSString *shareString;

@property (nonatomic, strong) UIActivityViewController *avc;
@property (nonatomic, strong) UIView *view;

@end
