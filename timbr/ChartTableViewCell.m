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
    // Initialization code
    
    self.data = @[
                  @[
                      @{@"name": @"Miles",
                        @"value": @30,
                        @"dataType": [NSNumber class]
                        },
                      @{@"name": @"Gas Price",
                        @"value": @3.29,
                        @"dataType": [NSNumber class]
                        },
                      @{@"name": @"Mileage",
                        @"value": @50000,
                        @"dataType": [NSNumber class]
                        }
                      ],
                  @[
                      @{@"name": @"Miles",
                        @"value": @31,
                        @"dataType": [NSNumber class]
                        },
                      @{@"name": @"Gas Price",
                        @"value": @3.15,
                        @"dataType": [NSNumber class]
                        },
                      @{@"name": @"Mileage",
                        @"value": @50050,
                        @"dataType": [NSNumber class]
                        }
                      ],
                  @[
                      @{@"name": @"Miles",
                        @"value": @41,
                        @"dataType": [NSNumber class]
                        },
                      @{@"name": @"Gas Price",
                        @"value": @2.00,
                        @"dataType": [NSNumber class]
                        },
                      @{@"name": @"Mileage",
                        @"value": @50100,
                        @"dataType": [NSNumber class]
                        }
                      ],
                  @[
                      @{@"name": @"Miles",
                        @"value": @10,
                        @"dataType": [NSNumber class]
                        },
                      @{@"name": @"Gas Price",
                        @"value": @1.50,
                        @"dataType": [NSNumber class]
                        },
                      @{@"name": @"Mileage",
                        @"value": @50150,
                        @"dataType": [NSNumber class]
                        }
                      ],
                  ];
    NSMutableArray *xLabels = [[NSMutableArray alloc] init];
    
    for (NSArray *element in _data) {
        NSDictionary *dict = [element objectAtIndex:0];
        [xLabels addObject: [NSString stringWithFormat:@"%@", [dict objectForKey:@"value"]]];
    }
    
    NSMutableArray *yLabels1 = [[NSMutableArray alloc] init];
    
    for (NSArray *element in _data) {
        NSDictionary *dict = [element objectAtIndex:1];
        [yLabels1 addObject:[dict objectForKey:@"value"]];
    }
    
    NSMutableArray *yLabels2 = [[NSMutableArray alloc] init];
    
    for (NSArray *element in _data) {
        NSDictionary *dict = [element objectAtIndex:2];
        [yLabels2 addObject:[dict objectForKey:@"value"]];
    }
    
    
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0)];
    [lineChart setXLabels:xLabels];
    
    // Line Chart No.1
    NSArray * data01Array = yLabels1;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
//    // Line Chart No.2
//    NSArray * data02Array = yLabels2;
//    PNLineChartData *data02 = [PNLineChartData new];
//    data02.color = PNTwitterColor;
//    data02.itemCount = lineChart.xLabels.count;
//    data02.getData = ^(NSUInteger index) {
//        CGFloat yValue = [data02Array[index] floatValue];
//        return [PNLineChartDataItem dataItemWithY:yValue];
//    };
    
    lineChart.chartData = @[data01];
    [lineChart strokeChart];
    
    [self.subView addSubview:lineChart];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
