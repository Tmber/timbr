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

@end
