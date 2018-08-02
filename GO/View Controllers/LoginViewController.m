//
//  LoginViewController.m
//  GO
//
//  Created by Amy Liu on 7/23/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"

@implementation LoginViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (User.currentUser != nil) {
        [self performSegueWithIdentifier:@"profileSegue" sender:nil];
    }
    
}

#pragma mark - Actions

- (IBAction)didTapSignUp:(id)sender {
    [self registerUser];
}

- (IBAction)didTapLogIn:(id)sender {
    [self loginUser];
}

#pragma mark - Users

- (void)registerUser {
    // initialize a user object
    User *newUser = [User user];
    
    // set user properties
    newUser.username = self.username.text;
    newUser.password = self.password.text;
    newUser.name = nil;
    
    newUser.favorites = [[NSMutableArray alloc] init];
    newUser.reviews = [[NSMutableArray alloc] init];;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"setupSegue" sender:nil];
        }
    }];
}

- (void)loginUser {
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    
    [User logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"animatedSegue" sender:nil];
        }
    }];
}

@end
