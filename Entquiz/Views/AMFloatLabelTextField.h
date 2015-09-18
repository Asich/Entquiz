//
// Created by Mustafin Askar on 09/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AMFloatLabelTextField : UIView <UITextFieldDelegate>

- (id)initWithPlaceholder:(NSString *)placeholder width:(CGFloat)width;

@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UITextField *textField;

@end