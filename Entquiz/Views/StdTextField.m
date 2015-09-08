//
// Created by Mustafin Askar on 08/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "StdTextField.h"


#define kTextFieldHeight 30
#define kTextFieldWidth 250

@implementation StdTextField {

}

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, kTextFieldWidth, kTextFieldHeight)];
    if (self) {
        self.borderStyle = UITextBorderStyleRoundedRect;
    }
    return self;
}

@end