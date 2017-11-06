//
//  PTCoreDataManager.h
//  CoreDataDemo
//
//  Created by Pradeep on 11/6/17.
//  Copyright © 2017 PT. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface PTCoreDataManager: NSObject
+ (instancetype)sharedManager;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(BOOL) saveMusicAssets:(NSArray *)aryObj;
-(NSArray *) fetchMusic;


@end
