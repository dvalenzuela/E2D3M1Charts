//
//  ADCChart.m
//  DrawingCharts
//
//  Created by Diego Valenzuela on 11/17/14.
//  Copyright (c) 2014 Diego Valenzuela. All rights reserved.
//

#import "E2D3M1Chart.h"
#import <QuartzCore/QuartzCore.h>
@implementation E2D3M1Chart
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
     
        [self cleanSubViews];
        _xMargin = 0;
        _yMargin = 0;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
     
        [self cleanSubViews];
        _xMargin = 0;
        _yMargin = 0;
    }
    return self;
}
- (id) initWithFrame:(CGRect)rect andBorder:(CGPoint) point {
    self = [[E2D3M1Chart alloc]initWithFrame:rect];
    _xMargin = point.x;
    _yMargin = point.y;
    return self;
}
- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    if(!self.delegate)
        return;
    
    if([self.delegate valuesForYAxis].count == 0)
        return;
    

    [self calculateGridArea];
    [self calculateNumberOfItems];
    [self calculateScaling];
    
}
- (void) calculateGridArea {
    _gridWidth=self.frame.size.width;
    _gridWidth=[E2D3M1DrawingHelpers CalculateGridWidth:_gridWidth leftMargin:_xMargin rightMargin:_xMargin yAxisSpace:_yMargin];
    
    _gridHeight=self.frame.size.height;
    _gridHeight=[E2D3M1DrawingHelpers CalculateGridHeight:_gridHeight bottomMargin:_yMargin topMargin:_yMargin xAxisSpace:_xMargin];
}
- (void) calculateNumberOfItems {
    _itemCount = [self.delegate valuesForYAxis].count;
}

- (void) cleanSubViews {
    for(UIView *vw in self.subviews){
        [vw removeFromSuperview];
    }
}

- (void) calculateScaling {
    float tileHeight = 40;
    float numOfHLines=_gridHeight/tileHeight;
    NSArray *itemsOnY = [self.delegate valuesForYAxis];
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    _maxValue = [[itemsOnY sortedArrayUsingDescriptors:@[highestToLowest]][0] floatValue];
    highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    _minValue = [[itemsOnY sortedArrayUsingDescriptors:@[highestToLowest]][0] floatValue];
    _scalingY = [E2D3M1DrawingHelpers findScaleForYTile:itemsOnY.count gridHeight:_gridHeight tileHeight:tileHeight hLines:numOfHLines Min:_minValue Max:_maxValue];
    _scalingX= (  _gridWidth /(_itemCount * 4.0) );
}

- (void) applyBackgroundToContext {
    if(self.delegate && [(NSObject*)self.delegate respondsToSelector:@selector(fillChartColor)]){
        UIColor *color = [self.delegate fillChartColor];
        
        CGContextSaveGState(_ctx);
        CGContextSetFillColorWithColor(_ctx, color.CGColor);
        CGContextFillRect(_ctx, CGRectMake(0, 0, _gridWidth, _gridHeight));
        CGContextRestoreGState(_ctx);
    }else{
        CGContextSaveGState(_ctx);
        CGFloat BGLocations[3] = { 0.0,0.5 ,1.0 };
        CGFloat BgComponents[12] = { 0.96, 0.96, 0.96 , 1.0,  // Start color
            0.99, 0.99, 0.99 , 1.0,  // Start color
            1.0, 1.0, 1.0 , 1.0 }; // Mid color and End color
        
        CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef bgRadialGradient = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents, BGLocations, 3);
        CGContextAddRect(_ctx, CGRectMake(0, 0, _gridWidth, _gridHeight));
        if(!CGContextIsPathEmpty(_ctx))
            CGContextClip(_ctx);
        
        CGContextDrawLinearGradient(_ctx, bgRadialGradient, CGPointMake(0, 0), CGPointMake(0, _gridHeight), 0 );
        
        CGColorSpaceRelease(BgRGBColorspace);
        CGGradientRelease(bgRadialGradient);
        CGContextRestoreGState(_ctx);
    }
}

- (void) setUpContextForRect:(CGRect)rect {
    _ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(_ctx, NO);
    CGContextSetShouldAntialias(_ctx, NO);
    
    CGRect r=CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGContextSetBlendMode(_ctx,kCGBlendModeClear);
    CGContextAddRect(_ctx, r);

    CGContextFillPath(_ctx);
    CGContextSetBlendMode(_ctx,kCGBlendModeNormal);
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(_ctx, flipTransform);
    
    [self applyBackgroundToContext];
    
    CGContextSetAllowsAntialiasing(_ctx, YES);
    CGContextSetShouldAntialias(_ctx, YES);
}
//TODO:To implement animations
- (CABasicAnimation*) pathAnimation {
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:PATH_ANIMATION_KEY_PATH];
    pathAnimation.duration = 1.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    return pathAnimation;
}
- (UIColor*) strokeColor{
    if(self.delegate && [(NSObject*)self.delegate respondsToSelector:@selector(strokeChartColor)]){
        UIColor *strokeColor = [self.delegate strokeChartColor];
        if(strokeColor){
            return strokeColor;
        }
    }
    return [UIColor redColor];
}
- (UIColor*) fillColor{
    if(self.delegate && [(NSObject*)self.delegate respondsToSelector:@selector(fillChartColor)]){
        UIColor *fillColor = [self.delegate fillChartColor];
        if(fillColor){
            return fillColor;
        }
    }
    return [UIColor redColor];
}
- (CGPoint) getMargin{
    return CGPointMake(_xMargin, _yMargin);
}

@end
