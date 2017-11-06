//
//  ThumbnailCollectionViewCell.m
//  CoreDataDemo
//
//  Created by Pradeep on 11/7/17.
//  Copyright © 2017 PT. All rights reserved.
//

#import "ThumbnailCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ThumbnailCollectionViewCell

-(void) configureCell:(NSDictionary *) dict {
    
    [self.imgViewArtWork sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"artWorkURL"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

@end
