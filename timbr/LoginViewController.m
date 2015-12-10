//
//  LoginViewController.m
//  collection-test
//
//  Created by Sean Kemper on 11/25/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "HomeCollectionViewController.h"
#import "MBProgressHUD.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Welcome";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSignup:(id)sender {
    PFUser *user = [PFUser user];
    user.password = self.password.text;
    user.email = self.emailText.text;
    user.username = user.email;
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.emailText.text forKey:@"email"];
            [defaults setObject:self.password.text forKey:@"password"];
            [defaults synchronize];
            HomeCollectionViewController *hvc = [[HomeCollectionViewController alloc] init];
            [self.navigationController setViewControllers:@[hvc] animated:YES];
        } else {   NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Signup Error!"
                                                                           message:errorString
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (IBAction)onLogin:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [PFUser logInWithUsernameInBackground:self.emailText.text password:self.password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                            [defaults setObject:self.emailText.text forKey:@"email"];
                                            [defaults setObject:self.password.text forKey:@"password"];
                                            [defaults synchronize];
                                            // Do stuff after successful login.
                                            HomeCollectionViewController *hvc = [[HomeCollectionViewController alloc] init];
                                            [self.navigationController setViewControllers:@[hvc] animated:YES];
                                        } else {
                                            // The login failed. Check error to see why.
                                            NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
                                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Login Error!"
                                                                                                           message:errorString
                                                                                                    preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                                                  handler:^(UIAlertAction * action) {}];
                                            
                                            [alert addAction:defaultAction];
                                            [self presentViewController:alert animated:YES completion:nil];
                                        }
                                    }];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
