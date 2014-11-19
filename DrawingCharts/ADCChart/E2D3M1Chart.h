//
//  ADCChart.h
//  DrawingCharts
//
//  Created by Diego Valenzuela on 11/17/14.
//  Copyright (c) 2014 Diego Valenzuela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "E2D3M1GraphDelegate.h"
#import "E2D3M1DrawingHelpers.h"
#define PATH_ANIMATION_KEY_PATH @"strokeEnd"
#define kALPHA_VALUE 1.0
#define kLINE_WIDTH 1.0
@interface E2D3M1Chart : UIView{
    float           _xMargin;
    float           _yMargin;
    float           _scalingY;
    float           _scalingX;
    
    float           _gridWidth;
    float           _gridHeight;
    
    float           _itemCount;
    float           _maxValue;
    float           _minValue;
    CGContextRef    _ctx;
}
@property id<E2D3M1GraphDelegate> delegate;
- (id) initWithFrame:(CGRect)rect andBorder:(CGPoint) point;
- (void) cleanSubViews;
- (void) setUpContextForRect:(CGRect)rect;

- (CABasicAnimation*) pathAnimation  NS_DEPRECATED_IOS(3_0, 9_0, "Please contact Diego Valenzuela");

- (UIColor*) fillColor;
- (UIColor*) strokeColor;
- (CGPoint) getMargin;

@end
