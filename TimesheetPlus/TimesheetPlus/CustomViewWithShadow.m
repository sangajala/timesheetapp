//
//  CustomViewWithShadow.m
//  TimesheetPlus
//
//  Created by Deepthi Kaligi on 27/06/2016.
//  Copyright © 2016 Banana Apps. All rights reserved.
//

#import "CustomViewWithShadow.h"

@implementation CustomViewWithShadow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setShadowColor:[UIColor whiteColor].CGColor];
        [self.layer setShadowOffset:CGSizeMake(-2, 2)];
        [self.layer setShadowRadius:2.0];
        [self.layer setShadowOpacity:0.8];
    }
    return self;
}

@end
