//
// Created by Mustafin Askar on 19/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "UIFont+Extension.h"


@implementation UIFont (Extension)

+ (UIFont *)entHeavyFontWithSize:(int)size {
    return [UIFont fontWithName:@"Avenir-Heavy" size:size];
}

+ (UIFont *)entMediumFontWithSize:(int)size {
    return [UIFont fontWithName:@"Avenir-Medium" size:size];
}

+ (UIFont *)entLightFontWithSize:(int)size {
    return [UIFont fontWithName:@"Avenir-Light" size:size];
}


@end