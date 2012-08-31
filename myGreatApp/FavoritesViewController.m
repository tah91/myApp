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
#import "DetailViewController.h"

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
    
    [self.tableView setBackgroundColor:BNG_PATTERN];
    
    self.navigationItem.title = NSLocalizedString(@"Favoris",nil);
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

- (void) shouldFetchData
{
    if([ApplicationDelegate.loginSession isLogged]){
        [self fetchData];
    } else {
        [self performSegueWithIdentifier:@"favsToLoginSegue" sender:self];
    }
}

- (void) fetchData
{
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params trySetObject:[ApplicationDelegate.loginSession authData].token forKey:@"token"];

    [[SHKActivityIndicator currentIndicator] displayActivity:NSLocalizedString(@"Chargement en cours",nil)];
    [ApplicationDelegate.localisationEngine enqueueOperationWithUrl:GET_FAV_URL
                                                             params:params
                                                         httpMethod:@"GET"
                                                       onCompletion:^(NSObject* json) {
                                                           [[SHKActivityIndicator currentIndicator] displayCompleted:NSLocalizedString(@"Chargement terminé",nil)];
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
                                                                [[SHKActivityIndicator currentIndicator] displayCompleted:NSLocalizedString(@"Echec lors du chargement",nil)];
                                                                ALERT_TITLE(NSLocalizedString(@"Erreur",nil),[error localizedDescription])
                                                            }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"favDetailSegue"]) {
        NSIndexPath* selectedIndex = [self.tableView indexPathForSelectedRow];
        LocalisationCell* cell = (LocalisationCell*)[self tableView:self.tableView cellForRowAtIndexPath:selectedIndex];
        
        DetailViewController *ds = [segue destinationViewController];
        [ds setLocalisation:cell.localisation];
    } else if ([segue.identifier isEqualToString:@"favsToLoginSegue"]) {
        [LoginViewController setLoginDelegate:self toController:segue.destinationViewController];
    }
}

#pragma mark - LoginViewController Delegate Method

-(void)finishedLoadingUserInfo
{
    // Dismiss the LoginViewController that we instantiated earlier
    [self dismissModalViewControllerAnimated:YES];
    
    // Do other stuff as needed
    [self fetchData];
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
