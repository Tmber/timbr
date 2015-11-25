//
//  Entry.m
//  timbr
//
//  Created by Chris Guzman on 11/19/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "Entry.h"
#import "Field.h"

@implementation Entry

+(Entry *)getMockEntry1{
    Entry *entry = [[Entry alloc] init];
    entry.fields = [[NSMutableArray alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObjectsFromArray:@[[Field getMockField1], [Field getMockField2], [Field getMockField1], [Field getMockField2], [Field getMockField1], [Field getMockField2]]];
    [entry.fields addObject:array];
    return entry;
}

@end
