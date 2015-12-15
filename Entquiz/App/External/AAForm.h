//
//  AAForm.h
//  Myth
//
//  Created by Almas Adilbek on 08/08/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <PureLayout/PureLayoutDefines.h>


@interface AAForm : NSObject

/**
* This block calls when keyboard done button pressed
* and takes textfield as parameter type
*/
@property (nonatomic, copy) void (^onKeyboardDoneTap)(UIView *activefield);

- (id)initWithScrollView:(UIScrollView *)scrollView;

- (void)pushView:(UIView *)view;
- (void)pushView:(UIView *)view marginTop:(CGFloat)marginTop;
- (void)pushView:(UIView *)view marginTop:(CGFloat)marginTop centered:(BOOL)center;
- (void)pushView:(UIView *)view centered:(BOOL)center;

- (void)pushView:(UIView *)view beforeView:(UIView *)bottomView;
- (void)pushView:(UIView *)view beforeView:(UIView *)bottomView marginTop:(CGFloat)marginTop;
- (void)pushView:(UIView *)view beforeView:(UIView *)bottomView marginTop:(CGFloat)marginTop centered:(BOOL)centered;
- (void)pushView:(UIView *)view beforeView:(UIView *)bottomView marginTop:(CGFloat)marginTop marginBottom:(CGFloat)marginBottom centered:(BOOL)centered;

- (void)pushViewAtTop:(UIView *)view;
- (void)pushViewAtTop:(UIView *)view marginBottom:(CGFloat)marginBottom;
- (void)pushViewAtTop:(UIView *)view centered:(BOOL)centered;
- (void)pushViewAtTop:(UIView *)view marginBottom:(CGFloat)marginBottom centered:(BOOL)centered;
- (void)pushViewAtTop:(UIView *)view marginTop:(CGFloat)marginTop marginBottom:(CGFloat)marginBottom centered:(BOOL)centered;

- (void)removeView:(UIView *)view;
- (void)removeLastView;
- (void)removeLastViews:(NSInteger)viewsCount;

// New
- (void)pushView:(UIView *)view marginLeft:(CGFloat)marginLeft marginTop:(CGFloat)marginTop;

- (void)updateViewBounds:(UIView *)view;


@end