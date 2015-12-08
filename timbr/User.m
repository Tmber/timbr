//
//  User.m
//  timbr
//
//  Created by Chris Guzman on 12/3/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "User.h"

@implementation User

-(void)saveAllData{
    PFUser *parseUser = [PFUser currentUser];
    [parseUser setObject:_logCategories forKey:@"LogCategories"];
    [parseUser saveEventually:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Parse saved");
        }
    }];
    [parseUser pinInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"User pinned");
        }
    }];
}

-(LogCategory *)retrieveCategories{
    NSMutableArray *categories = [NSMutableArray array];
    PFQuery *userQuery = [PFUser query];
    [userQuery includeKey:@"LogCategory"];
    [userQuery whereKey:@"parent" equalTo:[PFUser currentUser].objectId];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSLog(@"%@", objects);
        [categories addObjectsFromArray:objects];
        
    }];
//    NSArray *parseCategories = [[PFUser currentUser] objectForKey:@"LogCategory"];
//    [categories addObjectsFromArray:parseCategories];
//    NSLog(@"%@", categories);
    return [categories objectAtIndex:0];
}

@end
