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

-(id)init {
    if ( self = [super init] ) {
        _schemaEntry = [[Entry alloc] init];
        _schemaEntry.fields = [[NSMutableArray alloc] init];
        _entries = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) setSchemaEntry:(Entry *)schemaEntry {
    // Set number value to zero
    for (Field *item in schemaEntry.fields) {
        item.numberValue = 0;
    }

    _schemaEntry = schemaEntry;
}

-(id)copyWithZone:(NSZone *)zone
{
    LogCategory *copy = [[LogCategory alloc] init];

    copy.entries = [[NSMutableArray alloc] init];
    for (Entry *entry in self.entries) {
        [copy.entries addObject:[entry copyWithZone:zone]];
    }

    copy.name = [self.name copyWithZone:zone];
    copy.schemaEntry = [self.schemaEntry copyWithZone:zone];
    // TODO UIImage in model! Bad!
    copy.image = self.image;

    return copy;
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

+(LogCategory *)carMockLog{
    LogCategory *log = [[LogCategory alloc] init];
    log.name = @"Car Maintenance";
    log.image = [UIImage imageNamed:@"ic_build_48pt"];
    log.entries = [NSMutableArray array];
    log.schemaEntry = [Entry carMockEntry1];
    [log.entries addObject:[Entry carMockEntry1]];
    [log.entries addObject:[Entry carMockEntry2]];
    [log.entries addObject:[Entry carMockEntry3]];
    return log;
}

+(LogCategory *)fitnessMockLog{
    LogCategory *log = [[LogCategory alloc] init];
    log.name = @"Fitness";
    log.image = [UIImage imageNamed:@"ic_favorite_border_48pt"];
    log.entries = [NSMutableArray array];
    log.schemaEntry = [Entry fitnessMockEntry1];
    [log.entries addObject:[Entry fitnessMockEntry1]];
    [log.entries addObject:[Entry fitnessMockEntry2]];
    [log.entries addObject:[Entry fitnessMockEntry3]];
    return log;
}

+(LogCategory *)runningMockLog{
    LogCategory *log = [[LogCategory alloc] init];
    log.name = @"Running";
    log.image = [UIImage imageNamed:@"ic_timeline_48pt"];
    log.entries = [NSMutableArray array];
    log.schemaEntry = [Entry runningMockEntry1];
    [log.entries addObject:[Entry runningMockEntry1]];
    [log.entries addObject:[Entry runningMockEntry2]];
    [log.entries addObject:[Entry runningMockEntry3]];
    return log;
}

@end
