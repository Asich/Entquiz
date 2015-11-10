//
//  AAForm.m
//  Myth
//
//  Created by Almas Adilbek on 08/08/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AAForm.h"
#import "ALView+PureLayout.h"
#import "NSLayoutConstraint+PureLayout.h"
#import "NSArray+PureLayout.h"

@interface AAFormView : NSObject
@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, strong) NSLayoutConstraint *topEdgeConstraint;
@property (nonatomic, strong) NSLayoutConstraint *superviewBottomEdgeConstraint;
@property (nonatomic, strong) NSArray *boundsConstraints;

- (void)removeTopEdgeConstraint;
- (void)removeSuperviewBottomConstraint;

@end

@implementation AAFormView

- (void)removeTopEdgeConstraint {
    if(self.topEdgeConstraint) {
        [self.topEdgeConstraint autoRemove];
    }
}

- (void)removeSuperviewBottomConstraint {
    if(self.superviewBottomEdgeConstraint) {
        [self.superviewBottomEdgeConstraint autoRemove];
        self.superviewBottomEdgeConstraint = nil;
    }
}

@end

@interface AAForm()

@end;

@implementation AAForm {
    NSMutableArray *views;
    UIScrollView *contentScrollView;

    NSMutableDictionary *viewsDictionary;
    CGFloat contentScrollViewBottomPadding;
}

