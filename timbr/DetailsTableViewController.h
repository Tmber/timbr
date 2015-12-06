//
//  DetailsTableViewController.h
//  timbr
//
//  Created by Chris Guzman on 11/21/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogCategory.h"

@interface DetailsTableViewController : UITableViewController

@property (strong, nonatomic) LogCategory *logCategory;

@end
