//
//  TermsAndConditionsViewController.m
//  GO
//
//  Created by Ajaita Saini on 7/23/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "TermsAndConditionsViewController.h"
#import "AppDelegate.h"

@interface TermsAndConditionsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *termsConditionsText;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backToAgree;

@end

@implementation TermsAndConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTermsText];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTermsText {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"termsconditions" ofType:@"txt"];
    NSString* fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    //_termsConditionsText.text = fileContent;
    //NSLog(@"hello");
    NSLog(@"%@", fileContent);
}

- (IBAction)onTapBackButton:(id)sender {
    NSLog(@"tapped back button");
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AgreeToTerms" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"AgreeToTermsViewController"];
    appDelegate.window.rootViewController = viewController;
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
