//
//  ZebITExerciseTests.m
//  ZebITExerciseTests
//
//  Created by Pradeep on 11/7/17.
//  Copyright © 2017 PT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PTCoreDataManager.h"
#import "MusicListCollectionViewController.h"
#import "TitleAndThumbCollectionViewCell.h"
#import "ListCollectionViewCell.h"
#import "ThumbnailCollectionViewCell.h"
#import "WebserviceInterface.h"

@interface ZebITExerciseTests : XCTestCase

@property (nonatomic) MusicListCollectionViewController *musicListCollectionViewController;

@end

@implementation ZebITExerciseTests

- (void)setUp {
    [super setUp];
    UIStoryboard *sorty = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.musicListCollectionViewController = [sorty instantiateViewControllerWithIdentifier:@"MusicListCollectionViewController"];
}

- (void)tearDown {
    [super tearDown];
}


-(void) testListButtonTapped {
    [self.musicListCollectionViewController btnListTapped:nil];
}
-(void) testWebservicecall {
    
    [[WebserviceInterface sharedInstance] fetchDataWithURLCompletionBlock:^(id response, NSString *strError) {
        NSLog(@"testWebservicecall");
    }];
}

-(void) testSaveMusicAssets {
    [[PTCoreDataManager sharedManager] saveMusicAssets:@[]];
}

-(void) testFetchMusic {
    [[PTCoreDataManager sharedManager] fetchMusic];
}

@end
