//
//  IconPickerViewController.h
//  timbr
//
//  Created by Sean Kemper on 12/7/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerViewController;

@protocol IconPickerViewControllerDelegate <NSObject>

- (void)iconsPickedImage:(IconPickerViewController *)iconPickerViewController
                   image:(UIImage *)image
                    name:(NSString *)name;
@end

@interface IconPickerViewController : UIViewController

@property (nonatomic, weak) id<IconPickerViewControllerDelegate> delegate;

@end
