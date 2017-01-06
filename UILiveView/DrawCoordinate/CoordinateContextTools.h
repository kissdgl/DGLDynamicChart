//
//  CoordinateContextTools.h
//  DGLDynamicChart
//
//  Created by Autel_Ling on 2017/1/5.
//  Copyright © 2017年 Autel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

typedef struct{
    float fR;
    float fG;
    float fB;
    float fAlpha;
}ContextRGBSColor;

@interface CoordinateContextTools : NSObject

+ (CGContextRef)drawRectLine:(CGContextRef)context rect:(CGRect)rect;

+(CGContextRef)drawLines:(CGContextRef)context
               lineColor:(ContextRGBSColor)color
              pointArray:(NSArray *)ary;

+(CGContextRef)drawLines:(CGContextRef)context
              lineHeight:(float)lineHeight
               lineColor:(ContextRGBSColor)color
              pointArray:(NSArray *)ary;

+ (CGContextRef)drawLines:(CGContextRef)context
                lineStyle:(CGLineCap)lineStyle
               lineHeight:(float)lineHeight
                lineColor:(ContextRGBSColor)color
                starPoint:(CGPoint)pointStart
                 endPoint:(CGPoint)pointEnd;

+(CGContextRef)drawLine:(CGContextRef)context
             startPoint:(CGPoint)sp
               endPoint:(CGPoint)ep
              lineColor:(ContextRGBSColor)color;

+(CGContextRef)drawLine:(CGContextRef)context
             lineHeight:(float)lineHeight
             startPoint:(CGPoint)sp
               endPoint:(CGPoint)ep
              lineColor:(ContextRGBSColor)color;
@end

