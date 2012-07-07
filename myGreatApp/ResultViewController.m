//
//  ResultViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultViewController.h"
#import "DetailViewController.h"
#import "MapResultViewController.h"
#import "ResultItemCell.h"
#import "Localisation.h"
#import "AppDelegate.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

@synthesize searchPlace, results;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    results = [NSMutableArray arrayWithCapacity:20];
    
    [ApplicationDelegate.localisationEngine placeToSeach:searchPlace
                                            onCompletion:^(NSMutableArray* localisations) {
                                                for (NSDictionary* jsonObject in localisations) {
                                                    Localisation* loc = [[Localisation alloc] initWithDictionary:jsonObject];
                                                    [results addObject:loc];
                                                }
                                                [self.tableView reloadData];        
                                            }
                                                 onError:^(NSError* error) {
        
                                            }];

    self.navigationItem.title = searchPlace;
}

- (void)viewDidUnload
{
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultItemCell* cell = (ResultItemCell *)[tableView dequeueReusableCellWithIdentifier:@"placeItem"];
    Localisation* loc = [results objectAtIndex:indexPath.row];
	cell.nameLabel.text = loc.name;
	cell.cityLabel.text = loc.city;
    cell.locId = loc.id;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        NSIndexPath* selectedIndex = [self.tableView indexPathForSelectedRow];
        ResultItemCell* cell = (ResultItemCell*)[self tableView:self.tableView cellForRowAtIndexPath:selectedIndex];
        
        DetailViewController *ds = [segue destinationViewController];
        [ds setLocId:cell.locId];
    }
    else if ([[segue identifier] isEqualToString:@"mapResultSegue"]) {
        MapResultViewController *mvs = [segue destinationViewController];
        [mvs setSearchPlace:searchPlace];
        [mvs setResults:results];
    }
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
