//
//  FieldsTableViewCell.h
//  timbr
//
//  Created by Ankush Raina on 12/2/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Field.h"

@class FieldsTableViewCell;

@protocol FieldsTableViewCellDelegate <NSObject>

- (void)fieldsTableViewCellDeletePressed:(FieldsTableViewCell *)cell;

@end


@interface FieldsTableViewCell : UITableViewCell

@property (strong, nonatomic) Field * field;
@property (weak, nonatomic) id<FieldsTableViewCellDelegate> delegate;

@end
