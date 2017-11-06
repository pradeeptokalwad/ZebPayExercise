//
//  ListCollectionViewCell.h
//  CoreDataDemo
//
//  Created by Pradeep on 11/7/17.
//  Copyright © 2017 PT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCollectionViewCell : UICollectionViewCell
@property(weak,nonatomic) IBOutlet UIImageView *imgViewArtWork;
@property(weak,nonatomic) IBOutlet UILabel *lblArtistName;
@property(weak,nonatomic) IBOutlet UILabel *lblGenerName;

-(void) configureCell:(NSDictionary *) dict;
@end
