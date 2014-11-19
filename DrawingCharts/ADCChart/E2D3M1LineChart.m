//
//  LineChar.m
//  DrawingCharts
//
//  Created by Diego Valenzuela on 11/17/14.
//  Copyright (c) 2014 Diego Valenzuela. All rights reserved.
//

#import "E2D3M1LineChart.h"

@implementation E2D3M1LineChart

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
   
    [self setUpContextForRect:rect];
   
    NSMutableArray *drawPath = [NSMutableArray array];
    UIBezierPath *lineBezierPath=[[UIBezierPath alloc]init];
    lineBezierPath.lineWidth = kLINE_WIDTH;
    lineBezierPath.lineJoinStyle=kCGLineJoinRound;
   
    NSArray *yElements = [self.delegate valuesForYAxis];
    [lineBezierPath moveToPoint:CGPointMake(0,0)];
    float mX, mY;
    float valueY;
 
    mX = _scalingX;
    for (int l=0; l<yElements.count; l++) {
        id element = yElements[l];
        if([element isKindOfClass:[NSNumber class]]){
            valueY = [element floatValue] - _minValue;
            mY= (valueY * _scalingY) + _yMargin;
            
            if(l == yElements.count-1){
                [self addLinePath:lineBezierPath toPoint:CGPointMake(_gridWidth,mY)];
                mX += _gridWidth;
            }else{
                [self addLinePath:lineBezierPath toPoint:CGPointMake(mX,mY)];
                mX += (_scalingX * 4);
            }
        }
    }
    if(self.isWallChartEnabled){
        [self addLinePath:lineBezierPath toPoint:CGPointMake(mX, 0)];
    }
    [drawPath addObject:lineBezierPath];
    UIColor *strokeColor = [self strokeColor];
    for (int i=0; i<[drawPath count]; i++){
        [strokeColor setStroke];
        UIBezierPath *bzPath=[drawPath objectAtIndex:i];
        [bzPath strokeWithBlendMode:kCGBlendModeNormal alpha:kALPHA_VALUE];
    }
    
    if(self.isWallChartEnabled){
        UIColor *fillColor = [self fillColor];
         [self addLinePath:lineBezierPath toPoint:CGPointMake(0, 0)];
        for (int i=0; i<[drawPath count]; i++) {
            UIBezierPath *linePath=[drawPath objectAtIndex:i];
            [fillColor setFill];
            [linePath fillWithBlendMode:kCGBlendModeNormal alpha:kALPHA_VALUE];
        }
    }
    UIGraphicsPopContext();
    CGContextFlush(_ctx);
}


- (void) addLinePath:(UIBezierPath*)path toPoint:(CGPoint)point{
    if(self.isCurvedLinesEnabled){
   
    }else{
        [path addLineToPoint:point];
    }
}


@end
