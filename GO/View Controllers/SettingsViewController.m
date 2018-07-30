//
//  SettingsViewController.m
//  GO
//
//  Created by Amy Liu on 7/24/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "SettingsViewController.h"
#import "User.h"
#import "UIImage+AFNetworking.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"

@interface SettingsViewController () <UIActionSheetDelegate>

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setProfile];
}

- (void)setProfile {
    
    self.image.file = User.currentUser.image;
    self.username.text = User.currentUser.username;
    self.name.text = User.currentUser.name;
    
    [self.image loadInBackground];
}

#pragma mark - Actions

- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapSave:(id)sender {
    [User.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        User.currentUser.image = self.image.file;
        User.currentUser.username = self.username.text;
        User.currentUser.name = self.name.text;
    }];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapProfile:(id)sender { // connect to imageview
    
    NSLog(@"thanks for tapping me!");
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController * view =   [UIAlertController
                                     alertControllerWithTitle:@"Change Profile Photo"
                                     message:nil
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* camera = [UIAlertAction
                             actionWithTitle:@"Take Photo"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
                                 [view dismissViewControllerAnimated:YES completion:nil];
                             }];
        UIAlertAction* gallery = [UIAlertAction
                                 actionWithTitle:@"Choose from Library"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                 }];
        
        
        [view addAction:camera];
        [view addAction:gallery];
        [self presentViewController:view animated:YES completion:nil];
        
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    [self reloadInputViews];
}

#pragma mark - Images

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:^{
        
        self.image.file = [self getPFFileFromImage:originalImage];
        [self.image loadInBackground];
    }];
}

#pragma mark - Conversion

- (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}

@end
