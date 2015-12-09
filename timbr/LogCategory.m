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

@end
