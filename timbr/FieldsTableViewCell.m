//
//  FieldsTableViewCell.m
//  timbr
//
//  Created by Ankush Raina on 12/2/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "FieldsTableViewCell.h"

@interface FieldsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *attributeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation FieldsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setField:(Field *)field {
    _field = field;
    
    self.attributeLabel.text = self.field.name;
    self.typeLabel.text = self.field.dataType;
}

- (IBAction)onDeletePress:(id)sender {
    NSLog(@"Delete was pressed");
    
    [self.delegate fieldsTableViewCellDeletePressed:self];
}

@end
