//
//  ChartTableViewCell.h
//  timbr
//
//  Created by Chris Guzman on 11/23/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *subView;
@property NSArray* data;

@end
