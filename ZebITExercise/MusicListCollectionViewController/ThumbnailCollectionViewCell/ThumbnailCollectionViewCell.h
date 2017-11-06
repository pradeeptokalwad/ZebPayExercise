//
//  ThumbnailCollectionViewCell.h
//  CoreDataDemo
//
//  Created by Pradeep on 11/7/17.
//  Copyright © 2017 PT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThumbnailCollectionViewCell : UICollectionViewCell
@property(weak,nonatomic) IBOutlet UIImageView *imgViewArtWork;
-(void) configureCell:(NSDictionary *) dict;

@end
