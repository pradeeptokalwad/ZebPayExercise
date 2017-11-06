//
//  Music+CoreDataProperties.m
//  ZebITExercise
//
//  Created by webwerks on 11/7/17.
//  Copyright © 2017 PT. All rights reserved.
//
//

#import "Music+CoreDataProperties.h"

@implementation Music (CoreDataProperties)

+ (NSFetchRequest<Music *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Music"];
}

@dynamic artistName;
@dynamic artWorkURL;
@dynamic generName;

@end
