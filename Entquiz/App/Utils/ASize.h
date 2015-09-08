//
//  ASize.h
//  ASizeDemo
//
//  Created by Almas Adilbek on 12/2/13.
//  Copyright (c) 2013 GoodApp inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASize : NSObject

+ (CGFloat) screenWidth;
+ (CGFloat) screenHeight;
+ (CGFloat) screenHeightWithoutStatusBar;
+ (CGFloat) screenHeightWithoutStatusBarAndTabBar;
+ (CGFloat) screenHeightWithoutStatusBarAndNavigationBar;
+ (CGFloat) screenHeightWithoutStatusBarAndNavigationBarAndTabBar;
+ (CGFloat) screenHeightWithoutNavigationBar;

+ (CGFloat) screenWidthWithPadding:(CGFloat)padding;

+ (CGFloat) halfScreenWidth;
+ (CGFloat) halfScreenHeight;

+ (CGSize) screenSize;
+ (CGSize) screenSizeInOrientation:(UIInterfaceOrientation)orientation;

@end
