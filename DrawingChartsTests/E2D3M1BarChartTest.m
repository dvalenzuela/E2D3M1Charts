//
//  ADCBarChartTest.m
//  DrawingCharts
//
//  Created by Diego Valenzuela on 11/18/14.
//  Copyright (c) 2014 Diego Valenzuela. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "E2D3M1BarChart.h"
@interface E2D3M1BarChartTest : XCTestCase<E2D3M1GraphDelegate>
@property (nonatomic, strong) E2D3M1BarChart *barChart;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UIColor *sampleColor;
@end

@implementation E2D3M1BarChartTest

- (void)setUp {
    [super setUp];
    self.barChart = [[E2D3M1BarChart alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.barChart.delegate = self;
    self.sampleColor = nil;
}

- (void)tearDown {
    [self.items removeAllObjects];
    self.items = nil;
    self.barChart.delegate = nil;
    [self.barChart cleanSubViews];
    self.barChart = nil;
    [super tearDown];
}
- (void) testSubViewCount{
    [self createArrayOfNumbers:100];
    [self.barChart drawRect:self.barChart.frame];
    bool isSubViewCountEqual = self.barChart.subviews.count == self.items.count;
        XCTAssert(isSubViewCountEqual, @"SubView Count is Equal");
}
- (void) testSubViewWidth{
    [self createArrayOfNumbers:1];
    [self.barChart drawRect:self.barChart.frame];
    UIView *subView = self.barChart.subviews[0];
                       
    bool isSubViewRightSize = subView.frame.size.width == self.barChart.frame.size.width / (self.items.count * 4.0);
    XCTAssert(isSubViewRightSize, @"SubView Size is Correct");

}
- (void) testSubViewDefaultColor{
    [self.barChart cleanSubViews];
    [self.barChart drawRect:self.barChart.frame];
    UIView *subView = self.barChart.subviews[0];
    bool isRightColor =subView.backgroundColor == [UIColor redColor];
    XCTAssert(isRightColor, @"SubView Default Color is Correct");
}

- (void) testSubViewCustomColor{
    self.sampleColor = [UIColor yellowColor];
    [self.barChart cleanSubViews];
    [self.barChart drawRect:self.barChart.frame];
    UIView *subView = self.barChart.subviews[0];
    bool isRightColor =subView.backgroundColor == [UIColor yellowColor];
    XCTAssert(isRightColor, @"SubView Custom Color is Correct");
}


- (void)testPerformanceFor10000ItemsChart {
    [self createArrayOfNumbers:10000];
    [self measureBlock:^{
        [self.barChart drawRect:self.barChart.frame];
    }];
}
- (void)testPerformanceFor1000ItemsChart {
    [self createArrayOfNumbers:1000];
    [self measureBlock:^{
        [self.barChart drawRect:self.barChart.frame];
    }];
}


- (void)testPerformanceFor100ItemsChart {
    [self createArrayOfNumbers:100];
    [self measureBlock:^{
        [self.barChart drawRect:self.barChart.frame];
    }];
}

- (void)testPerformanceFor10ItemsChart {
    [self createArrayOfNumbers:10];
    [self measureBlock:^{
        [self.barChart drawRect:self.barChart.frame];
    }];
}
- (void) createArrayOfNumbers:(int) total{
    [self.items removeAllObjects];
    for(int i = 0; i < total; i++){
        NSInteger randomNumber = arc4random() % 2780;
        [self.items addObject:[NSNumber numberWithInteger:randomNumber]];
    }
}
- (UIColor*) fillChartColor{
    return self.sampleColor;
}
- (NSArray *)valuesForYAxis{
    return self.items;
}
@end
