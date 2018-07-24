//
//  LoginViewController.m
//  GO
//
//  Created by Amy Liu on 7/23/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

#pragma mark - Users

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.username;
    newUser.password = self.password;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            // manually segue to logged in view
            // [self performSegueWithIdentifier:@"FeedViewController" sender:nil];
        }
    }];
}

- (void)loginUser {
    NSString *username = self.username;
    NSString *password = self.password;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            // display view controller that needs to shown after successful login
            // [self performSegueWithIdentifier:@"FeedViewController" sender:nil];
        }
    }];
}

@end
