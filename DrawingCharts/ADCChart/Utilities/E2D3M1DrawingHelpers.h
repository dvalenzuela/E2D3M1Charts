//
//  DrawingHelpers.h
//  DrawingCharts
//
//  Created by Diego Valenzuela on 11/17/14.
//  Copyright (c) 2014 Diego Valenzuela. All rights reserved.
//

#import <Foundation/Foundation.h>
 
@interface E2D3M1DrawingHelpers : NSObject
+(float)CalculateGridWidth:(float)gwidth leftMargin:(float)lMargin rightMargin:(float)rMargin yAxisSpace:(float)ySpace;
+(float)CalculateGridHeight:(float)gheight bottomMargin:(float)bMargin topMargin:(float)tMargin xAxisSpace:(float)xSpace;
+(float)findScaleForYTile:(float)yValElementsCount gridHeight:(float)gridHeight tileHeight:(float)tileHeight hLines:(int)countHLines Min:(float)minOfY Max:(float)maxOfY;
@end
