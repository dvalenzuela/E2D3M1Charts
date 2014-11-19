//
//  DrawingHelpers.m
//  DrawingCharts
//
//  Created by Diego Valenzuela on 11/17/14.
//  Copyright (c) 2014 Diego Valenzuela. All rights reserved.
//

#import "E2D3M1DrawingHelpers.h"

@implementation E2D3M1DrawingHelpers
+(float)CalculateGridWidth:(float)gwidth leftMargin:(float)lMargin rightMargin:(float)rMargin yAxisSpace:(float)ySpace {
    float _gridWidth=gwidth;
    _gridWidth-=lMargin;
    _gridWidth-=rMargin;
    _gridWidth-=ySpace;
    return _gridWidth;
}


+(float)CalculateGridHeight:(float)gheight bottomMargin:(float)bMargin topMargin:(float)tMargin xAxisSpace:(float)xSpace {
    float _gridHeight=gheight;
    _gridHeight-=bMargin;
    _gridHeight-=tMargin;
    _gridHeight-=xSpace;
    return _gridHeight;
}

+(float)findScaleForYTile:(float)yValElementsCount gridHeight:(float)gridHeight tileHeight:(float)tileHeight hLines:(int)countHLines Min:(float)minOfY Max:(float)maxOfY {
    float _scalingY = 0;
    if(minOfY==0 && maxOfY==0) {
        if(yValElementsCount * tileHeight > gridHeight)
            _scalingY=gridHeight/yValElementsCount;
        else
            _scalingY=tileHeight;
        
        return _scalingY;
    }
    
    float _gridHeight=gridHeight;
    
    float _tileHeight=tileHeight;
    
    int HorLines=_gridHeight/_tileHeight;

    float ppt;
    int divider=0;
    
    if(HorLines<=3)divider=3;
    else divider=HorLines-1;
    
    NSUInteger countDigits=[[NSString stringWithFormat:@"%.0f",minOfY] length];
    if(minOfY<0){
        countDigits=countDigits-1;
    }
    
    if(countDigits==1)countDigits=2;
    
    minOfY=minOfY/pow(10, countDigits-1);
    minOfY=floorf(minOfY);
    minOfY=minOfY*pow(10, countDigits-1);
    
    if(maxOfY==minOfY) ppt=(maxOfY)/divider;
    else ppt=(maxOfY-minOfY)/divider;
    
    countDigits=[[NSString stringWithFormat:@"%.0f",ppt] length];
    
    ppt=ppt/pow(10, countDigits-1);
    ppt=ceilf(ppt);
    ppt=ppt*pow(10, countDigits-1);
    
    _scalingY=_tileHeight/ppt;
    
    return _scalingY;
}

@end
