//
// Created by Mustafin Askar on 09/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StdButton : UIView

- (id)initWithTitle:(NSString *)title;
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;



@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSString *title;


@end