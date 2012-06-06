//
//  FoodTruck.m
//  NomadClient
//
//  Created by Farley User on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FoodTruck.h"

@implementation FoodTruck

@synthesize parseID;
@synthesize name;
@synthesize locationString;
@synthesize descriptor;
@synthesize searchString;
@synthesize menu;
@synthesize messages;
@synthesize schedule;
@synthesize logo;
@synthesize loadingMessages;
@synthesize loadingMenu;
@synthesize loadingSchedule;
@synthesize menuCategories;
@synthesize hasLoaded;
@synthesize locInTruckArray;
@synthesize dist;

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;


- (FoodTruck *)initWithParseID:(NSString *)pID
                      withName:(NSString *)n
            withLocationString:(NSString *)locString
                withDescriptor:(NSString *)d
                  withLocation:(CLLocationCoordinate2D)loc
              withSearchString:s
              withFirstMessage:(MessageEntry *)fMessage
                      withLogo:(UIImage *)pic
            withMenuCategories:(NSArray *)mc
           withLocInTruckArray:(int)index{
    
    if(self = [super init]){
        self.parseID = pID;
        self. name = n;
        self.title = n;
        self.locationString = locString;
        self.descriptor = d;
        self.subtitle = n;
        self.coordinate = loc;
        self.searchString = s;
        
        self.logo = pic;
        self.loadingMessages = NO;
        self.loadingMenu = NO;
        self.loadingSchedule = NO;
        
        self.menuCategories = mc;
        self.hasLoaded = NO;
        
        self.menu =[[NSMutableArray alloc]init];
      
        self.messages =[[NSMutableArray alloc]init];
        self.schedule =[[NSMutableArray alloc]init];
        for(int i = 0; i < 7; i++){
            [self.schedule addObject:[[NSMutableArray alloc] init]];
        }
        
        [self.messages addObject:fMessage];
        
      
        
        self.locInTruckArray = index;
        
        self.dist = [FoodTruck randomDistance];
        
    }
    
    return self;
    
    
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
   coordinate = newCoordinate;
}

+ (NSNumber *)randomDistance{
    return [NSNumber numberWithDouble:((double)(arc4random()%20))/10];
}

- (void)waitForNo:(id)waitingOn{
    NSString *t = (NSString *)waitingOn;
    if([t isEqualToString:@"Messages"]){
        while(loadingMessages == YES){
            [NSThread sleepForTimeInterval:1];
        }
    }else  if([t isEqualToString:@"Schedule"]){
        while(loadingSchedule == YES){
            [NSThread sleepForTimeInterval:1];
        }
    }
    
}

@end
