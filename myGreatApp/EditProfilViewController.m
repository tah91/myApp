//
//  EditProfilViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 22/08/12.
//
//

#import "EditProfilViewController.h"
#import "TextFieldCell.h"
#import "DropdownCell.h"
#import "AppDelegate.h"
#import "Auth.h"

@interface EditProfilViewController ()

@end

@implementation EditProfilViewController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

-(void) submitForm
{
    //Do nothing by default
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (NSString*) getIdentForIndexPath:(NSIndexPath *)indexPath
{
    static NSString* detailIdent = @"editProfilCell";
    static NSString* descriptionIdent = @"ddEditProfilCell";
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 2:
                case 3:
                    return descriptionIdent;
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    return detailIdent;
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* ident = [self getIdentForIndexPath:indexPath];
    TextFieldCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:ident];
    
    Auth* auth = [ApplicationDelegate.loginSession authData];
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    [cell setLabel:@"Prénom" initialValue:auth.firstName fieldType:TextfieldTypeStandard isLast:FALSE delegate:self];
                    break;
                case 1:
                    [cell setLabel:@"Nom" initialValue:auth.lastName fieldType:TextfieldTypeStandard isLast:FALSE delegate:self];
                    break;
                case 2:
                {
                    DropdownCell* dropdown = (DropdownCell*)cell;
                    NSDictionary* source = [[NSDictionary alloc] initWithObjectsAndKeys:
                                            @"Propriétaire d'un lieu",[NSNumber numberWithInt:MemberProfileLocalisationOwner],
                                            @"Nomad",[NSNumber numberWithInt:MemberProfileNomad],
                                            @"Télétravailleur",[NSNumber numberWithInt:MemberProfileTeleworker],
                                            @"Indépendant",[NSNumber numberWithInt:MemberProfileIndependant],
                                            @"Startup",[NSNumber numberWithInt:MemberProfileStartup],
                                            @"Grand compte",[NSNumber numberWithInt:MemberProfileCompany],
                                            @"Etudiant",[NSNumber numberWithInt:MemberProfileStudent],
                                            @"Utilisateur du dimanche",[NSNumber numberWithInt:MemberProfilePunctualUser],
                                            @"Autre",[NSNumber numberWithInt:MemberProfileOther],
                                            nil];
                    [dropdown  setLabel:@"Profil" initialValue:auth.profile isLast:FALSE source:source delegate:self];
                    break;
                }
                case 3:
                {
                    DropdownCell* dropdown = (DropdownCell*)cell;
                    NSDictionary* source = [[NSDictionary alloc] initWithObjectsAndKeys:
                                            @"Mr",[NSNumber numberWithInt:CiviltyMr],
                                            @"Mme",[NSNumber numberWithInt:CiviltyMme],
                                            @"Mlle",[NSNumber numberWithInt:CiviltyMlle],
                                            nil];
                    [dropdown  setLabel:@"Civilité" initialValue:auth.civility isLast:FALSE source:source delegate:self];
                    break;
                }
                case 4:
                    [cell setLabel:@"Ville" initialValue:auth.city fieldType:TextfieldTypeStandard isLast:FALSE delegate:self];
                    break;
                case 5:
                    [cell setLabel:@"Code Postal" initialValue:auth.postalCode fieldType:TextfieldTypeStandard isLast:FALSE delegate:self];
                    break;
                case 6:
                    [cell setLabel:@"Description" initialValue:auth.description fieldType:TextfieldTypeStandard isLast:TRUE delegate:self];
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
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
