//
//  BarChart.m
//  DrawingCharts
//
//  Created by Diego Valenzuela on 11/17/14.
//  Copyright (c) 2014 Diego Valenzuela. All rights reserved.
//

#import "E2D3M1BarChart.h"

@implementation E2D3M1BarChart

- (void) drawRect:(CGRect)rect {
    
    [super drawRect:rect];
        
    UIColor *boxColor = [self fillColor];
    float height = self.frame.size.height;
    NSArray *yElements = [self.delegate valuesForYAxis];
    float startFrame = _scalingX;
    for (int l=0; l<yElements.count; l++) {
        id element = yElements[l];
        if([element isKindOfClass:[NSNumber class]]) {
            float valueY = [(NSNumber*)element floatValue];
            float mY= (valueY * _scalingY) + _yMargin;
     
            UIView *vwBar = [[UIView alloc]initWithFrame:CGRectMake(startFrame, height, _scalingX * 2, -mY )];
            vwBar.layer.borderWidth = kLINE_WIDTH;
            vwBar.layer.borderColor = [self.delegate strokeChartColor].CGColor;
            startFrame += (_scalingX * 4);
            vwBar.backgroundColor = boxColor;
            vwBar.tag = 2780 + l;
            [self addSubview:vwBar];
        }
    }
}

 
@end
