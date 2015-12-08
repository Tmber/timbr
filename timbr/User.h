//
//  User.h
//  timbr
//
//  Created by Chris Guzman on 12/3/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@class LogCategory;
@interface User : NSObject

@property NSMutableArray *logCategories;

-(void)saveAllData;
-(LogCategory *)retrieveCategories;
@end
