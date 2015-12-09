//
//  DetailsViewController.h
//  timbr
//
//  Created by Ankush Raina on 12/8/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogCategory.h"
#import "UIScrollView+EmptyDataSet.h"

@interface DetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) LogCategory *logCategory;

@end
