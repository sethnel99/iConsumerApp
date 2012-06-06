//
//  TruckListViewController.m
//  NomadClient
//
//  Created by Farley User on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TruckListViewController.h"
#import "TruckSingleton.h"
#import "FoodTruck.h"
#import "TruckPageViewController.h"
#import "TruckMapViewController.h"
#import "MBProgressHUD.h"

@interface TruckListViewController ()
@property (nonatomic, strong) NSMutableArray *trucks;
@property (nonatomic, strong) NSMutableArray *filteredTrucks;
@end

@implementation TruckListViewController
@synthesize searchController;
@synthesize trucks;
@synthesize filteredTrucks;



-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0){
        self.filteredTrucks = self.trucks;
    }else{
        
        self.filteredTrucks = [[NSMutableArray alloc] init];
        for(FoodTruck *aTruck in trucks){
            if([[aTruck.name lowercaseString] rangeOfString:[text lowercaseString]].location != NSNotFound){
                [self.filteredTrucks addObject:aTruck];
            }
        }
    }
    
    
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"TruckListToPageSegue"]){
        TruckPageViewController *tpvc = (TruckPageViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = [[self tableView] indexPathForCell:sender];
        tpvc.foodTruck = [self.filteredTrucks objectAtIndex:indexPath.row];
    }else if ([[segue identifier] isEqualToString:@"ListToMapSegue"]){
        TruckMapViewController *tmvc = (TruckMapViewController *)[segue destinationViewController];
        tmvc.fromString = @"TruckList";
        
    }
}




- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.navigationController.navigationBar.topItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nomadlogo.png"]];
    [TruckSingleton setLoadType:0];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.delegate = self;
    hud.labelText = @"Loading Trucks From Parse";
    [hud showWhileExecuting:@selector(loadTrucksFromParse) onTarget:[TruckSingleton self] withObject:nil animated:YES];
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) hudWasHidden{
    self.trucks = [TruckSingleton getTrucks];
    self.filteredTrucks = [TruckSingleton getTrucks];
    [self.tableView reloadData];
}


- (void)viewDidUnload
{
    [self setSearchController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.filteredTrucks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TruckCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *distanceLabel = (UILabel *)[cell viewWithTag:100];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *locationLabel = (UILabel *)[cell viewWithTag:102];
    
    FoodTruck *tempTruck = [self.filteredTrucks objectAtIndex:indexPath.row];

    distanceLabel.text = [NSString stringWithFormat:@"%.1f",[tempTruck.dist floatValue]];
    nameLabel.text = [NSString stringWithString:tempTruck.name];
    locationLabel.text = [NSString stringWithString:tempTruck.locationString];
    
    //apply gradient 
    [cell.layer insertSublayer:[TruckSingleton getCellGradientWithFrame:cell.bounds] atIndex:0];
    
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
