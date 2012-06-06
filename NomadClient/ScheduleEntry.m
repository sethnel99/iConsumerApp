//
//  ScheduleEntry.m
//  NomadClient
//
//  Created by Farley User on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleEntry.h"

@implementation ScheduleEntry


@synthesize ParseID;
@synthesize dayOfWeek;
@synthesize time;
@synthesize locationString;
@synthesize timeString;

- (ScheduleEntry *)initWithID:(NSString *)id
                withDayOfWeek:(int)dow
                withTime:(int)t
                withLocation:(NSString *)l{
if(self = [super init]){

    self.ParseID = id;
    self.dayOfWeek = dow;
    self.time = t;
    self.locationString = l;
    self.timeString = [ScheduleEntry getTimeString:time];
}
return self;

}

+ (NSString *)getTimeString:(int)i{
    NSString* timeString = [[NSString alloc] init];
    
    timeString = [timeString stringByAppendingFormat:@"%02d",(int)i/60];
    timeString = [timeString stringByAppendingString:@":"];
    timeString = [timeString stringByAppendingFormat:@"%02d",i%60];
    if(i < 720)
        timeString = [timeString stringByAppendingString:@"am"];
    else {
       timeString =  [timeString stringByAppendingString:@"pm"];
    }

    return timeString;
   // return @"12:00 pm";
}

@end
