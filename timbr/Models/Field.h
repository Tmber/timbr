//
//  Field.h
//  timbr
//
//  Created by Chris Guzman on 11/23/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Field : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *numberValue;
@property (nonatomic, strong) NSDate *dateValue;
@property (nonatomic, strong) NSString *stringValue;

+(Field *) getMockField1;
+(Field *) getMockField2;

@end
