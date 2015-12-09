//
//  Category.h
//  timbr
//
//  Created by Chris Guzman on 11/19/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Entry.h"

@interface LogCategory : NSObject<NSCopying>

@property (nonatomic, strong) NSMutableArray *entries;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Entry *schemaEntry;
@property (nonatomic, strong) UIImage *image;

+(LogCategory *) getMockLog;

@end
