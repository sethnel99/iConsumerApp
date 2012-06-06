//
//  MessageEntry.m
//  NomadClient
//
//  Created by Farley User on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MessageEntry.h"

@implementation MessageEntry

@synthesize message;
@synthesize timeCreated;

- (MessageEntry *) initWithMessage:(NSString *)m
                    withTime:(NSDate *)d{
    if(self = [super init]){
    self.message = m;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:d];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    NSString *ampm = @"am";
    if(hour == 0)
        hour = 12;
    
    if(hour > 12){
        hour -= 12;
        ampm = @"pm";
    }
    
    self.timeCreated = [NSString stringWithFormat:[@"%02d/%02d/%02d %02d:%02d" stringByAppendingString:ampm],([components month]),([components day]),([components year]),hour,minute];
    }
    return self;
}


@end
