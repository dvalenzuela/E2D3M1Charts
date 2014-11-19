//
//  ADCCurvedLine.m
//  DrawingCharts
//
//  Created by Diego Valenzuela on 11/18/14.
//  Copyright (c) 2014 Diego Valenzuela. All rights reserved.
//

#import "E2D3M1CurvedLine.h"

@implementation E2D3M1CurvedLine

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [self setUpContextForRect:rect];
    
    NSMutableArray *drawPath = [NSMutableArray array];
    UIBezierPath *lineBezierPath=[[UIBezierPath alloc]init];
    lineBezierPath.lineWidth = kLINE_WIDTH;
    lineBezierPath.lineJoinStyle=kCGLineJoinRound;
    
    [lineBezierPath moveToPoint:CGPointMake(0,0)];
    [lineBezierPath addLineToPoint:CGPointMake(150.0, 150.0)];
   
    [lineBezierPath addQuadCurveToPoint:CGPointMake(_gridWidth/2.0,0) controlPoint:CGPointMake(_gridWidth/4.0, _gridHeight)];
    
    [lineBezierPath addLineToPoint:CGPointMake(_gridWidth, 50.0)];
    
 
    
    
    
    [drawPath addObject:lineBezierPath];
    UIColor *strokeColor = [self strokeColor];
    for (int i=0; i<[drawPath count]; i++){
        [strokeColor setStroke];
        UIBezierPath *bzPath=[drawPath objectAtIndex:i];
        [bzPath strokeWithBlendMode:kCGBlendModeNormal alpha:kALPHA_VALUE];
    }
    
    
    UIGraphicsPopContext();
    CGContextFlush(_ctx);
}



@end
