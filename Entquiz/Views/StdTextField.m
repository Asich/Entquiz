//
// Created by Mustafin Askar on 08/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "StdTextField.h"
#import "ViewFrameAccessor.h"
#import "UIFont+Extension.h"


#define kTextFieldHeight 30
#define kTextFieldWidth 250

@implementation StdTextField {

}

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, kTextFieldWidth, kTextFieldHeight)];
    if (self) {

        [self configUI];

    }
    return self;
}

- (void)configUI {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom - 1, self.width, 0.3)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];

    self.clearButtonMode = UITextFieldViewModeWhileEditing;


    self.font = [UIFont entMediumFontWithSize:15];
}

@end