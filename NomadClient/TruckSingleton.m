//
//  TruckSingleton.m
//  NomadClient
//
//  Created by Farley User on 2/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TruckSingleton.h"
#import "Parse/Parse.h"
#import <CoreLocation/CLLocation.h>
#import "MessageEntry.h"
#import "MenuFoodItem.h"
#import "ScheduleEntry.h"
#import "FoodTruck.h"

@implementation TruckSingleton
@synthesize trucks;
@synthesize loadType;
@synthesize indexTarget;
static TruckSingleton *_sharedInstance;

- (id) init
{
	if (self = [super init])
	{
		self.trucks = [[NSMutableArray alloc] init];
	}
	return self;
}

+ (NSMutableArray *)getTrucks{
    if (!_sharedInstance)
	{
		_sharedInstance = [[TruckSingleton alloc] init];
	}
    
	return _sharedInstance.trucks;
}

+ (void)setTrucks:(NSMutableArray *)newTrucks{
    if (!_sharedInstance)
	{
		_sharedInstance = [[TruckSingleton alloc] init];
	}
    _sharedInstance.trucks = newTrucks;
}

+ (void) setLoadType:(int)newLoadType{
    _sharedInstance.loadType = newLoadType;
}

+ (void) setIndexTarget:(int)newIndexTarget{
    _sharedInstance.indexTarget = newIndexTarget;
}

+ (void)loadTrucksFromParse{
    if (!_sharedInstance)
	{
		_sharedInstance = [[TruckSingleton alloc] init];
	}
    
    _sharedInstance.trucks = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Trucks"];
    PFCachePolicy cachePolicy;
    if(_sharedInstance.loadType == 0)
        cachePolicy = kPFCachePolicyNetworkElseCache;
    else {
        cachePolicy = kPFCachePolicyCacheElseNetwork;
    }
    query.cachePolicy = cachePolicy;
    
    NSArray* parseData = [query findObjects];
    for(PFObject *temp in parseData){
        
        
        NSString *parseID = temp.objectId;
        NSString *name = [temp objectForKey:@"Name"];
     
        
        NSString *descriptor = [temp objectForKey:@"Description"];
        NSString *locationString = [temp objectForKey:@"LocationString"];
        if(locationString == nil)
            locationString = @"";
        PFGeoPoint *pgeo = [temp objectForKey:@"Location"];
        
        CLLocationCoordinate2D coord;
        if(pgeo != nil){
            coord.latitude = pgeo.latitude;
            coord.longitude = pgeo.longitude;
        }else {
            coord.latitude = NSIntegerMax;
            coord.longitude = NSIntegerMax;
        }
        
        
        PFFile *pf = [temp objectForKey:@"Logo"];
        NSData *logoFile = [pf getData];
        UIImage *logo = [UIImage imageWithData:logoFile];
        //UIImage *logo = [UIImage imageNamed:@"Chile.gif"];
        NSArray *categories = [temp objectForKey:@"MenuCategories"];
        
        PFQuery *queryFirstMessage = [PFQuery queryWithClassName:@"Messages"];
        queryFirstMessage.cachePolicy = cachePolicy;
        [queryFirstMessage whereKey:@"TruckID" equalTo:parseID];
        [queryFirstMessage orderByAscending:@"createdAt"];
        
        PFObject *firstMessage = [queryFirstMessage getFirstObject];
        
        MessageEntry *mse = [[MessageEntry alloc] initWithMessage:[firstMessage objectForKey:@"Message"]
                                                         withTime:firstMessage.createdAt];
        
        [_sharedInstance.trucks addObject:[[FoodTruck alloc] initWithParseID:parseID withName:name withLocationString:locationString withDescriptor:descriptor withLocation:coord withSearchString:name withFirstMessage:mse withLogo:logo withMenuCategories:categories withLocInTruckArray:[_sharedInstance.trucks count]]];
        
        
        
        
    }
    
    _sharedInstance.trucks = [NSMutableArray arrayWithArray:[_sharedInstance.trucks sortedArrayUsingComparator:^(id a, id b) {
        FoodTruck *first = (FoodTruck*)a;
        FoodTruck *second = (FoodTruck*)b;
        
        return [first.dist compare:second.dist];
    }]];
    
    for(int i = 0; i < [_sharedInstance.trucks count]; i++){
        [[_sharedInstance.trucks objectAtIndex:i] setLocInTruckArray:i];
    }
    
}

