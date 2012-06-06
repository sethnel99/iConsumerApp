//
//  FoodTruck.h
//  NomadClient
//
//  Created by Farley User on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapkit/MKMapView.h>
#import <CoreLocation/CLLocation.h>
#import "MessageEntry.h"

@interface FoodTruck : NSObject <MKAnnotation>


@property (nonatomic, strong) NSString *parseID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *locationString;
@property (nonatomic, strong) NSString *descriptor;
@property (nonatomic, strong) NSString *searchString;
@property (nonatomic, strong) NSMutableArray *menu;
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) NSMutableArray *schedule;
@property (nonatomic, strong) UIImage *logo;
@property (nonatomic, assign) BOOL loadingMessages;
@property (nonatomic, assign) BOOL loadingMenu;
@property (nonatomic, assign) BOOL loadingSchedule;
@property (nonatomic, strong) NSArray *menuCategories;
@property (nonatomic, assign) BOOL hasLoaded;
@property (nonatomic, assign) int locInTruckArray;
@property (nonatomic, strong) NSNumber *dist;


//MKAnnotation properties
@property(nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;


- (FoodTruck *)initWithParseID:(NSString *)pID
                      withName:(NSString *)n
            withLocationString:(NSString *)locString
                withDescriptor:(NSString *)d
                  withLocation:(CLLocationCoordinate2D)loc
              withSearchString:s
              withFirstMessage:(MessageEntry*)fMessage
                      withLogo:(UIImage *)pic
            withMenuCategories:(NSArray *)m
           withLocInTruckArray:(int)index;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

+ (NSNumber *)randomDistance;
- (void)waitForNo:(id)waitingOn;

@end
