//
//  ChartTableViewCell.m
//  timbr
//
//  Created by Chris Guzman on 11/23/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "ChartTableViewCell.h"
#import "PNChart.h"

@implementation ChartTableViewCell

- (void)awakeFromNib {
    
}

- (void) setLogCategory:(LogCategory *)logCategory {
    _logCategory = logCategory;
    [self setupChart];
}

- (void) setupChart {
    [[self.belowView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (self.logCategory.entries.count > 0 && self.logCategory.schemaEntry.fields.count > 0) {
        NSArray* colorArray = @[
                                       PNGreen,
                                       PNTitleColor,
                                       PNRed,
                                       PNMauve,
                                       PNBlack,
                                       PNBlue,
                                       PNBrown,
                                       PNYellow
                                       ];
        NSMutableArray *xLabels = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < self.logCategory.entries.count; i++) {
            [xLabels addObject: [NSString stringWithFormat:@"%d", i + 1]];
        }
        
        PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0)];
        [lineChart setXLabels:xLabels];
        
        NSMutableArray *yLabelData = [NSMutableArray array];
        int index = 0;
        self.maxFieldCount = 1;
        while (index < self.maxFieldCount) {
            [yLabelData addObject: [self getArrayOfFieldNumberValues:index]];
            index++;
        }
        int fieldIndex = 0;
        NSMutableArray *chartDataArray = [NSMutableArray array];
        for (NSArray *array in yLabelData) {
            NSArray * dataArray = array;
            PNLineChartData *lineChartData = [PNLineChartData new];
            Field *field = [self.logCategory.schemaEntry.fields objectAtIndex:fieldIndex];
            lineChartData.dataTitle = field.name;
            fieldIndex++;
            lineChartData.color = [colorArray objectAtIndex:fieldIndex];
            lineChartData.itemCount = lineChart.xLabels.count;
            lineChartData.inflexionPointStyle = PNLineChartPointStyleTriangle;
            lineChartData.getData = ^(NSUInteger index) {
                CGFloat yValue = [dataArray[index] floatValue];
                return [PNLineChartDataItem dataItemWithY:yValue];
            };
            [chartDataArray addObject:lineChartData];
        }
        
        lineChart.chartData = chartDataArray;
        [lineChart strokeChart];
        [lineChart updateChartData:chartDataArray];
        
        [self.subView addSubview:lineChart];
        
        lineChart.legendStyle = PNLegendItemStyleStacked;
        lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
        lineChart.legendFontColor = [UIColor grayColor];
        
        UIView *legend = [lineChart getLegendWithMaxWidth:320];
        [legend setFrame:CGRectMake(30, 10, legend.frame.size.width, legend.frame.size.height)];
        [self.belowView addSubview:legend];
    }
    else {
        
    }
}


- (NSArray *)getArrayOfFieldNumberValues:(int)index {
    NSMutableArray *yLabelDataForLoop = [NSMutableArray array];
    for (Entry *tree in self.logCategory.entries) {
        if (tree.fields.count > self.maxFieldCount) {
            self.maxFieldCount = tree.fields.count;
        }
        if (index < tree.fields.count) {
            Field *field = [tree.fields objectAtIndex:index];
            [yLabelDataForLoop addObject: [NSString stringWithFormat:@"%@", field.numberValue]];
        }
    }
    return yLabelDataForLoop;
        
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
