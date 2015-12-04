//
//  LogCollection.h
//  timbr
//
//  Created by Ankush Raina on 12/3/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogCollection : NSObject

+(LogCollection *) sharedInstance;

@property(strong, nonatomic) NSMutableArray *logCategories;

@end
