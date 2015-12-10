//
//  Entry.h
//  timbr
//
//  Created by Chris Guzman on 11/19/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject <NSCopying>

@property (nonatomic, strong) NSMutableArray *fields;

+(Entry *)getMockEntry1;
+(Entry *)getMockEntry2;
+(Entry *)getMockEntry3;
+(Entry *)getMockEntry4;

+(Entry *)carMockEntry1;
+(Entry *)carMockEntry2;
+(Entry *)carMockEntry3;

+(Entry *)fitnessMockEntry1;
+(Entry *)fitnessMockEntry2;
+(Entry *)fitnessMockEntry3;

+(Entry *)runningMockEntry1;
+(Entry *)runningMockEntry2;
+(Entry *)runningMockEntry3;

@end
