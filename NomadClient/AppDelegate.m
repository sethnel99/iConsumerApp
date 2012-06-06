//
//  AppDelegate.m
//  NomadClient
//
//  Created by Farley User on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "FoodTruck.h"
#import <CoreLocation/CLLocation.h>
#import "TruckSingleton.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:.35 green:.35 blue:.35 alpha:1]];
    
    [[UINavigationBar appearance] setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"titlelogo.png"]]];
    //[[[UINavigationBar appearance] topItem] setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nomadlogo.png"]]];

    //[[[UINavigationBar appearance] navigationItem] setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nomadlogo.png"]]];
    
    /*
    CLLocationCoordinate2D coord;
    coord.latitude = 45;
    coord.longitude = 45;
    
    NSMutableArray *trucks = [TruckSingleton getTrucks];
    //initialize with a fake truck
    FoodTruck *testTruck = [[FoodTruck alloc]initWithParseID:@"AAA"
                                                    withName:@"5411 Empanadas"
                                          withLocationString:@"Chicago"
                                              withDescriptor:@"Empanadas"
                                                withLocation:coord
                                            withSearchString:@"5411 empanadas"
                                            withFirstMessage:@"We're here!"
                                                    withLogo:[UIImage imageNamed:@"Chile.gif"]
                                          withMenuCategories:[[NSMutableArray alloc] initWithObjects:@"Appetizers",@"Main Dishes",@"Deserts", nil]
                                         withLocInTruckArray:0];
    [trucks addObject:testTruck];
    
    coord.latitude = 45.1;
    //initialize with a fake truck
    testTruck = [[FoodTruck alloc]initWithParseID:@"AAA"
                                         withName:@"Flirty Cupcakes"
                               withLocationString:@"Chicago"
                                   withDescriptor:@"Cupcakes"
                                     withLocation:coord
                                 withSearchString:@"Flirty Cupcakes"
                                 withFirstMessage:@"We're here!"
                                         withLogo:[UIImage imageNamed:@"Chile.gif"]
                               withMenuCategories:[[NSMutableArray alloc] initWithObjects:@"Appetizers",@"Main Dishes",@"Deserts", nil]
                              withLocInTruckArray:1];
    [trucks addObject:testTruck];
    coord.latitude = 45.3;
    //initialize with a fake truck
    testTruck = [[FoodTruck alloc]initWithParseID:@"AAA"
                                         withName:@"Duck n Roll"
                               withLocationString:@"Chicago"
                                   withDescriptor:@"Vietnamese Sandwiches"
                                     withLocation:coord
                                 withSearchString:@"Duck n Roll"
                                 withFirstMessage:@"The Cluck Has Landed at Union Station! I want this line to be long so I can test sizing!"
                                         withLogo:[UIImage imageNamed:@"ducknroll.png"]
                               withMenuCategories:[[NSMutableArray alloc] initWithObjects:@"Appetizers",@"Main Dishes",@"Deserts", nil]
                              withLocInTruckArray:2];
    [trucks addObject:testTruck];
    coord.latitude = 45.2;
    //initialize with a fake truck
    testTruck = [[FoodTruck alloc]initWithParseID:@"AAA"
                                         withName:@"Hummingbird Kitchen"
                               withLocationString:@"Evanston"
                                   withDescriptor:@"Penne Bowls"
                                     withLocation:coord
                                 withSearchString:@"Hummingbird Kitchen"
                                 withFirstMessage:@"We're here!"
                                         withLogo:[UIImage imageNamed:@"Chile.gif"]
                               withMenuCategories:[[NSMutableArray alloc] initWithObjects:@"Appetizers",@"Main Dishes",@"Deserts", nil]
                              withLocInTruckArray:3];
    [trucks addObject:testTruck];
    
    
    trucks = [NSMutableArray arrayWithArray:[trucks sortedArrayUsingComparator:^(id a, id b){
        NSNumber *td = ((FoodTruck *)a).dist;
        NSNumber *td2 = ((FoodTruck *)b).dist;
        return [td compare:td2];
    }]];
    
    int i = 0;
    //re-order truck's locInTruckArray
    for(FoodTruck *aTruck in trucks){
        aTruck.locInTruckArray = i;
        i++;
    }
    
    [TruckSingleton setTrucks:trucks];
    */
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
