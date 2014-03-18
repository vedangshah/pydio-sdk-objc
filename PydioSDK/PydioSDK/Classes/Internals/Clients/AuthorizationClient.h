//
//  AuthorizationClient.h
//  PydioSDK
//
//  Created by ME on 06/01/14.
//  Copyright (c) 2014 MINI. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const PydioErrorDomain;

@class AFHTTPRequestOperationManager;

@interface AuthorizationClient : NSObject
@property (nonatomic,strong) AFHTTPRequestOperationManager *operationManager;
@property (readonly,nonatomic,assign) BOOL progress;

-(BOOL)authorizeWithSuccess:(void(^)(id ignored))success failure:(void(^)(NSError *error))failure;
-(BOOL)login:(NSString *)captcha WithSuccess:(void(^)(id ignored))success failure:(void(^)(NSError *error))failure;
-(BOOL)getCaptchaWithSuccess:(void(^)(NSData *captcha))success failure:(void(^)(NSError *error))failure;
@end