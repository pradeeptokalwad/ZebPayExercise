//
//  WebserviceInterface.m
//  CoreDataDemo
//
//  Created by Pradeep on 11/7/17.
//  Copyright © 2017 PT. All rights reserved.
//

#import "WebserviceInterface.h"
#import "PTCoreDataManager.h"
#import "MBProgressHUD.h"

@implementation WebserviceInterface

+ (instancetype)sharedInstance {
    
    static WebserviceInterface *sharedInstance = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        sharedInstance = [[WebserviceInterface alloc] init];
    });
    
    return sharedInstance;
}

-(void) fetchDataWithURLCompletionBlock:(Completion_Block)block {

    [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication]delegate] window]animated:YES];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://rss.itunes.apple.com/api/v1/us/apple-music/top-songs/all/100/non-explicit.json"]];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication]delegate] window] animated:YES];
        });
        
        if([data isKindOfClass:[NSData class]])
        {
            id responseDict=[self parseJsonObject:data];
            if ([responseDict isKindOfClass:[NSDictionary class]] || [responseDict isKindOfClass:[NSArray class]])
            {
                NSLog(@"response received");
                dispatch_async(dispatch_get_main_queue(), ^{
                    if([[PTCoreDataManager sharedManager] saveMusicAssets:[[responseDict valueForKey:@"feed"] valueForKey:@"results"]]) {
                        block([[responseDict valueForKey:@"feed"] valueForKey:@"results"],nil);
                    }
                });
                
            }else {
                block(nil,@"Error in loading data");
            }
        }else {
                block(nil,@"Error in loading data");
        }
    }];
    
    [sessionDataTask resume];
}

-(id)parseJsonObject:(id)data {
    if([data isKindOfClass:[NSData class]])
    {
        NSError *parseJsonError;
        id serviceResponse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseJsonError];
        if(!parseJsonError)
        {
            return serviceResponse;
        }
        return parseJsonError;
    }
    return nil;
}



@end
