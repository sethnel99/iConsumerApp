//
//  TruckPageViewController.m
//  NomadClient
//
//  Created by Farley User on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TruckPageViewController.h"
#import "TruckMapViewController.h"
#import "TruckSingleton.h"
#import "ScheduleViewController.h"
#import "MessagesViewController.h"
#import "MenuViewController.h"

@interface TruckPageViewController ()

@end

@implementation TruckPageViewController

@synthesize foodTruck;
@synthesize truckIndex;
@synthesize nameLabel;
@synthesize truckLogoView;
@synthesize descriptLabel;
@synthesize messageCell;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"TruckPageToMapSegue"]){
        TruckMapViewController *tmvc = (TruckMapViewController *)[segue destinationViewController];
       tmvc.fromString = @"TruckPage";
    }else if ([[segue identifier] isEqualToString:@"TruckPageToMessagesSegue"]) {
        MessagesViewController *mvc = (MessagesViewController *)[segue destinationViewController];
        mvc.truck = self.foodTruck;
    }else if ([[segue identifier] isEqualToString:@"TruckPageToScheduleSegue"]){
        ScheduleViewController *svc = (ScheduleViewController *)[segue destinationViewController];
        svc.truck = self.foodTruck;
    }else if ([[segue identifier] isEqualToString:@"TruckPageToMenuSegue"]){
        MenuViewController *svc = (MenuViewController *)[segue destinationViewController];
        svc.truck = self.foodTruck;
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
    
   // self.navigationController.navigationBar
    if(foodTruck.hasLoaded == NO){
        [TruckSingleton setIndexTarget:foodTruck.locInTruckArray];
        [TruckSingleton loadTruckLists];
    }
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundtile.png"]];
    
    [self.nameLabel setText:self.foodTruck.name];
    [self.truckLogoView setImage:self.foodTruck.logo];
    [self.descriptLabel setText:self.foodTruck.descriptor];
    
    [self.descriptLabel sizeToFit];
    self.descriptLabel.frame = CGRectMake(self.descriptLabel.superview.frame.origin.x + self.descriptLabel.superview.frame.size.width/2 - self.descriptLabel.frame.size.width/2, self.descriptLabel.frame.origin.y,self.descriptLabel.frame.size.width, self.descriptLabel.frame.size.height);
    

    
    UILabel* lMessageLabel = (UILabel*)[self.messageCell viewWithTag:101];
    lMessageLabel.text = [[self.foodTruck.messages objectAtIndex:0] message];
    [lMessageLabel sizeToFit];
    lMessageLabel.frame = CGRectMake(lMessageLabel.superview.frame.origin.x + lMessageLabel.superview.frame.size.width/2 - lMessageLabel.frame.size.width/2, lMessageLabel.frame.origin.y,lMessageLabel.frame.size.width, lMessageLabel.frame.size.height);
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    
    [self setNameLabel:nil];
    [self setTruckLogoView:nil];
    [self setDescriptLabel:nil];
    [self setMessageCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 1)
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    NSString *cellText    = [[foodTruck.messages objectAtIndex:0] message];
    UIFont *cellFont      = [UIFont fontWithName:@"Helvetica" size:12.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize      = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    int buffer  = 30;
    return labelSize.height + buffer;
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
