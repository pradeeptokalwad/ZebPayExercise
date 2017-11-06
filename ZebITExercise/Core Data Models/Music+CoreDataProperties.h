//
//  Music+CoreDataProperties.h
//  ZebITExercise
//
//  Created by webwerks on 11/7/17.
//  Copyright © 2017 PT. All rights reserved.
//
//

#import "Music+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Music (CoreDataProperties)

+ (NSFetchRequest<Music *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *artistName;
@property (nullable, nonatomic, copy) NSString *artWorkURL;
@property (nullable, nonatomic, copy) NSString *generName;

@end

NS_ASSUME_NONNULL_END
