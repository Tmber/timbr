//
//  Category.h
//  timbr
//
//  Created by Chris Guzman on 11/19/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class Entry;
@interface LogCategory : NSObject

@property (nonatomic, strong) NSMutableArray *entries;
@property (nonatomic, strong) NSString *name;
@property Entry *schemaEntry;

+(LogCategory *) getMockLog;

-(void) save:(PFUser *)user;

@end
