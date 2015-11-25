//
//  Category.m
//  timbr
//
//  Created by Chris Guzman on 11/19/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "LogCategory.h"
#import "Entry.h"

@implementation LogCategory

+(LogCategory *)getMockLog{
    LogCategory *log = [[LogCategory alloc] init];
    log.name = @"Car Maintenance";
    log.entries = [NSMutableArray array];
    [log.entries addObject:@[[Entry getMockEntry1]]];
    [log.entries addObject:@[[Entry getMockEntry1]]];
    return log;
}

@end
