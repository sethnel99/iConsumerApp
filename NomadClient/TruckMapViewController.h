//
//  TruckMapViewController.h
//  NomadClient
//
//  Created by Farley User on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TruckMapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *MapView;
@property (strong, nonatomic) NSString *fromString;
@property (strong, nonatomic) NSMutableArray *trucks;

@end
