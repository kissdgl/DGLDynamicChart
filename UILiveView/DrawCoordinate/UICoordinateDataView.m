//
//  UICoordinateDataView.m
//  DGLDynamicChart
//
//  Created by Autel_Ling on 2017/1/5.
//  Copyright © 2017年 Autel. All rights reserved.
//

#import "UICoordinateDataView.h"
#import "CoordinateDrawer.h"

@implementation UICoordinateDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.crdDrawer = nil;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //NSLog(@"%@\n", @"draw data begging");
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect r = self.frame;
    CGContextClearRect(context, CGRectMake(0, 0, r.size.width, r.size.height));
    if ( self.crdDrawer ) {
        [self.crdDrawer drawDataView:self withContext:context];
    }
    //NSLog(@"%@\n\n", @"draw data ending");
}


@end
