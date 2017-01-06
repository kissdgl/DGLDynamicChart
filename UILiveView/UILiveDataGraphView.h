//
//  UILiveDataGraphView.h
//  DGLDynamicChart
//
//  Created by Autel_Ling on 2017/1/5.
//  Copyright © 2017年 Autel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoordinateDrawer.h"
#import "UICoordinateView.h"

#define kDataMaxValue @"kDataMaxValue"
#define kDataMinValue @"kDataMinValue"
#define kDataArray @"kDataArray"


@interface UILiveDataGraphView : UICoordinateView<CoordinateDrawDelegate>

@property (nonatomic, assign) double fBeginTime;

@property (nonatomic, strong) NSDictionary *dataDic;


@end
