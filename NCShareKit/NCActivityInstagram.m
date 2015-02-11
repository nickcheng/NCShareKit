//
//  NCActivityInstagram.m
//  ActivityTest
//
//  Created by nickcheng on 15/1/4.
//  Copyright (c) 2015年 nickcheng.com. All rights reserved.
//

#import "NCActivityInstagram.h"
#import <UIKit/UIKit.h>

@interface NCActivityInstagram () <UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) UIDocumentInteractionController *documentController;

@end

@implementation NCActivityInstagram

- (NSString *)activityType {
  return @"UIActivityTypePostToInstagram";
}

- (NSString *)activityTitle {
  return @"Instagram"; // todo: i18n
}

- (UIImage *)activityImage {
  return [UIImage imageNamed:@"instagram"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
  // Check if instagram installed
  NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
  if (![[UIApplication sharedApplication] canOpenURL:instagramURL])
    return NO;

  for (UIActivityItemProvider *item in activityItems) {
    if ([item isKindOfClass:[NSData class]]) {
      UIImage *image = [UIImage imageWithData:(NSData *)item];
      if ([self imageIsLargeEnough:image])
        return YES;
      else
        NSLog(@"NCActivityInstagram: Image too small: %@", item);
    } else if ([item isKindOfClass:[UIImage class]]) {
      if ([self imageIsLargeEnough:(UIImage *)item])
        return YES;       // has image, of sufficient size.
      else
        NSLog(@"NCActivityInstagram: Image too small: %@", item);
    }
  }
  return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
  for (id item in activityItems) {
    if ([item isKindOfClass:[NSData class]] && !self.shareImage) {
      self.shareImage = [UIImage imageWithData:(NSData *)item];
    } else if ([item isKindOfClass:[UIImage class]] && !self.shareImage) {
      self.shareImage = item;
    } else if ([item isKindOfClass:[NSString class]]) {
      self.shareString = [(self.shareString ? : @"") // concat, with space if already exists.
                          stringByAppendingFormat:@"%@%@", (self.shareString ? @" " : @""), item];
    } else
      NSLog(@"NCActivityInstagram: Unknown item type: %@", item);
  }
}

- (void)performActivity {
  // Save instagram.igo to temporary folder
  NSData *imageData = UIImageJPEGRepresentation(self.shareImage, 1.0);
  NSString *writePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"instagram.igo"];
  if (![imageData writeToFile:writePath atomically:YES]) {
    NSLog(@"NCActivityInstagram: Image save failed to path %@", writePath);
    [self activityDidFinish:NO];
    return;
  }

  // Send to instagram
  NSURL *fileURL = [NSURL fileURLWithPath:writePath];
  self.documentController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
  self.documentController.delegate = self;
  [self.documentController setUTI:@"com.instagram.exclusivegram"];
  if (self.shareString)
    [self.documentController setAnnotation:@{@"InstagramCaption": self.shareString}];
  
  if (self.avc && self.avc.presentingViewController) {
    [self.avc dismissViewControllerAnimated:YES completion:^ {
      if (![self.documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES])
        NSLog(@"NCActivityInstagram: Couldn't present document interaction controller.");
    }];
  } else {
    if (![self.documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES])
      NSLog(@"NCActivityInstagram: Couldn't present document interaction controller.");
  }

}

#pragma mark -
#pragma mark Private Methods

- (BOOL)imageIsLargeEnough:(UIImage *)image {
  CGSize imageSize = image.size;
  return ((imageSize.height * image.scale) >= 640 && (imageSize.width * image.scale) >= 640);
}

#pragma mark -
#pragma mark UIDocumentInteractionControllerDelegate

- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application {
  [self activityDidFinish:YES];
}

@end
