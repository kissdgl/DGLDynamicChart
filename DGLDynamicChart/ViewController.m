//
//  ViewController.m
//  DGLDynamicChart
//
//  Created by Autel_Ling on 2017/1/5.
//  Copyright © 2017年 Autel. All rights reserved.
//

#import "ViewController.h"

#import "UILiveDataGraphView.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILiveDataGraphView *graphView;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSTimer *dataTimer;
@property (nonatomic, strong) NSTimer *graphTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 320, 120)];
    [self.view addSubview:self.contentView];
    
    self.graphView = [[UILiveDataGraphView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.graphView];
    
    self.graphView.fBeginTime = [[NSDate new] timeIntervalSince1970];
    
    NSMutableArray *dataArr = [NSMutableArray array];
    self.dataDic = @{kDataMaxValue : @"100", kDataMinValue : @"0", kDataArray : dataArr};
    self.graphView.dataDic = self.dataDic;
    
    //定时器更新数据源
    self.dataTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(freshData) userInfo:nil repeats:YES];
    
    //定时器刷新图表
    self.graphTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(freshGraph) userInfo:nil repeats:YES];
}

- (void)dealloc {
    
    [self.dataTimer invalidate];
    [self.graphTimer invalidate];
    self.dataTimer = nil;
    self.graphTimer = nil;
}

- (void)freshData {
    
    
    NSMutableArray *dataArr = self.dataDic[kDataArray];
    
    double x = [[NSDate new] timeIntervalSince1970];
    NSString *xStr = [NSString stringWithFormat:@"%f", x];
    
    double y = 40.0 + arc4random_uniform(21);
    NSString *yStr = [NSString stringWithFormat:@"%.1f", y];
    
    NSDictionary *dict = @{@"x" : xStr, @"y" : yStr};
    [dataArr insertObject:dict atIndex:0];
    
}

- (void)freshGraph {
    
    [self.graphView setNeedsDisplay];
}



@end
