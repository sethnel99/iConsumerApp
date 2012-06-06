//
//  TruckListViewController.h
//  NomadClient
//
//  Created by Farley User on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

 
@interface TruckListViewController : UITableViewController <MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchController;


/** 
 * Called after the HUD was fully hidden from the screen. 
 */
- (void)hudWasHidden:(MBProgressHUD *)hud;
   
@end
