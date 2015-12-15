//
// Created by Mustafin Askar on 19/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "UIButton+EntStyle.h"
#import "UIButton+BackgroudForState.h"
#import "UIColor+Extensions.h"
#import "UIFont+Extension.h"


@implementation UIButton (EntStyle)

- (void)applyEntStyleGray {
    self.frame = CGRectMake(0, 0, kButtonWidth, kButtonHeight);
    self.backgroundColor = [UIColor entGrayColor];
    [self setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.titleLabel.font = [UIFont entHeavyFontWithSize:13];
}

- (void)applyEntStyleGreen {
    self.frame = CGRectMake(0, 0, kButtonWidth, kButtonHeight);
    self.backgroundColor = [UIColor entGreenColor];
    [self setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.titleLabel.font = [UIFont entHeavyFontWithSize:13];
}

- (void)applyEntStyleAnswer {
    [self setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont entLightFontWithSize:12];
}


@end