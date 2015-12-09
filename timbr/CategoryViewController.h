//
//  CategoryViewController.h
//  timbr
//
//  Created by Ankush Raina on 12/1/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogCategory.h"

@class CategoryViewController;

@protocol CategoryViewControllerDelegate <NSObject>

- (void)categoryViewControllerLogCategoryUpdated:(LogCategory *)logCategory;

@end

@interface CategoryViewController : UIViewController

@property (strong, nonatomic) LogCategory *logCategory;
@property (weak, nonatomic) id<CategoryViewControllerDelegate> delegate;

@end
