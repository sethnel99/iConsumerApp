//
//  TruckPageViewController.h
//  NomadClient
//
//  Created by Farley User on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foodtruck.h"

@interface TruckPageViewController : UITableViewController

@property (nonatomic, strong) FoodTruck *foodTruck;
@property (nonatomic, assign) int truckIndex;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *truckLogoView;
@property (weak, nonatomic) IBOutlet UILabel *descriptLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *messageCell;


@end
