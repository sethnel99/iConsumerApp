//
//  MessageEntry.h
//  NomadClient
//
//  Created by Farley User on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageEntry : NSObject

@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *timeCreated;

- (MessageEntry *) initWithMessage:(NSString *)m
                          withTime:(NSDate *)d;

@end
