//
//  JTSImagePreview.m
//  RNImagePreview
//
//  Created by zhuxiankui on 16/7/6.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "JTSImagePreview.h"
#import "RCTLog.h"
#import <JTSImageViewController.h>
#import "AppDelegate.h"
@implementation JTSImagePreview

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(showImage:(NSString *)url)
{
  // Here's our method's code
  RCTLogInfo(@"showImage with url %@", url);
  // Create image info
  JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
  imageInfo.imageURL = [NSURL URLWithString:url];
  
  JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                         initWithImageInfo:imageInfo
                                         mode:JTSImageViewControllerMode_Image
                                         backgroundStyle:JTSImageViewControllerBackgroundOption_None];
  
  // Get root to show from
  AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
  // Determine what controller is in the front based on if the app has a navigation controller or a tab bar controller
  UIViewController* showingController;
  if([delegate.window.rootViewController isKindOfClass:[UINavigationController class]]){
    
    showingController = ((UINavigationController*)delegate.window.rootViewController).visibleViewController;
  } else if ([delegate.window.rootViewController isKindOfClass:[UITabBarController class]]) {
    
    showingController = ((UITabBarController*)delegate.window.rootViewController).selectedViewController;
  } else {
    
    showingController = (UIViewController*)delegate.window.rootViewController;
  }
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [imageViewer showFromViewController:showingController transition:JTSImageViewControllerTransition_FromOffscreen];
  });
}

@end