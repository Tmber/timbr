//
//  Entry.h
//  timbr
//
//  Created by Chris Guzman on 11/19/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, strong) NSDate *date;

@end
