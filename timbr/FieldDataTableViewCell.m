//
//  FieldDataTableViewCell.m
//  timbr
//
//  Created by Ankush Raina on 12/3/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "FieldDataTableViewCell.h"

@interface FieldDataTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *fieldNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *fieldValueTextField;

@end

@implementation FieldDataTableViewCell
- (IBAction)textFieldEditingDidEnd:(id)sender {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    self.field.numberValue  = [numberFormatter numberFromString:self.fieldValueTextField.text];
    NSLog(@"Number set %@", self.field.numberValue);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setField:(Field *)field {
    _field = field;
    
    self.fieldNameLabel.text = self.field.name;
    if (self.field.numberValue) {
        self.fieldValueTextField.text = [NSString stringWithFormat:@"%@", self.field.numberValue];
    }
    
    [self.fieldValueTextField setKeyboardType:[self.field getKeyboardType]];
}

@end
