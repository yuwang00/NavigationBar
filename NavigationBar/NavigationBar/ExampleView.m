//
//  ExampleView.m
//  testNavigation
//
//  Created by mathewchen on 17/2/17.
//  Copyright © 2017年 mathewchen. All rights reserved.
//

#import "ExampleView.h"

@implementation ExampleView

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
        self.text=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
        self.text.center=CGPointMake(frame.size.width/2, frame.size.height/2);
        self.text.textAlignment=NSTextAlignmentCenter;
        self.text.font=[UIFont systemFontOfSize:13.0];
        [self addSubview:self.text];
    }
    return self;
}

@end
