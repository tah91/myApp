//
//  FavoritesViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 27/08/12.
//
//

#import "FavoritesViewController.h"
#import "AppDelegate.h"
#import "NSDate+TIAdditions.h"
#import "SHKActivityIndicator.h"
#import "Localisation.h"
#import "LocalisationCell.h"
#import "FreeLocalisationCell.h"
#import "PayingLocalisationCell.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

@synthesize favorites, tableView;

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
    [self.tableView registerNib:[UINib nibWithNibName:kFreeLocalisationCellIdent bundle:nil] forCellReuseIdentifier:kFreeLocalisationCellIdent];
    [self.tableView registerNib:[UINib nibWithNibName:kPayingLocalisationCellIdent bundle:nil] forCellReuseIdentifier:kPayingLocalisationCellIdent];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self fetchData];
    
    self.navigationItem.title = @"Favoris";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) fetchData
{
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params trySetObject:[ApplicationDelegate.loginSession authData].token forKey:@"token"];

    [[SHKActivityIndicator currentIndicator] displayActivity:@"Chargement en cours"];
    [ApplicationDelegate.localisationEngine enqueueOperationWithUrl:GET_FAV_URL
                                                             params:params
                                                         httpMethod:@"GET"
                                                       onCompletion:^(NSObject* json) {
                                                           [[SHKActivityIndicator currentIndicator] displayCompleted:@"Chargement terminé"];
                                                           NSMutableDictionary* localisationsContainer = (NSMutableDictionary*)json;
                                                           NSMutableArray* results = [localisationsContainer objectForKey:@"list"];
                                                           self.favorites = [NSMutableArray arrayWithCapacity:[results count]];
                                                           
                                                           for (NSDictionary* jsonObject in results) {
                                                               Localisation* loc = [[Localisation alloc] initWithDictionary:jsonObject];
                                                               [self.favorites addObject:loc];
                                                           }
                                                           
                                                           [self.tableView reloadData];
                                                       }
                                                            onError:^(NSError* error) {
                                                                [[SHKActivityIndicator currentIndicator] displayActivity:@"Echec lors du chargement"];
                                                                ALERT_TITLE(@"Erreur",[error localizedDescription])
                                                            }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.favorites count];
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Localisation* loc = [self.favorites objectAtIndex:indexPath.row];
    NSString* identifier = loc.isFree ? kFreeLocalisationCellIdent : kPayingLocalisationCellIdent;
    LocalisationCell* cell = (LocalisationCell*)[tableViewVal dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[LocalisationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setFieldsFromLoc:loc withSegue:@"favDetailSegue" andController:self];
    return cell;
}

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
