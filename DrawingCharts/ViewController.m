//
//  ViewController.m
//  DrawingCharts
//
//  Created by Diego Valenzuela on 11/17/14.
//  Copyright (c) 2014 Diego Valenzuela. All rights reserved.
//

#import "ViewController.h"
#import "E2D3M1LineChart.h"
#import "E2D3M1BarChart.h"
#import "E2D3M1CurvedLine.h"
@interface ViewController ()<E2D3M1GraphDelegate>
@property (nonatomic, strong) E2D3M1LineChart *lineChart;
@property (nonatomic, strong) E2D3M1BarChart *barChart;
@property (nonatomic, strong) E2D3M1LineChart *wallChart;
@property (nonatomic, strong) E2D3M1CurvedLine *curvedLineChart;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

NSMutableArray *numbers;

- (void)viewDidLoad {
     [super viewDidLoad];
    int totalIterations = 12;
    numbers = [NSMutableArray array];
    for(int i = 0; i < totalIterations; i++){
        NSInteger randomNumber = arc4random() % 16;
        [numbers addObject:[NSNumber numberWithInteger:randomNumber]];
    }
    
   // self.view.backgroundColor = [UIColor lightTextColor];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
  
    float width = self.view.frame.size.width-40;
    float height = 20;
   
   
    self.lineChart = [[E2D3M1LineChart alloc]initWithFrame:CGRectMake(20, height, width,width)];
    self.lineChart.delegate = self;
    [self.scrollView addSubview:self.lineChart];
    height +=  20+ width;
     
    self.barChart = [[E2D3M1BarChart alloc]initWithFrame:CGRectMake(20, height, width,width)];
    self.barChart.delegate = self;
    self.barChart.backgroundColor = [self chartBackgroundColor];
    [self.scrollView addSubview:self.barChart];
    height +=  20+ width;
    
    self.wallChart = [[E2D3M1LineChart alloc]initWithFrame:CGRectMake(20, height, width,width)];
    self.wallChart.isWallChartEnabled = YES;
    self.wallChart.delegate = self;
    [self.scrollView addSubview:self.wallChart];
    height +=  20+ width;
 
  
    self.curvedLineChart = [[E2D3M1CurvedLine alloc]initWithFrame:CGRectMake(20, height, width,width)];
 
    //self.curvedLineChart.delegate = self;
    [self.scrollView addSubview:self.curvedLineChart];
    height +=  20+ width;
    
    self.scrollView.contentSize = CGSizeMake(width, height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)valuesForYAxis {
     return numbers;
}

- (UIColor*) fillChartColor {
    return [UIColor lightTextColor];
}

- (UIColor*) strokeChartColor{
    return [UIColor magentaColor];
}

- (UIColor*) chartBackgroundColor{
    return [UIColor lightGrayColor];
}
@end
