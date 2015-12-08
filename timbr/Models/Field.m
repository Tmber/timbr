//
//  Field.m
//  timbr
//
//  Created by Chris Guzman on 11/23/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "Field.h"

NSString *const FieldTypeNumber = @"Number";
NSString *const FieldTypeDecimal = @"Decimal";
NSString *const FieldTypeCurrency = @"Currency";

@implementation Field

-(UIKeyboardType) getKeyboardType {
    if (self.dataType == FieldTypeNumber) {
        return UIKeyboardTypeNumberPad;
    } else if (self.dataType == FieldTypeDecimal) {
        return UIKeyboardTypeDecimalPad;
    } else if (self.dataType == FieldTypeCurrency) {
        return UIKeyboardTypeDecimalPad;
    } else {
        return UIKeyboardTypeDefault;
    }
}

-(void) save:(PFObject *)entry{
    PFObject *parseField = [PFObject objectWithClassName:@"Field"];
    parseField[@"parent"] = entry;
    parseField[@"name"] = _name;
    if (_numberValue) {
        parseField[@"numberValue"] = _numberValue;
    }
    if (_dateValue) {
        parseField[@"dateValue"] = _dateValue;
    }
    if (_stringValue) {
        parseField[@"stringValue"] = _stringValue;
    }
    [parseField saveEventually:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Field saved");
        }
    }];
}

+(Field *) getMockFielda{
    Field *fld = [[Field alloc] init];
    srand48(time(0));
    double r = drand48();
    fld.name = @"Miles";
    fld.dataType = FieldTypeDecimal;
    fld.numberValue = @(r*100);
    return fld;
}

+(Field *) getMockFieldb{
    Field *fld = [[Field alloc] init];
    srand48(time(0));
    double r = drand48();
    fld.name = @"Miles";
    fld.dataType = FieldTypeDecimal;
    fld.numberValue = @(r*100);
    return fld;
}

+(Field *) getMockField1:(double)num{
    Field *fld = [[Field alloc] init];
    srand48(time(0));
    double r = drand48();
    fld.name = @"Miles";
    fld.dataType = FieldTypeDecimal;
    fld.numberValue = @((r + num) * 100);
    return fld;
}

+(Field *) getMockField1{
    Field *fld = [[Field alloc] init];
    srand48(time(0));
    double r = drand48();
    fld.name = @"Gas Price";
    fld.dataType = FieldTypeCurrency;
    fld.numberValue = @(2 + r);
    return fld;
}

+(Field *) getMockField2{
    Field *fld = [[Field alloc] init];
    srand48(time(0));
    double r = drand48();
    fld.name = @"Gas Price";
    fld.dataType = FieldTypeCurrency;
    fld.numberValue = @(2 + r);
    return fld;
}

+(Field *) getMockField2:(double)num{
    Field *fld = [[Field alloc] init];
    srand48(time(0));
    double r = drand48();
    fld.name = @"Gas Price";
    fld.dataType = FieldTypeCurrency;
    fld.numberValue = @(2 + (r + num));
    return fld;
}
@end
