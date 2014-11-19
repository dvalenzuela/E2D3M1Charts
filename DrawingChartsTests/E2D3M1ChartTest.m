//
//  E2D3M1ChartTest.m
//  DrawingCharts
//
//  Created by Diego Valenzuela on 11/18/14.
//  Copyright (c) 2014 Diego Valenzuela. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "E2D3M1Chart.h"
@interface E2D3M1ChartTest : XCTestCase<E2D3M1GraphDelegate>
@property (nonatomic, strong) E2D3M1Chart *zeroSizeChart;
@property (nonatomic, strong) E2D3M1Chart *emptyChart;
@property (nonatomic, strong) E2D3M1Chart *framedChart;
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation E2D3M1ChartTest
- (void)setUp {
    [super setUp];
    self.items = [NSMutableArray array];
    self.zeroSizeChart = [[E2D3M1Chart alloc]initWithFrame:CGRectZero];
    self.emptyChart = [[E2D3M1Chart alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.emptyChart.delegate = self;
    self.framedChart = [[E2D3M1Chart alloc]initWithFrame:CGRectMake(0, 0, 300, 300) andBorder:CGPointMake(10, 10)];
    self.framedChart.delegate = self;
}

- (void)tearDown {
    [self.zeroSizeChart cleanSubViews];
    [self.emptyChart cleanSubViews];
    [self.framedChart cleanSubViews];
    self.zeroSizeChart.delegate = nil;
    self.emptyChart.delegate = nil;
    self.framedChart.delegate = nil;
    self.zeroSizeChart = nil;
    self.emptyChart = nil;
    self.framedChart = nil;
    [super tearDown];
}
- (void) testZeroFrame{
    bool isZeroFrame = self.zeroSizeChart.frame.size.height ==0 && self.zeroSizeChart.frame.size.width ==0;
    XCTAssert(isZeroFrame, @"Pass ZeroFrame");
}
- (void) testSquareFrame{
    bool isZeroFrame = self.emptyChart.frame.size.height ==300 && self.emptyChart.frame.size.width ==300;
    XCTAssert(isZeroFrame, @"Pass ZeroFrame");
}
- (void) testFramedFrame{
    CGPoint frame  = [self.framedChart getMargin];
    bool isFramedCorrectly = frame.x == 10 && frame.y == 10;
    XCTAssert(isFramedCorrectly, @"Pass ZeroFrame");
}

- (void)testPerformanceForEmptyChart {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self.emptyChart drawRect:self.emptyChart.frame];
    }];
}
- (void)testPerformanceFor10000ItemsChart {
    [self createArrayOfNumbers:10000];
    [self measureBlock:^{
        [self.framedChart drawRect:self.framedChart.frame];
    }];
}
- (void)testPerformanceFor1000ItemsChart {
    [self createArrayOfNumbers:1000];
    [self measureBlock:^{
        [self.framedChart drawRect:self.framedChart.frame];
    }];
}


- (void)testPerformanceFor100ItemsChart {
    [self createArrayOfNumbers:100];
    [self measureBlock:^{
        [self.framedChart drawRect:self.framedChart.frame];
    }];
}

- (void)testPerformanceFor10ItemsChart {
    [self createArrayOfNumbers:10];
    [self measureBlock:^{
        [self.framedChart drawRect:self.framedChart.frame];
    }];
}
- (NSArray *)valuesForYAxis{
    return self.items;
}
- (void) createArrayOfNumbers:(int) total{
    [self.items removeAllObjects];
    for(int i = 0; i < total; i++){
        NSInteger randomNumber = arc4random() % 2780;
        [self.items addObject:[NSNumber numberWithInteger:randomNumber]];
    }
}
@end
