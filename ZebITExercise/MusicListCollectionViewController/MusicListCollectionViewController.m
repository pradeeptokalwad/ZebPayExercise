//
//  MusicListCollectionViewController.m
//  ZebITExercise
//
//  Created by Pradeep on 11/7/17.
//  Copyright © 2017 PT. All rights reserved.
//

#import "MusicListCollectionViewController.h"
#import "TitleAndThumbCollectionViewCell.h"
#import "ListCollectionViewCell.h"
#import "ThumbnailCollectionViewCell.h"

#import "WebserviceInterface.h"
#import "PTCoreDataManager.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface MusicListCollectionViewController ()
{
    NSMutableArray *aryMusic;
    NSInteger typeOfCell;
    
}
@end

@implementation MusicListCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseType1Identifier = @"Type1";
static NSString * const reuseType2Identifier = @"Type2";
static NSString * const reuseType3Identifier = @"Type3";

- (void)viewDidLoad {
    [super viewDidLoad];
    typeOfCell = 1;
    
    [[WebserviceInterface sharedInstance] fetchDataWithURLCompletionBlock:^(id response, NSString *strError) {
        [self fetchAndReloadollectionView];
    }];
    
    [self btnListTapped:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(typeOfCell == 1) {
        return CGSizeMake(150, 150);
    }else if(typeOfCell == 3) {
        return CGSizeMake(SCREEN_WIDTH, 70);
    }else {
        return CGSizeMake(SCREEN_WIDTH/3, SCREEN_WIDTH/3);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return aryMusic.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(typeOfCell == 1) {
        TitleAndThumbCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseType1Identifier forIndexPath:indexPath];
        [cell configureCell:aryMusic[indexPath.row]];
        return cell;
    }else if(typeOfCell == 3) {
        ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseType2Identifier forIndexPath:indexPath];
        [cell configureCell:aryMusic[indexPath.row]];
        return cell;
    }else{
        ThumbnailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseType3Identifier forIndexPath:indexPath];
        [cell configureCell:aryMusic[indexPath.row]];
        return cell;
    }
}
-(void) fetchAndReloadollectionView {
    if(!aryMusic.count){
        aryMusic = [[NSMutableArray alloc] initWithArray:[[PTCoreDataManager sharedManager] fetchMusic]];
    }
    [self.collectionView reloadData];
}

- (IBAction)btnOriginaTapped:(id)sender {
    typeOfCell = 1;
    [self fetchAndReloadollectionView];
}
- (IBAction)btnThumbnailTapped:(id)sender {
    typeOfCell = 2;
    [self fetchAndReloadollectionView];
}
- (IBAction)btnListTapped:(id)sender {
    typeOfCell = 3;
    [self fetchAndReloadollectionView];
}

@end
