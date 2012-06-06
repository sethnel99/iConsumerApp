//
//  TruckMapViewController.m
//  NomadClient
//
//  Created by Farley User on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TruckMapViewController.h"
#import "FoodTruck.h"
#import "TruckSingleton.h"
#import "TruckPageViewController.h"

@interface TruckMapViewController ()

@end

@implementation TruckMapViewController
@synthesize MapView;
@synthesize fromString;
@synthesize trucks;
FoodTruck *truckPass;


#pragma mark MKMapViewDelegate methods

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    truckPass = view.annotation;
    [self performSegueWithIdentifier:@"MapToPageSegue" sender:mapView];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    TruckPageViewController *tpvc = (TruckPageViewController *)[segue destinationViewController];
    tpvc.foodTruck = truckPass;
}

//this is the required method implementation for MKMapView annotations
- (MKAnnotationView *) mapView:(MKMapView *)thisMapView 
             viewForAnnotation:(FoodTruck *)annotation
{
    
	
	
	static NSString *identifier = @"FoodTruckIdentifier";
    
    //the result of the call is being cast (MKPinAnnotationView *) to the correct
    //view class or else the compiler complains
    MKAnnotationView *annotationView = (MKAnnotationView *)[thisMapView 
                                                                  dequeueReusableAnnotationViewWithIdentifier:identifier];
	if(annotationView == nil)
	{
		annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
	}
	
   // annotationView.pinColor = MKPinAnnotationColorGreen;
    
    //pin drops when it first appears
   // annotationView.animatesDrop=TRUE;
    
    //tapping the pin produces a gray box which shows title and subtitle  
    annotationView.canShowCallout = YES;
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = infoButton;
    annotationView.image = [UIImage imageNamed:@"truckpin.png"];
    
    return annotationView;
}



- (IBAction)ListButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{


    if([fromString isEqualToString:@"FromList"])
        self.navigationItem.hidesBackButton = TRUE;
    else { 
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    
    self.trucks = [TruckSingleton getTrucks];
    //set up map
    
    float minLat = FLT_MAX;
    float minLong =FLT_MAX;
    float maxLat = -1 * FLT_MAX;
    float maxLong = -1 * FLT_MAX;
    
	
    
    for(FoodTruck *t in self.trucks){
        if(t.coordinate.latitude != NSIntegerMax){
            [MapView addAnnotation:t];
            
            if(t.coordinate.latitude < minLat)
                minLat = t.coordinate.latitude;
            if(t.coordinate.latitude > maxLat)
                maxLat = t.coordinate.latitude;
            if(t.coordinate.longitude < minLong)
                minLong = t.coordinate.longitude;
            if(t.coordinate.longitude > maxLong)
                maxLong = t.coordinate.longitude;
            
        }
	}
    
    CLLocationCoordinate2D center;
    center.latitude = (minLat + maxLat)/2;
    center.longitude = (minLong + maxLong)/2;
    MKCoordinateSpan span;
    span.latitudeDelta = (maxLat - minLat);
    span.longitudeDelta = (maxLong - minLong);
    MKCoordinateRegion region;
	region.center = center;
	region.span = span;
    MapView.region = [MapView regionThatFits:region];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