+(void)loadTruckLists{
    NSOperationQueue *queue = [NSOperationQueue new];
    
    
    PFCachePolicy cachePolicy;
    if(_sharedInstance.loadType == 0)
        cachePolicy = kPFCachePolicyNetworkElseCache;
    else {
        cachePolicy = kPFCachePolicyCacheElseNetwork;
    }
    
    FoodTruck *ft = [_sharedInstance.trucks objectAtIndex:_sharedInstance.indexTarget];
    ft.hasLoaded = true;
    
    PFQuery *queryMessages = [PFQuery queryWithClassName:@"Messages"];
    [queryMessages whereKey:@"TruckID" equalTo:ft.parseID];
    queryMessages.cachePolicy = cachePolicy;
    [queryMessages orderByAscending:@"createdAt"];
    [queryMessages setLimit:[NSNumber numberWithInt:10]];
    [queryMessages setSkip:[NSNumber numberWithInt:1]];
    ft.loadingMessages = true;
    
    [queryMessages findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d messages.", objects.count);
            NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:[TruckSingleton self]
                                                                                    selector:@selector(parseMessages:)
                                                                                      object:objects];
            
            
            [queue addOperation:operation];
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFQuery *queryMenuItems = [PFQuery queryWithClassName:@"MenuItems"];
    [queryMenuItems whereKey:@"TruckID" equalTo:ft.parseID];
    queryMenuItems.cachePolicy = cachePolicy;
    ft.loadingMenu = true;
    
    [queryMenuItems findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d menu items.", objects.count);
            NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:[TruckSingleton self]
                                                                                    selector:@selector(parseMenuItems:)
                                                                                      object:objects];
            
            
            [queue addOperation:operation];
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    PFQuery *queryScheduleEntries = [PFQuery queryWithClassName:@"ScheduleEntry"];
    [queryScheduleEntries whereKey:@"TruckID" equalTo:ft.parseID];
    queryScheduleEntries.cachePolicy = cachePolicy;
    ft.loadingSchedule = true;
    
    [queryScheduleEntries findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d schedule entries.", objects.count);
            NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:[TruckSingleton self]
                                                                                    selector:@selector(parseScheduleEntries:)
                                                                                      object:objects];
            
            
            [queue addOperation:operation];
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    

    
    
    
    
}

+ (void)parseMessages:(id)messages{
    NSArray *messageArray = (NSArray*)messages;
    for(PFObject *temp in messageArray){
        MessageEntry *mse = [[MessageEntry alloc] initWithMessage:[temp objectForKey:@"Message"] withTime:temp.createdAt];
        [[[_sharedInstance.trucks objectAtIndex:_sharedInstance.indexTarget] messages] addObject:mse];
    }
    
    [[_sharedInstance.trucks objectAtIndex:_sharedInstance.indexTarget] setLoadingMessages:NO];
}

+ (void)parseMenuItems:(id)menuItems{
    NSArray *menuItemsArray = (NSArray*)menuItems;
    
    for(PFObject *temp in menuItemsArray){
        NSString *ParseID = temp.objectId;
        NSString *name = [temp objectForKey:@"Name"];
        double price = [[temp objectForKey:@"Price"] doubleValue];
        int category = [[temp objectForKey:@"Category"] intValue];
        
        
        PFFile *pf = [temp objectForKey:@"ItemPic"];
        NSData *picFile = [pf getData];
        UIImage *itemPic = [UIImage imageWithData:picFile];
        
        [[[_sharedInstance.trucks objectAtIndex:_sharedInstance.indexTarget] menu]  addObject:[[MenuFoodItem alloc] initWithParseID:ParseID withName:name withPrice:price withImage:itemPic withCategory:category]];
        
        
        
    }
    
    [[_sharedInstance.trucks objectAtIndex:_sharedInstance.indexTarget] setLoadingMenu:NO];
    
}

+ (void)parseScheduleEntries:(id)scheduleEntries{
    NSArray *scheduleArray = (NSArray*)scheduleEntries;
    for(PFObject *temp in scheduleArray){
        NSString *ParseID = temp.objectId;
        NSString *location = [temp objectForKey:@"Location"];
        int dow = [[temp objectForKey:@"DayOfWeek"] intValue];
        int time = [[temp objectForKey:@"Time"] intValue];
        
        [[[[_sharedInstance.trucks objectAtIndex:_sharedInstance.indexTarget] schedule] objectAtIndex:dow] addObject:[[ScheduleEntry alloc] initWithID:ParseID withDayOfWeek:dow withTime:time withLocation:location]];
                              
    }
    
    [[_sharedInstance.trucks objectAtIndex:_sharedInstance.indexTarget] setLoadingSchedule:NO];
}

+ (UIColor *)getTealGreenTint{
    return [UIColor colorWithRed:.184 green:.565 blue:.514 alpha:1];
}


+ (CAGradientLayer *)getCellGradientWithFrame:(CGRect)frame{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = frame;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:.875 green:.875 blue:.875 alpha:1] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    
    return gradient;
}




@end
