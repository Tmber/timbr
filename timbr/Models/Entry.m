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

-(id)copyWithZone:(NSZone *)zone
{
    Entry *copy = [[Entry alloc] init];

    copy.fields = [[NSMutableArray alloc] init];
    for (Field *field in self.fields) {
        [copy.fields addObject:[field copyWithZone:zone]];
    }
    return copy;
}

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

+(Entry *)carMockEntry1 {
    Entry *entry = [[Entry alloc] init];
    entry.fields = [[NSMutableArray alloc] init];
    [entry.fields addObjectsFromArray:@[[Field mockField:@80 :@"Mileage" :@"Number"], [Field mockField:@12 :@"Gallons" :@"Decimal"], [Field mockField:@4.25 :@"Gas Price" :@"Currency"]]];
    return entry;
}
+(Entry *)carMockEntry2 {
    Entry *entry = [[Entry alloc] init];
    entry.fields = [[NSMutableArray alloc] init];
    [entry.fields addObjectsFromArray:@[[Field mockField:@96 :@"Mileage" :@"Number"], [Field mockField:@8 :@"Gallons" :@"Decimal"], [Field mockField:@2.58 :@"Gas Price" :@"Currency"]]];
    return entry;
}
+(Entry *)carMockEntry3 {
    Entry *entry = [[Entry alloc] init];
    entry.fields = [[NSMutableArray alloc] init];
    [entry.fields addObjectsFromArray:@[[Field mockField:@123 :@"Mileage" :@"Number"], [Field mockField:@1 :@"Gallons" :@"Decimal"], [Field mockField:@7.96 :@"Gas Price" :@"Currency"]]];
    return entry;
}

+(Entry *)fitnessMockEntry1{
    Entry *entry = [[Entry alloc] init];
    entry.fields = [[NSMutableArray alloc] init];
    [entry.fields addObjectsFromArray:@[[Field mockField:@189 :@"Weight" :@"Number"], [Field mockField:@203 :@"Gun size" :@"Number"], [Field mockField:@112 :@"Calories" :@"Number"]]];
    return entry;
}
+(Entry *)fitnessMockEntry2 {
    Entry *entry = [[Entry alloc] init];
    entry.fields = [[NSMutableArray alloc] init];
    [entry.fields addObjectsFromArray:@[[Field mockField:@191 :@"Weight" :@"Number"], [Field mockField:@230 :@"Gun size" :@"Number"], [Field mockField:@180 :@"Calories" :@"Number"]]];
    return entry;
}
+(Entry *)fitnessMockEntry3 {
    Entry *entry = [[Entry alloc] init];
    entry.fields = [[NSMutableArray alloc] init];
    [entry.fields addObjectsFromArray:@[[Field mockField:@185 :@"Weight" :@"Number"], [Field mockField:@215 :@"Gun size" :@"Number"], [Field mockField:@215 :@"Calories" :@"Number"]]];
    return entry;
}

+(Entry *)runningMockEntry1 {
    Entry *entry = [[Entry alloc] init];
    entry.fields = [[NSMutableArray alloc] init];
    [entry.fields addObjectsFromArray:@[[Field mockField:@4 :@"Laps" :@"Number"], [Field mockField:@4.5 :@"Lap Time" :@"Decimal"]]];
    return entry;
}
+(Entry *)runningMockEntry2 {
    Entry *entry = [[Entry alloc] init];
    entry.fields = [[NSMutableArray alloc] init];
    [entry.fields addObjectsFromArray:@[[Field mockField:@6 :@"Laps" :@"Number"], [Field mockField:@5.25 :@"Lap Time" :@"Decimal"]]];
    return entry;
}
+(Entry *)runningMockEntry3 {
    Entry *entry = [[Entry alloc] init];
    entry.fields = [[NSMutableArray alloc] init];
    [entry.fields addObjectsFromArray:@[[Field mockField:@8 :@"Laps" :@"Number"], [Field mockField:@6 :@"Lap Time" :@"Decimal"]]];
    return entry;
}

@end
