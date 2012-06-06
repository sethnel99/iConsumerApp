//
//  TruckSingleton.h
//  NomadClient
//
//  Created by Farley User on 2/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TruckSingleton : NSObject
    @property (nonatomic, strong) NSMutableArray *trucks;
    @property (nonatomic, assign) int loadType;
    @property (nonatomic, assign) int indexTarget;

+ (NSMutableArray *)getTrucks;
+ (void)setTrucks:(NSMutableArray *)newTrucks;
+ (void) setLoadType:(int)newLoadType;
+ (void) setIndexTarget:(int)newIndexTarget;
+ (void)loadTrucksFromParse;
+ (void)loadTruckLists;
+ (void) parseMessages:(id)messages;
+ (void) parseMenuItems:(id)menuItems;
+ (void) parseScheduleEntries:(id)scheduleEntries;
+ (UIColor *)getTealGreenTint;
+ (CAGradientLayer *)getCellGradientWithFrame:(CGRect)frame;

@end
