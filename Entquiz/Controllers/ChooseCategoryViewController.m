//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <PureLayout/ALView+PureLayout.h>
#import "ChooseCategoryViewController.h"
#import "RoundCategory.h"
#import "RoundData.h"


@interface ChooseCategoryViewController() {
}

@property (nonatomic, strong) NSArray *roundData;

@end

@implementation ChooseCategoryViewController {

}


- (id)initWithRoundData:(NSArray *)roundData {
    self = [super init];
    if (self) {
        self.roundData = roundData;
        [self initVars];
    }
    return self;
}

- (void)initVars {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark - config actions

- (void)clickCategoryButton:(UIButton *)categoryButton {
    if (self.onRoundCategoryClick) {
        RoundCategory *choosenRoundCategory = self.roundData[(NSUInteger) categoryButton.tag];
        self.onRoundCategoryClick(choosenRoundCategory);
    }
}

#pragma mark - config ui

- (void)configUI {

    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    [contentView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [contentView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [contentView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [contentView autoPinEdgeToSuperviewEdge:ALEdgeBottom];

    if (self.roundData.count == 3) {

        RoundData *roundData1 = self.roundData[0];
        RoundData *roundData2 = self.roundData[1];
        RoundData *roundData3 = self.roundData[2];
        RoundCategory *category1 = roundData1.category;
        RoundCategory *category2 = roundData2.category;
        RoundCategory *category3 = roundData3.category;

        UIButton *categoryButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
        categoryButton1.tag = 0;
        [categoryButton1 setTitle:category1.name forState:UIControlStateNormal];
        [categoryButton1 addTarget:self action:@selector(clickCategoryButton:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:categoryButton1];
        [categoryButton1 autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [categoryButton1 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:200];

        UIButton *categoryButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
        categoryButton2.tag = 1;
        [categoryButton2 setTitle:category2.name forState:UIControlStateNormal];
        [categoryButton2 addTarget:self action:@selector(clickCategoryButton:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:categoryButton2];
        [categoryButton2 autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [categoryButton2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:categoryButton1];

        UIButton *categoryButton3 = [UIButton buttonWithType:UIButtonTypeSystem];
        categoryButton3.tag = 2;
        [categoryButton3 setTitle:category3.name forState:UIControlStateNormal];
        [categoryButton3 addTarget:self action:@selector(clickCategoryButton:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:categoryButton3];
        [categoryButton3 autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [categoryButton3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:categoryButton2];
    }
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {

}

@end