- (id)initWithScrollView:(UIScrollView *)scrollView {
    self = [super init];
    if (self)
    {
        contentScrollViewBottomPadding = 20;
        contentScrollView = scrollView;

        [contentScrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [contentScrollView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [contentScrollView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        [contentScrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];

        views = [[NSMutableArray alloc] init];
        viewsDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark -

-(void)pushView:(UIView *)view {
    [self pushView:view centered:NO];
}

- (void)pushView:(UIView *)view marginTop:(CGFloat)marginTop {
    [self pushView:view marginTop:marginTop centered:NO];
}

- (void)pushView:(UIView *)view centered:(BOOL)center {
    [self pushView:view marginTop:0 centered:center];
}

- (void)pushView:(UIView *)view beforeView:(UIView *)bottomView {
    [self pushView:view beforeView:bottomView marginTop:0 centered:NO];
}

- (void)pushView:(UIView *)view beforeView:(UIView *)bottomView marginTop:(CGFloat)marginTop {
    [self pushView:view beforeView:bottomView marginTop:marginTop centered:NO];
}


- (void)pushView:(UIView *)view beforeView:(UIView *)bottomView marginTop:(CGFloat)marginTop centered:(BOOL)centered {
    [self pushView:view beforeView:bottomView marginTop:marginTop marginBottom:-1 centered:centered];
}

- (void)pushView:(UIView *)view beforeView:(UIView *)bottomView marginTop:(CGFloat)marginTop marginBottom:(CGFloat)marginBottom centered:(BOOL)centered
{
    BOOL bottomViewExists = [views containsObject:bottomView];

    // Check if bottomView inside the array
    if(bottomViewExists)
    {
        [contentScrollView addSubview:view];

        NSArray *boundsConstraints = [self autoSetDimensionsToSizeOfView:view];

        // Center
        if(centered) {
            [view autoAlignAxisToSuperviewAxis:ALAxisVertical];
        }

        NSInteger bottomViewIndex = [views indexOfObject:bottomView];
        NSLayoutConstraint *constraint = nil;

        // If not first view
        if(bottomViewIndex > 0)
        {
            UIView *topView = views[(NSUInteger) (bottomViewIndex - 1)];
            constraint = [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topView withOffset:marginTop];
        }
        else
        {
            constraint = [view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:marginTop];
        }

        // Constraint to bottom view
        AAFormView *bottomFormView = [self formView:bottomView];
        [bottomFormView removeTopEdgeConstraint];

        // Set marginBottom with marginBottom parameter if not -1, or with old formView marginTop,
        CGFloat marginBottomValue = (marginBottom != -1 ? marginBottom : bottomFormView.marginTop);

        NSLayoutConstraint *bottomViewContraint = [bottomView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:view withOffset:marginBottomValue];
        [self editTopEdgeConstraint:bottomViewContraint forView:bottomView];

        // Form View
        AAFormView *formView = [self createFormView:view atIndex:(bottomViewIndex > 0 ? bottomViewIndex : 0)];
        formView.marginTop = marginTop;
        formView.topEdgeConstraint = constraint;
        formView.boundsConstraints = boundsConstraints;
    }
}


- (void)pushView:(UIView *)view marginTop:(CGFloat)marginTop centered:(BOOL)center
{
    [contentScrollView addSubview:view];

    UIView *lastView = [self lastView];
    AAFormView *formView = [self createFormView:view];

    // Check if not CGRectZero
    if(view.frame.size.width > 0 && view.frame.size.height > 0) {
        NSArray *boundsConstraints = [self autoSetDimensionsToSizeOfView:view];
        formView.boundsConstraints = boundsConstraints;
    }
    if(center) {
        [view autoAlignAxisToSuperviewAxis:ALAxisVertical];
    }

    NSLayoutConstraint *constraint = nil;
    if(lastView) {
        constraint = [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lastView withOffset:marginTop];
    } else {
        constraint = [view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:marginTop];
    }

    formView.marginTop = marginTop;
    formView.topEdgeConstraint = constraint;

    // Clear superview bottom constraint
//    [self clearViewSuperviewBottomConstraint];
//
//    // Set superview bottom constraint to bottom view
//    NSLayoutConstraint *bottomConstraint = [view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:contentScrollViewBottomPadding];
//    formView.superviewBottomEdgeConstraint = bottomConstraint;
}

-(void)pushViewAtTop:(UIView *)view {
    [self pushViewAtTop:view marginBottom:0];
}

-(void)pushViewAtTop:(UIView *)view marginBottom:(CGFloat)marginBottom {
    [self pushViewAtTop:view marginBottom:marginBottom centered:NO];
}

- (void)pushViewAtTop:(UIView *)view centered:(BOOL)centered {
    [self pushViewAtTop:view marginTop:0 marginBottom:-1 centered:centered];
}

- (void)pushViewAtTop:(UIView *)view marginBottom:(CGFloat)marginBottom centered:(BOOL)centered {
    [self pushViewAtTop:view marginTop:0 marginBottom:marginBottom centered:centered];
}

- (void)pushViewAtTop:(UIView *)view marginTop:(CGFloat)marginTop marginBottom:(CGFloat)marginBottom centered:(BOOL)centered {
    if(views.count > 0) {
        UIView *bottomView = [views firstObject];
        [self pushView:view beforeView:bottomView marginTop:marginTop marginBottom:marginBottom centered:centered];
    } else {
        [self pushView:view marginTop:marginTop];
    }
}

#pragma mark -

-(void)removeView:(UIView *)view
{
    if([views containsObject:view])
    {
        NSInteger viewIndex = [views indexOfObject:view];
        id prevView = nil;
        id nextView = nil;

        if(viewIndex > 0) prevView = views[(NSUInteger) (viewIndex - 1)];
        if(viewIndex < views.count - 1) nextView = views[(NSUInteger) (viewIndex + 1)];

        AAFormView *formView = [self formView:view];
        [formView removeSuperviewBottomConstraint];

        [views removeObject:view];
        [view removeFromSuperview];
        // Check if removed view is not last object
        if(nextView) {
            NSLayoutConstraint *constraint;
            if (prevView) {
                constraint = [nextView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:prevView withOffset:15];
            } else {
                constraint = [nextView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
            }
            [self editTopEdgeConstraint:constraint forView:nextView];
        }
    }
}

- (void)removeLastView {
    if(views.count > 0) [self removeView:[views lastObject]];
}

- (void)removeLastViews:(NSInteger)viewsCount {
    for(NSInteger i=0; i<viewsCount; ++i) {
        [self removeLastView];
    }
}


#pragma mark -

- (void)pushView:(UIView *)view marginLeft:(CGFloat)marginLeft marginTop:(CGFloat)marginTop
{
    [self pushView:view marginTop:marginTop];
    [view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:marginLeft];
}

- (void)updateViewBounds:(UIView *)view
{
    if([views containsObject:view])
    {
        AAFormView *formView = [self formView:view];
        if(formView) {
            [formView.boundsConstraints autoRemoveConstraints];
            NSArray *boundsConstraints = [self autoSetDimensionsToSizeOfView:view];
            formView.boundsConstraints = boundsConstraints;
        }
    }
}

#pragma mark -
#pragma mark AutoLayout helpers

- (NSArray *)autoSetDimensionsToSizeOfView:(UIView *)view {
    return [view autoSetDimensionsToSize:CGSizeMake(view.frame.size.width, view.frame.size.height)];
}

#pragma mark -
#pragma mark ViewsDictionary

- (AAFormView *)formView:(UIView *)view {
    return viewsDictionary[[NSValue valueWithNonretainedObject:view]];
}

- (AAFormView *)createFormView:(UIView *)view {
    return [self createFormView:view atIndex:-1];
}

- (AAFormView *)createFormView:(UIView *)view atIndex:(NSInteger)index
{
    if(![views containsObject:view]) {
        if(index == -1) [views addObject:view];
        else [views insertObject:view atIndex:index];
    }

    AAFormView *formView = [[AAFormView alloc] init];
    viewsDictionary[[NSValue valueWithNonretainedObject:view]] = formView;
    return formView;
}

- (void)editTopEdgeConstraint:(NSLayoutConstraint *)constraint forView:(UIView *)view
{
    AAFormView *formView = [self formView:view];
    if(formView) {
        formView.topEdgeConstraint = constraint;
        viewsDictionary[[NSValue valueWithNonretainedObject:view]] = formView;
    }
}

- (void)clearViewSuperviewBottomConstraint {
    for(NSString *key in [viewsDictionary allKeys]) {
        AAFormView *formView = viewsDictionary[key];
        if(formView) {
            if(formView.superviewBottomEdgeConstraint) {
                [formView removeSuperviewBottomConstraint];
                break;
            }
        }
    }
}

#pragma mark -

- (UIView *)lastView {
    if(views.count > 0) return [views lastObject];
    return nil;
}

#pragma mark -

-(void)dealloc {
    views = nil;
    contentScrollView = nil;
}

@end