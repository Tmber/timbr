//
//  FieldViewController.h
//  timbr
//
//  Created by Ankush Raina on 12/2/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Field.h"

@protocol FieldViewControllerDelegate <NSObject>

- (void)fieldViewControllerFieldUpdated:(Field *)field;

@end


@interface FieldViewController : UIViewController

@property (weak, nonatomic) id<FieldViewControllerDelegate> delegate;

@end
