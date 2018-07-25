//
//  CategoriesViewController.m
//  GO
//
//  Created by Joel Gutierrez on 7/24/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "CategoriesViewController.h"

@interface CategoriesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) registerNibs {
    UINib *imageNib = [UINib nibWithNibName:@"LargeImageTableViewCell" bundle:nil];
    [self.categoriesTableView registerNib:imageNib forCellReuseIdentifier:@"LargeImageTableViewCell"];
    
    UINib *collectionNib = [UINib nibWithNibName:@"CategoryCollectionView" bundle:nil];
    [self.categoriesTableView registerNib:collectionNib forCellReuseIdentifier:@"CategoryCollectionView"];
}

#pragma mark - tableview protocol

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2; //large image section and colletion view section
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        LargeImageTableViewCell *largeImageCell = [self.categoriesTableView dequeueReusableCellWithIdentifier:@"LargeImageTableViewCell"];
        
        return largeImageCell;
    } else { //indexPath.section == 1
        CategoryCollectionView *collectionView = [self.categoriesTableView dequeueReusableCellWithIdentifier:@"CategoryCollectionView"];
        
        return collectionView;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        [self performSegueWithIdentifier:@"categoriesToListSegue" sender:nil];
        NSLog(@"category selected - segue and send other data through");
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //categor
    ListViewController *listController = [segue destinationViewController];
    //ListViewController.location = tappedCell.location;
}

@end
