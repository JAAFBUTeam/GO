//
//  DetailedViewController.m
//  GO
//
//  Created by Amy Liu on 7/13/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "DetailsViewController.h"
#import "InfoTableViewCell.h"
#import "TitleTableViewCell.h"
#import "ReviewsTableViewCell.h"

@interface DetailsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

typedef enum {
    CAROUSEL = 0,
    INFO = 1,
    TITLE_INFO = 2,
    REVIEW_1 = 3,
    REVIEW_2 = 4,
    REVIEW_3 = 5,
    TITLE_PHOTOS = 6,
    IMAGE_COLLECTION = 7
} cell_state;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UINib *infoTableViewCell = [UINib nibWithNibName:@"InfoTableViewCell" bundle:nil];
    [_tableView registerNib:infoTableViewCell forCellReuseIdentifier:@"InfoTableViewCell"];
    
    UINib *titleTableViewCell = [UINib nibWithNibName:@"TitleTableViewCell" bundle:nil];
    [_tableView registerNib:titleTableViewCell forCellReuseIdentifier:@"TitleTableViewCell"];
    
    UINib *reviewTableViewCell = [UINib nibWithNibName:@"ReviewTableViewCell" bundle:nil];
    [_tableView registerNib:reviewTableViewCell forCellReuseIdentifier:@"ReviewTableViewCell"];
    
//    UINib *photoCollectionViewCell = [UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil];
//    [_tableView registerNib:photoCollectionViewCell forCellReuseIdentifier:@"photoCollectionViewCell"];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
<<<<<<< HEAD
   
    InfoTableViewCell *infoTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
    infoTableViewCell.title.text = @"I am a location";
    return infoTableViewCell;
    
=======
    //enum cell_state current_state = indexPath.row;
    
//    @property (weak, nonatomic) IBOutlet UIImageView *userImage;
//    @property (weak, nonatomic) IBOutlet UILabel *username;
//    @property (weak, nonatomic) IBOutlet UILabel *rating;
//    @property (weak, nonatomic) IBOutlet UILabel *reviewText;
    
    if (indexPath.section == 0){ // carousel
        TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        titleTableViewCell.title.text = @"Placeholder";
        return titleTableViewCell;
    } else if (indexPath.section == 1){ // info
        InfoTableViewCell *infoTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
        infoTableViewCell.title.text = _location.title;
        infoTableViewCell.address.text = _location.address;
        infoTableViewCell.synopsis.text = _location.description;
        return infoTableViewCell;
    } else if (indexPath.section == 2){ //title of reviews
        TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        titleTableViewCell.title.text = @"Reviews";
        return titleTableViewCell;
    } else if (indexPath.section == 3){ // review 1
        ReviewsTableViewCell *reviewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
        reviewTableViewCell.userImage.image = [UIImage imageNamed:@"cat.jpg"];
        reviewTableViewCell.username.text = @"Cat";
        reviewTableViewCell.rating.text = @"1 star";
        reviewTableViewCell.reviewText.text = @"Cats were not allowed in";
        return reviewTableViewCell;
    } else if (indexPath.section == 4){ // review 2
        ReviewsTableViewCell *reviewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
        reviewTableViewCell.userImage.image = [UIImage imageNamed:@"dog.jpg"];
        reviewTableViewCell.username.text = @"Dog1";
        reviewTableViewCell.rating.text = @"5 star";
        reviewTableViewCell.reviewText.text = @"So much love for dogs!";
        return reviewTableViewCell;
    } else if (indexPath.section == 5){ // review 3
        ReviewsTableViewCell *reviewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
        reviewTableViewCell.userImage.image = [UIImage imageNamed:@"dog.jpg"];
        reviewTableViewCell.username.text = @"Dog2";
        reviewTableViewCell.rating.text = @"4 stars";
        reviewTableViewCell.reviewText.text = @"Nice art, and no cats!";
        return reviewTableViewCell;
    } else if (indexPath.section == 6){ // title of photos
        TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        titleTableViewCell.title.text = @"Photos";
        return titleTableViewCell;
    } else if (indexPath.section == 7){ // collection view
        TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        titleTableViewCell.title.text = @"Placeholder";
        return titleTableViewCell;
    } else {
        TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        titleTableViewCell.title.text = @"Placeholder";
        return titleTableViewCell;
    }

//    switch(indexPath.row){
//        case CAROUSEL:
//        case INFO:
//            InfoTableViewCell *infoTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
//            infoTableViewCell.title.text = _location.title;
//            infoTableViewCell.address.text = _location.address;
//            infoTableViewCell.synopsis.text = _location.description;
//            return infoTableViewCell;
//        case TITLE_INFO:
//        case REVIEW_1:
//        case REVIEW_2:
//        case REVIEW_3:
//        case TITLE_PHOTOS:
//        case IMAGE_COLLECTION:
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
>>>>>>> 1e11d6b418ccb4b14c2735cb3624ad38db4a110a
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
}

@end
