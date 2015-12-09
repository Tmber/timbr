//
//  DetailsTableViewController.h
//  timbr
//
//  Created by Chris Guzman on 11/21/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogCategory.h"
#import "UIScrollView+EmptyDataSet.h"

@interface DetailsTableViewController : UITableViewController <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) LogCategory *logCategory;

@end
