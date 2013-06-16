//
//  TestView.m
//  kvoTest
//
//  Created by 田立彬 on 13-6-16.
//  Copyright (c) 2013年 bluevt. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor yellowColor];
        self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.button setTitle:@"press" forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.button.frame = self.bounds;
}

- (void)pressed:(id)sender
{
    self.test++;
}


@end
