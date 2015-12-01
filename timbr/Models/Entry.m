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
    [entry.fields addObjectsFromArray:@[[Field getMockField1:0.3], [Field getMockField2:0.3]]];
    return entry;
}

+(Entry *)getMockEntry2{
    Entry *entry = [[Entry alloc] init];
    entry.fields = [[NSMutableArray alloc] init];
    [entry.fields addObjectsFromArray:@[[Field getMockField1:0.4], [Field getMockField2:0.7]]];
    return entry;
}

+(Entry *)getMockEntry3{
    Entry *entry = [[Entry alloc] init];
    entry.fields = [[NSMutableArray alloc] init];
    [entry.fields addObjectsFromArray:@[[Field getMockField1:0.1], [Field getMockField2:0.5]]];
    return entry;
}

+(Entry *)getMockEntry4{
    Entry *entry = [[Entry alloc] init];
    entry.fields = [[NSMutableArray alloc] init];
    [entry.fields addObjectsFromArray:@[[Field getMockField1:0.2], [Field getMockField2:0.8]]];
    return entry;
}

@end
