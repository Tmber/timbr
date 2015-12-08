//
//  Category.m
//  timbr
//
//  Created by Chris Guzman on 11/19/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "LogCategory.h"
#import "Entry.h"
#import "Field.h"

@implementation LogCategory

// @property (nonatomic, strong) Entry *schemaEntry;

- (void) setSchemaEntry:(Entry *)schemaEntry {
    // Set number value to zero
    for (Field *item in schemaEntry.fields) {
        item.numberValue = 0;
    }

    _schemaEntry = schemaEntry;
}

+(LogCategory *)getMockLog{
    LogCategory *log = [[LogCategory alloc] init];
    log.name = @"Car Maintenance";
    log.image = [UIImage imageNamed:@"ic_build_48pt"];
    log.entries = [NSMutableArray array];
    log.schemaEntry = [Entry getMockEntry1];
    [log.entries addObject:[Entry getMockEntry1]];
    [log.entries addObject:[Entry getMockEntry2]];
    [log.entries addObject:[Entry getMockEntry3]];
    [log.entries addObject:[Entry getMockEntry4]];
    return log;
}

@end
