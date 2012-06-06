//
//  ScheduleEntry.h
//  NomadClient
//
//  Created by Farley User on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleEntry : NSObject

@property (nonatomic,strong) NSString *ParseID;
@property (nonatomic,assign)int dayOfWeek;
@property (nonatomic, strong) NSString *timeString;
@property(nonatomic,assign)int time;
@property(nonatomic,strong)NSString *locationString;

- (ScheduleEntry *)initWithID:(NSString *)id
                    withDayOfWeek:(int)dow
                    withTime:(int)t
                    withLocation:(NSString *)l;

+ (NSString *)getTimeString:(int)i;

@end
