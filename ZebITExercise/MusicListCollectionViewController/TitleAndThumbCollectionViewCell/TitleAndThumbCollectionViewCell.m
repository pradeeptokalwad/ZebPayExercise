//
//  TitleAndThumbCollectionViewCell.m
//  CoreDataDemo
//
//  Created by Pradeep on 11/6/17.
//  Copyright © 2017 PT. All rights reserved.
//

#import "TitleAndThumbCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation TitleAndThumbCollectionViewCell

-(void) configureCell:(NSDictionary *) dict {

    [self.imgViewArtWork sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"artWorkURL"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.lblGenerName.text = [dict valueForKey:@"artistName"];
    self.lblArtistName.text = [dict valueForKey:@"generName"];

}
@end
