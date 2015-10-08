//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RoundData;


@interface ChooseCategoryViewController : UIViewController

- (id)initWithRoundData:(NSArray *)roundData;

@property (nonatomic, copy) void (^onRoundCategoryClick)(RoundData *roundData);


@end