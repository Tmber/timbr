//
//  LogCollection.m
//  timbr
//
//  Created by Ankush Raina on 12/3/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "LogCollection.h"
#import "LogCategory.h"

@implementation LogCollection

+(LogCollection *) sharedInstance {
    static LogCollection *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.logCategories = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i++) {
            [sharedInstance.logCategories addObject:[LogCategory getMockLog]];
        }
    });
    
    return sharedInstance;
}

@end
