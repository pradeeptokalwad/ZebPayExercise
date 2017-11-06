//
//  PTCoreDataManager.m
//  ZebITExercise
//
//  Created by Pradeep on 11/6/17.
//  Copyright © 2017 PT. All rights reserved.
//

#import "PTCoreDataManager.h"
#import "Music+CoreDataClass.h"

@implementation PTCoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (instancetype)sharedManager {
    
    static PTCoreDataManager *sharedManager = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        sharedManager = [[PTCoreDataManager alloc] init];
    });
    
    return sharedManager;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ZebITExercise" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ZebITExercise.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}
- (NSManagedObjectContext *)managedObjectContext {

    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

-(BOOL) saveMusicAssets:(NSArray *)aryObj {
    
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSPersistentStoreCoordinator *storeCoordinator = moc.persistentStoreCoordinator;
    NSManagedObjectContext *tempMoc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    tempMoc.persistentStoreCoordinator = storeCoordinator;
    
    [tempMoc performBlock:^{
        for (NSDictionary *dict in aryObj) {
            
            Music *assets = [NSEntityDescription insertNewObjectForEntityForName:@"Music" inManagedObjectContext:tempMoc];
            assets.generName = [[[dict valueForKey:@"genres"] firstObject] valueForKey:@"name"];
            assets.artistName = [dict valueForKey:@"artistName"];
            assets.artWorkURL = [dict valueForKey:@"artworkUrl100"];
            NSError *error = nil;
            if ([tempMoc hasChanges] && [tempMoc save:&error]) {
                NSLog(@"Save");

            }else{
                NSLog(@"Error %@",error.description);
            }
            
            
        }
    }];
    return YES;
}


-(NSArray *) fetchMusic{
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [Music fetchRequest];;
    NSEntityDescription *entityForFailedBankInfo = [NSEntityDescription entityForName:@"Music" inManagedObjectContext:managedObjectContext];
    if(entityForFailedBankInfo)
        [fetchRequest setEntity:entityForFailedBankInfo];
    [fetchRequest setResultType:NSDictionaryResultType];
    
    NSError *error;
    NSMutableArray *aryAllAssetsMonthAndYear = [[managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    if(aryAllAssetsMonthAndYear)
        return aryAllAssetsMonthAndYear;
    
    return nil;
    
}

@end
