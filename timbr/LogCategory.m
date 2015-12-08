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

-(void) save:(PFUser *)user {
    PFObject *parseLog = [PFObject objectWithClassName:@"LogCategory"];
    parseLog[@"parent"] = user;
    parseLog[@"name"] = _name;
    for (Entry *entry in self.entries) {
        [entry save:parseLog];
    }
    [parseLog saveEventually:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Log saved");
        }
    }];
}

+(LogCategory *)getMockLog{
    LogCategory *log = [[LogCategory alloc] init];
    log.name = @"Car Maintenance";
    log.entries = [NSMutableArray array];
    log.schemaEntry = [Entry getMockEntry1];
    [log.entries addObject:[Entry getMockEntry1]];
    [log.entries addObject:[Entry getMockEntry2]];
    [log.entries addObject:[Entry getMockEntry3]];
    [log.entries addObject:[Entry getMockEntry4]];
    return log;
}

@end
