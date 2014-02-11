//
//  File.h
//  PydioSDK
//
//  Created by ME on 02/02/14.
//  Copyright (c) 2014 MINI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject
@property (nonatomic,weak) Node* parent;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,assign) BOOL isLeaf;
@property (nonatomic,strong) NSString* path;
@property (nonatomic,assign) NSInteger size;
@property (nonatomic,strong) NSDate* mTime;
@property (nonatomic,strong) NSArray *children;

-(BOOL)isTreeEqual:(Node*)node;
-(BOOL)isValuesEqual:(Node*)other;
@end