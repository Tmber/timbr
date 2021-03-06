//
//  Field.h
//  timbr
//
//  Created by Chris Guzman on 11/23/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const FieldTypeNumber;
FOUNDATION_EXPORT NSString *const FieldTypeDecimal;
FOUNDATION_EXPORT NSString *const FieldTypeCurrency;

@interface Field : NSObject <NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *numberValue;
@property (nonatomic, strong) NSString *dataType;
@property (nonatomic, strong) NSDate *dateValue;
@property (nonatomic, strong) NSString *stringValue;

-(UIKeyboardType) getKeyboardType;
- (NSString *) getFormattedValue;

+(Field *) getMockField1;
+(Field *) getMockField2;
+(Field *) getMockFielda;
+(Field *) getMockFieldb;
+(Field *) getMockField1:(double)num;
+(Field *) getMockField2:(double)num;

@end
