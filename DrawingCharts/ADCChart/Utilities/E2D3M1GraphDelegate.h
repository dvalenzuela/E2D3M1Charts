//
//  GraphDelegate.h
//  DrawingCharts
//
//  Created by Diego Valenzuela on 11/17/14.
//  Copyright (c) 2014 Diego Valenzuela. All rights reserved.
//

#ifndef DrawingCharts_GraphDelegate_h
#define DrawingCharts_GraphDelegate_h


#endif
@protocol E2D3M1GraphDelegate
- (NSArray *)valuesForYAxis;

@optional
- (UIColor*) chartBackgroundColor;
- (UIColor*) fillChartColor;
- (UIColor*) strokeChartColor;


//-(NSArray *)valuesForXAxis;
//-(NSArray *)titlesForXAxis;
//-(NSArray *)titlesForYAxis;
@end