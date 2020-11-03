//
//  RJMainViewController.m
//  RJWindowDemo
//
//  Created by TouchWorld on 2020/10/28.
//

#import "RJMainViewController.h"
#import "RJChartLandscapeManager.h"
#import "RJChartRotationHelper.h"
#import <Masonry/Masonry.h>
#import <Charts/Charts-Swift.h>

@interface RJMainViewController () <ChartViewDelegate>

/// <#Desription#>
@property (nonatomic, weak) UIView *containerView;
/// <#Desription#>
@property (nonatomic, weak) UIView *contentView;
/// <#Desription#>
@property (nonatomic, weak) UITextField *textF;
///
@property (nonatomic, weak) LineChartView *chartView;

@end

@implementation RJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *containerView = [[UIView alloc] init];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view).mas_offset(CGPointMake(0, -200.0));
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(200.0);
    }];
    self.containerView = containerView;
    containerView.backgroundColor = [UIColor purpleColor];
    
    // 1.contentView不能使用自动布局；
    // 2.contentView不能在viewWillLayoutSubviews方法里设置frame。 因为更换窗口后会再次调用此方法，造成contentView的frame一直固定
    // 3.contentView的大小跟containerView一致。
    UIView *contentView = [[UIView alloc] init];
    [containerView addSubview:contentView];
    contentView.frame = containerView.bounds;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentView = contentView;
    contentView.backgroundColor = [UIColor orangeColor];

    UITextField *textF = [[UITextField alloc] init];
    [contentView addSubview:textF];
    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(100.0, 30.0));
    }];
    self.textF = textF;
    textF.backgroundColor = [UIColor whiteColor];
    textF.text = @"测试一下";
    
//    [self setupLineChartView];
    
    RJChartLandscapeManager *manager = [RJChartLandscapeManager shareInstance];
    manager.contentView = self.contentView;
    manager.orientationWillChange = ^(BOOL isFullScreen) {
        RJAllowOrentitaionRotation = isFullScreen;
    };
}

- (void)setupLineChartView
{
    LineChartView *chartView = [[LineChartView alloc] initWithFrame:CGRectZero];
    [self.containerView addSubview:chartView];
    chartView.frame = self.containerView.bounds;
    chartView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.chartView = chartView;
    self.contentView = self.chartView;
    
    chartView.backgroundColor = [UIColor orangeColor];
    //表格距右边的间距
    chartView.extraRightOffset = 0.0;
    //表格距离底部图例的距离
    chartView.extraBottomOffset = 10.0;
    chartView.delegate = self;
    //底部图例
    chartView.legend.enabled = NO;
    chartView.legend.formToTextSpace = 5.0;
    chartView.legend.formSize = 15.0;
    chartView.legend.font = [UIFont systemFontOfSize:13.0];
    chartView.legend.textColor = [UIColor blackColor];
    //    chartView.legend.
    //拖拽后是否有惯性效果
    chartView.dragDecelerationEnabled = YES;
    //拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    chartView.dragDecelerationFrictionCoef = 0.9;
    
    //x轴
    ChartXAxis *xAxis = chartView.xAxis;
    xAxis.drawGridLinesEnabled = NO;
    //X轴label的显示位置，默认是显示在上面的
    xAxis.labelPosition = XAxisLabelPositionBottom;
    //设置label间隔，若设置为1，则如果能全部显示，则每个柱形下面都会显示label
    xAxis.labelCount = 7;
    xAxis.labelFont = [UIFont systemFontOfSize:10];
    xAxis.labelTextColor = [UIColor blackColor];
    //标签间隔
    xAxis.granularity = 1;
    //避免首尾lable被剪切
    xAxis.avoidFirstLastClippingEnabled = NO;
    //自动换行
    xAxis.wordWrapEnabled = YES;
    //左轴
    ChartYAxis *leftAxis = chartView.leftAxis;
    
    leftAxis.drawGridLinesEnabled = YES;
    //设置虚线样式的网格线
    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];
    //网格线颜色
    leftAxis.gridColor = [UIColor colorWithRed:160/255.0f green:160/255.0f blue:160/255.0f alpha:1];
    //网格线开启抗锯齿
    leftAxis.gridAntialiasEnabled = YES;
    //设置Y轴的最小值
    leftAxis.axisMinimum = 0;
    
    //右轴
    ChartYAxis *rightAxis = chartView.rightAxis;
    rightAxis.enabled = NO;
    
    [self updateChartViewDatas];
}

- (void)updateChartViewDatas {
    [self setDataCount:10.0 range:10.0];
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double val = arc4random_uniform(range) + 3;
        [values addObject:[[ChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
    }
    
    LineChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        [set1 replaceEntries: values];
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithEntries:values label:@"DataSet 1"];
        
        set1.drawIconsEnabled = NO;
        
        set1.lineDashLengths = @[@5.f, @2.5f];
        set1.highlightLineDashLengths = @[@5.f, @2.5f];
        [set1 setColor:UIColor.blackColor];
        [set1 setCircleColor:UIColor.blackColor];
        set1.lineWidth = 1.0;
        set1.circleRadius = 3.0;
        set1.drawCircleHoleEnabled = NO;
        set1.valueFont = [UIFont systemFontOfSize:9.f];
        set1.formLineDashLengths = @[@5.f, @2.5f];
        set1.formLineWidth = 1.0;
        set1.formSize = 15.0;
        
        NSArray *gradientColors = @[
                                    (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
                                    (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
                                    ];
        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        
        set1.fillAlpha = 1.f;
        set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
        set1.drawFilledEnabled = YES;
        
        CGGradientRelease(gradient);
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        
        _chartView.data = data;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    RJChartLandscapeManager *manager = [RJChartLandscapeManager shareInstance];
    [manager enterFullScreen:YES animated:YES completed:nil];
}


@end
