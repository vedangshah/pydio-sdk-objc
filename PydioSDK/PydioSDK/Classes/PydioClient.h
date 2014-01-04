//
//  PydioClient.h
//  PydioSDK
//
//  Created by ME on 04/01/14.
//  Copyright (c) 2014 MINI. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ServerConfig;

@interface PydioClient : NSObject
@property (readonly,nonatomic,strong) ServerConfig* serverConfig;
@property (readonly,nonatomic,assign) BOOL loggedToServer;
@property (readonly,nonatomic,assign) BOOL inProgress;

+(instancetype)pydioClientWithServerConfig:(ServerConfig *)config;
-(instancetype)initWithServerConfig:(ServerConfig *)config;
-(void)login;
@end
