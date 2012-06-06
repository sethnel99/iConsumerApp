//
//  ScheduleViewController.h
//  NomadClient
//
//  Created by Farley User on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foodtruck.h"
#import "ScheduleEntry.h"
#import "MBProgressHUD.h"

@interface ScheduleViewController : UITableViewController<MBProgressHUDDelegate>
@property (nonatomic, strong) FoodTruck *truck;
/** 
 * Called after the HUD was fully hidden from the screen. 
 */
- (void)hudWasHidden:(MBProgressHUD *)hud;

@end
