//
//  DGLGaugeView.m
//  DGLChart
//
//  Created by Autel_Ling on 2017/1/6.
//  Copyright © 2017年 Autel. All rights reserved.
//

#import "DGLGaugeView.h"

#define RGBColor(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]

#define topMargin 10
#define bottomMargin self.frame.size.height / 5.0

@interface DGLGaugeView ()

@property (nonatomic, assign) CGFloat gaugeRadius;
@property (nonatomic, assign) CGPoint gaugeCenter;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;

//标注文字angle数组
@property (nonatomic, strong) NSMutableArray *textAngleArr;

//指针layer
@property (nonatomic, strong) CAShapeLayer *indicatorLayer;

//之前的角度
@property (nonatomic, assign) CGFloat preAngle;

@property (nonatomic, strong) UILabel *unitLabel;

@property (nonatomic, strong) UILabel *valueLabel;

//精度
@property (nonatomic, assign) int accuracy;

@end

@implementation DGLGaugeView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self drawBackGroud];
        [self drawScale];
        [self drawIndicator];
        [self addLabels];
        
        self.preAngle = self.startAngle;
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    //绘制标注文字
    [self drawText];

}

//添加label
- (void)addLabels {
    
    self.unitLabel = ({
        UILabel *unitLabel = [[UILabel alloc] init];
        unitLabel.font = [UIFont systemFontOfSize:15];
        unitLabel.textAlignment = NSTextAlignmentCenter;
        unitLabel.textColor = RGBColor(0, 206, 252);
        unitLabel.bounds = CGRectMake(0, 0, 50, 50);
        unitLabel.center = CGPointMake(self.gaugeCenter.x, self.gaugeCenter.y - self.gaugeRadius * 0.5);
        unitLabel.text = @"";
        unitLabel   ;
    });
    
    self.valueLabel = ({
        UILabel *valueLabel = [[UILabel alloc] init];
        valueLabel.font = [UIFont systemFontOfSize:15];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.textColor = RGBColor(0, 206, 252);
        valueLabel.bounds = CGRectMake(0, 0, 50, 50);
        valueLabel.center = CGPointMake(self.gaugeCenter.x, self.gaugeCenter.y + self.gaugeRadius * 0.5);
        valueLabel.text = @"";
        valueLabel   ;
    });
    
    
    [self addSubview:self.valueLabel];
    [self addSubview:self.unitLabel];
    
}

