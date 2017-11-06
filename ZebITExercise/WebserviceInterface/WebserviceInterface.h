//
//  WebserviceInterface.h
//  CoreDataDemo
//
//  Created by Pradeep on 11/7/17.
//  Copyright © 2017 PT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebserviceInterface : NSObject

+(instancetype) sharedInstance;
typedef void (^Completion_Block)(id response, NSString *strError);

-(void) fetchDataWithURLCompletionBlock:(Completion_Block)block;

@end
