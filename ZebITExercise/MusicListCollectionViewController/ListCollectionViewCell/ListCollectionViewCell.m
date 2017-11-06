//
//  ListCollectionViewCell.m
//  CoreDataDemo
//
//  Created by Pradeep on 11/7/17.
//  Copyright © 2017 PT. All rights reserved.
//

#import "ListCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ListCollectionViewCell
-(void) configureCell:(NSDictionary *) dict {
    
    [self.imgViewArtWork sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"artWorkURL"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.lblGenerName.text = [dict valueForKey:@"artistName"];
    self.lblArtistName.text = [dict valueForKey:@"generName"];
    
}
@end
