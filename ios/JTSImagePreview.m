//
//  JTSImagePreview.m
//  RNImagePreview
//
//  Created by Gant Laborde on 2/7/16.
//  Copyright © 2016 Facebook. All rights reserved.
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
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[imageViewer showFromViewController:delegate.rootViewController transition:JTSImageViewControllerTransition_FromOffscreen];
	});
}

@end
