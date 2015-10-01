//
//  UIButton+BackgroudForState.m
//  Kurs
//
//  Created by Mustafin Askar on 31.07.13.
//  Copyright (c) 2013 askar. All rights reserved.
//

#import "UIButton+BackgroudForState.h"

@implementation UIButton (BackgroudForState)

- (void) setBackgroundColor:(UIColor *) _backgroundColor forState:(UIControlState) _state {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(3, 3), NO, [UIScreen mainScreen].scale);
    UIBezierPath* p = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 3, 3)];
    [_backgroundColor setFill];
    [p fill];
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    [self setBackgroundImage:[img resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forState:_state];
}

@end
