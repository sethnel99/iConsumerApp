//
//  MenuViewController.h
//  NomadClient
//
//  Created by Farley User on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodTruck.h"
#import "MBProgressHUD.h"

@interface MenuViewController : UITableViewController<MBProgressHUDDelegate>
@property (nonatomic, strong) FoodTruck *truck;
/** 
 * Called after the HUD was fully hidden from the screen. 
 */
- (void)hudWasHidden:(MBProgressHUD *)hud;

@end
