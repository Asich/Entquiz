//
// Created by Mustafin Askar on 09/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "StdButton.h"


@interface StdButton ()
@property(nonatomic, strong) UIButton *button;
@end

@implementation StdButton {

}

- (id)initWithTitle:(NSString *)title {
    self = [super initWithFrame:CGRectMake(0, 0, [ASize screenWidth], 44)];
    if (self) {
        self.backgroundColor = [UIColor blueColor];

        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = self.bounds;
        [self.button setTitle:title forState:UIControlStateNormal];
        [self addSubview:self.button];
    }
    return self;
}

#pragma mark - set/get

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {

}

#pragma mark -

- (void)configUI {
    
}

@end