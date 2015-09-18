//
// Created by Mustafin Askar on 09/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "AMFloatLabelTextField.h"


@interface AMFloatLabelTextField ()
@property (nonatomic, strong) NSString *placeholder;
@end

@implementation AMFloatLabelTextField {}

- (id)initWithPlaceholder:(NSString *)placeholder width:(CGFloat)width {
    self = [super initWithFrame:CGRectMake(0, 0, width, 40)];
    if (self) {
        self.placeholder = placeholder;
        [self configUI];    
    }
    return self;
}

#pragma mark - config ui 

- (void)configUI {
    self.title = [[UILabel alloc] init];
    self.title.frame = CGRectMake(0.5, 15, self.frame.size.width, 15);
    self.title.font = [UIFont systemFontOfSize:9];
    self.title.hidden = YES;
    self.title.alpha = 0;
    self.title.textColor = [UIColor blueColor];
    [self addSubview:self.title];

    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 15, self.frame.size.width, self.frame.size.height - 15)];
    self.textField.placeholder = self.placeholder;
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.textField];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 0.3)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
}

#pragma mark - config actions

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.title.textColor = [UIColor blueColor];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView transitionWithView:self.title duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.title.textColor = [UIColor lightGrayColor];
    } completion:^(BOOL finished) {
    }];
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField.text.length > 0) {
        [self titleIsShow:YES withText:textField.placeholder];
    } else {
        [self titleIsShow:NO withText:nil];
    }
}

- (void)titleIsShow:(BOOL)isShow withText:(NSString *)text {
    if (!isShow) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect tempTitleFrame = self.title.frame;
            tempTitleFrame.origin.y = 15;
            self.title.frame = tempTitleFrame;

            self.title.alpha = 0;
        } completion:^(BOOL finished) {
            self.title.hidden = YES;
            self.title.text = @"";
        }];
    } else {
        self.title.hidden = NO;
        self.title.text = text;
        [UIView animateWithDuration:0.4 animations:^{
            CGRect tempTitleFrame = self.title.frame;
            tempTitleFrame.origin.y = 3;
            self.title.frame = tempTitleFrame;

            self.title.alpha = 1;
        }];
    }
}


@end