//画背景
- (void)drawBackGroud {
    
    UIBezierPath *circle     = [UIBezierPath bezierPathWithArcCenter:self.gaugeCenter
                                                              radius:self.gaugeRadius
                                                          startAngle:self.startAngle
                                                            endAngle:self.endAngle
                                                           clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth     = 5.f;
    shapeLayer.fillColor     = RGBColor(39, 45, 48).CGColor;
    shapeLayer.strokeColor   = RGBColor(160, 160, 160).CGColor;
    shapeLayer.path          = circle.CGPath;
    
    [self.layer addSublayer:shapeLayer];
}

//画刻度
- (void)drawScale {
    
    CGFloat radius = self.gaugeRadius - 20;
    CGPoint center = self.gaugeCenter;
    
    //我们需要计算出每段弧线的起始角度和结束角度
    
    CGFloat bigAngle = 0.02;
    CGFloat spaceAngle = 0.03;
    CGFloat smallAngle = (self.endAngle - self.startAngle - 11 * bigAngle - 50 * spaceAngle) / 40.0;
    
    CGFloat startAngle = self.startAngle;
    CGFloat endAngle = 0;
    
    for (int i = 0; i< 51; i++) {
        
        CAShapeLayer *perLayer = [CAShapeLayer layer];
        
        if (i % 5 == 0) {
            
            endAngle = startAngle + bigAngle;
            perLayer.lineWidth   = 15.f;
            
            CGFloat textAngle = startAngle + bigAngle * 0.5;
            NSNumber *textAngle1 = [NSNumber numberWithFloat:textAngle];
            [self.textAngleArr addObject:textAngle1];
            
        } else {
            
            endAngle = startAngle + smallAngle;
            perLayer.lineWidth   = 8.0;
        }
        
        if (i >=0 && i < 36) {
            perLayer.strokeColor = RGBColor(0, 206, 252).CGColor;
        } else if (i >= 36 && i < 43) {
            perLayer.strokeColor = RGBColor(255, 101, 30).CGColor;
        } else {
            perLayer.strokeColor = RGBColor(255, 27, 35).CGColor;
        }
        
        UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        
        //重置起始位置
        startAngle = endAngle + spaceAngle;
        
        perLayer.path = tickPath.CGPath;
        [self.layer addSublayer:perLayer];
    }
}

//绘制指针
- (void)drawIndicator {
    
    UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter:self.gaugeCenter radius:15 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CGPoint point = CGPointMake(self.gaugeCenter.x + self.gaugeRadius - 30.0, self.gaugeCenter.y);
    [circle addLineToPoint:point];
    
    self.indicatorLayer = [CAShapeLayer layer];
    self.indicatorLayer.frame = self.bounds;
    self.indicatorLayer.anchorPoint = CGPointMake(0.5, self.gaugeCenter.y / self.frame.size.height * 1.0);
    self.indicatorLayer.position = self.gaugeCenter;
    self.indicatorLayer.lineWidth = 3.0;
    self.indicatorLayer.strokeColor = RGBColor(0, 206, 252).CGColor;
    self.indicatorLayer.fillColor = RGBColor(39, 45, 48).CGColor;
    self.indicatorLayer.path = circle.CGPath;
    [self.layer addSublayer:self.indicatorLayer];
    
    CATransform3D transform = CATransform3DMakeRotation(self.startAngle, 0, 0, 1);
    self.indicatorLayer.transform = transform;
    
}

//绘制标注文字
- (void)drawText {
    
    for (int i = 0; i < self.textAngleArr.count; i++) {
        
        CGFloat textAngle       = [self.textAngleArr[i] floatValue];
        CGPoint point           = [self calculateTextPositonWithArcCenter:self.gaugeCenter Angle:textAngle];
        NSString *tickText      = [NSString stringWithFormat:@"%.1f",(self.maxValue-self.minValue) / 10.0 * i + self.minValue];
        
        UILabel *textLabel      = [[UILabel alloc] init];
        textLabel.center        = point;
        textLabel.bounds        = CGRectMake(0, 0, 30, 30);
        textLabel.text          = tickText;
        textLabel.font          = [UIFont systemFontOfSize:10];
        textLabel.textColor     = [UIColor colorWithRed:0.54 green:0.78 blue:0.91 alpha:1.0];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:textLabel];
    }
}

//计算label位置
- (CGPoint)calculateTextPositonWithArcCenter:(CGPoint)center
                                       Angle:(CGFloat)angel
{
    CGFloat radius = self.gaugeRadius - 40;
    CGFloat x = radius * cosf(angel);
    CGFloat y = radius * sinf(angel);
    
    return CGPointMake(center.x + x, center.y + y);
}


- (void)setCurrentValue:(CGFloat)currentValue {
    
    _currentValue = currentValue;
    
    //刷新图表
    CGFloat angle = currentValue / (self.maxValue - self.minValue) * (self.endAngle - self.startAngle) + self.startAngle;
    
    
    //清除动画
    [self.indicatorLayer removeAllAnimations];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    anim.fromValue = [NSNumber numberWithFloat:self.preAngle];
    anim.toValue = [NSNumber numberWithFloat:angle];
    anim.duration = 1.0;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.indicatorLayer addAnimation:anim forKey:@"rotation"];
    
    //保存之前的角度
    self.preAngle = angle;
    
    
    //更新label
    self.unitLabel.text = @"kPa";
    self.valueLabel.text = [NSString stringWithFormat:@"%.1f", currentValue];
    
}


#pragma mark - lazyloading
- (CGFloat)gaugeRadius {
    return (self.frame.size.height + bottomMargin - topMargin) * 0.5;
}
- (CGPoint)gaugeCenter {
    return CGPointMake(self.frame.size.width * 0.5, topMargin + self.gaugeRadius);
}
- (CGFloat)startAngle {
    return -M_PI - asin((self.gaugeRadius - bottomMargin) / self.gaugeRadius);
}
- (CGFloat)endAngle {
    return asin((self.gaugeRadius - bottomMargin) / self.gaugeRadius);
}

- (NSMutableArray *)textAngleArr {
    if (!_textAngleArr) {
        _textAngleArr = [NSMutableArray array];
    }
    return _textAngleArr;
}




@end
