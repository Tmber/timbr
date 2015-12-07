//
//  Category.h
//  timbr
//
//  Created by Chris Guzman on 11/19/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@interface LogCategory : NSObject

@property (nonatomic, strong) NSMutableArray *entries;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Entry *schemaEntry;

+(LogCategory *) getMockLog;

@end
