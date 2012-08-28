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
#import "DateCell.h"
#import "TextViewCell.h"
#import "NSDate+TIAdditions.h"
#import "SHKActivityIndicator.h"

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
    [self.tableView registerNib:[UINib nibWithNibName:kDropdownCellIdent bundle:nil] forCellReuseIdentifier:kDropdownCellIdent];
    [self.tableView registerNib:[UINib nibWithNibName:kTextFielCellIdent bundle:nil] forCellReuseIdentifier:kTextFielCellIdent];
    [self.tableView registerNib:[UINib nibWithNibName:kDateCellIdent bundle:nil] forCellReuseIdentifier:kDateCellIdent];
    [self.tableView registerNib:[UINib nibWithNibName:kTextViewCellIdent bundle:nil] forCellReuseIdentifier:kTextViewCellIdent];
    
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Editer mon profil",nil);
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone
                                                                                    target:self
                                                                                    action:@selector(editProfileDone:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (NSString*) getIdentForIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                case 3:
                    return kDropdownCellIdent;
                    break;
                case 4:
                    return kDateCellIdent;
                case 7:
                    return kTextViewCellIdent;
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    return kTextFielCellIdent;
}

- (NSDictionary*) getProfileSource
{
    static NSDictionary* profileSource = nil;
    if(profileSource == nil) {
        profileSource = [[NSDictionary alloc] initWithObjectsAndKeys:
                         NSLocalizedString(@"Propriétaire d'un lieu",nil),[NSNumber numberWithInt:MemberProfileLocalisationOwner],
                         NSLocalizedString(@"Nomad",nil),[NSNumber numberWithInt:MemberProfileNomad],
                         NSLocalizedString(@"Télétravailleur",nil),[NSNumber numberWithInt:MemberProfileTeleworker],
                         NSLocalizedString(@"Indépendant",nil),[NSNumber numberWithInt:MemberProfileIndependant],
                         NSLocalizedString(@"Startup",nil),[NSNumber numberWithInt:MemberProfileStartup],
                         NSLocalizedString(@"Grand compte",nil),[NSNumber numberWithInt:MemberProfileCompany],
                         NSLocalizedString(@"Etudiant",nil),[NSNumber numberWithInt:MemberProfileStudent],
                         NSLocalizedString(@"Utilisateur du dimanche",nil),[NSNumber numberWithInt:MemberProfilePunctualUser],
                         NSLocalizedString(@"Autre",nil),[NSNumber numberWithInt:MemberProfileOther],
                         nil];
    }
    return profileSource;
}

- (NSDictionary*) getCivilitySource
{
    static NSDictionary* civilitySource = nil;
    if(civilitySource == nil) {
        civilitySource = [[NSDictionary alloc] initWithObjectsAndKeys:
                          NSLocalizedString(@"Mr",nil),[NSNumber numberWithInt:CiviltyMr],
                          NSLocalizedString(@"Mme",nil),[NSNumber numberWithInt:CiviltyMme],
                          NSLocalizedString(@"Mlle",nil),[NSNumber numberWithInt:CiviltyMlle],
                          nil];
    }
    return civilitySource;
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* ident = [self getIdentForIndexPath:indexPath];
    TextFieldCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:ident];
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    DropdownCell* dropdown = (DropdownCell*)cell;
                    [dropdown  setLabel:NSLocalizedString(@"Civilité",nil)
                           initialValue:[self getCurrentValueForPath:indexPath]
                                 isLast:FALSE source:[self getCivilitySource]
                               delegate:self];
                    break;
                }
                case 1:
                    [cell setLabel:NSLocalizedString(@"Prénom",nil)
                       placeHolder:NSLocalizedString(@"Requis",nil)
                      initialValue:[self getCurrentValueForPath:indexPath]
                         fieldType:TextfieldTypeStandard
                            isLast:FALSE
                          delegate:self];
                    break;
                case 2:
                    [cell setLabel:NSLocalizedString(@"Nom",nil)
                       placeHolder:NSLocalizedString(@"Requis",nil)
                      initialValue:[self getCurrentValueForPath:indexPath]
                         fieldType:TextfieldTypeStandard
                            isLast:FALSE
                          delegate:self];
                    break;
                case 3:
                {
                    DropdownCell* dropdown = (DropdownCell*)cell;
                    
                    [dropdown  setLabel:NSLocalizedString(@"Profil",nil)
                           initialValue:[self getCurrentValueForPath:indexPath]
                                 isLast:FALSE
                                 source:[self getProfileSource]
                               delegate:self];
                    break;
                }
                case 4:
                {
                    DateCell* date = (DateCell*)cell;
                    [date  setLabel:NSLocalizedString(@"Date de naissance",nil)
                       initialValue:[[DateCell getFormater] dateFromString:(NSString*)[self getCurrentValueForPath:indexPath]]
                             isLast:FALSE
                           delegate:self];
                    break;
                }
                case 5:
                    [cell setLabel:NSLocalizedString(@"Ville",nil)
                       placeHolder:NSLocalizedString(@"Paris",nil)
                      initialValue:[self getCurrentValueForPath:indexPath]
                         fieldType:TextfieldTypeStandard
                            isLast:FALSE
                          delegate:self];
                    break;
                case 6:
                    [cell setLabel:NSLocalizedString(@"Code Postal",nil)
                       placeHolder:NSLocalizedString(@"75007",nil)
                      initialValue:[self getCurrentValueForPath:indexPath]
                         fieldType:TextfieldTypeNumber
                            isLast:FALSE
                          delegate:self];
                    break;
                case 7:
                {
                    TextViewCell* textView = (TextViewCell*)cell;
                    [textView  setLabel:NSLocalizedString(@"Description",nil)
                           initialValue:[self getCurrentValueForPath:indexPath]
                                 isLast:FALSE
                               delegate:self];
                    break;
                }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 7:
                    return 100.f;
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    return 44.0f;
}

-(void) submitForm
{
    [super submitForm];
    
    NSString* civility = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString* firstName = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString* lastName = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString* profile = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSString* birthdate = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    NSString* city = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    NSString* postaleCode = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    NSString* description = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    
    if([firstName length]==0 || [lastName length]==0 ) {
        ALERT_TITLE(NSLocalizedString(@"Erreur",nil),NSLocalizedString(@"Remplissez tous les chammps obligatoires",nil))
    } else {
        
        NSString* birthDateStr = [[[DateCell getFormater] dateFromString: birthdate] toCSharpDate];
        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
        [params trySetObject:[ApplicationDelegate.loginSession authData].token forKey:@"token"];
        [params trySetObject:civility forKey:@"civility"];
        [params trySetObject:firstName forKey:@"firstName"];
        [params trySetObject:lastName forKey:@"lastName"];
        [params trySetObject:profile forKey:@"profile"];
        [params trySetObject:birthDateStr forKey:@"birthDate"];
        [params trySetObject:city forKey:@"city"];
        [params trySetObject:postaleCode forKey:@"postalCode"];
        [params trySetObject:description forKey:@"description"];
        
        [[SHKActivityIndicator currentIndicator] displayActivity:NSLocalizedString(@"Mise à jour en cours",nil)];
        [ApplicationDelegate.localisationEngine enqueueOperationWithUrl:EDIT_INFO_URL
                                                                 params:params
                                                             httpMethod:@"POST"
                                                           onCompletion:^(NSObject* json) {
                                                               [[SHKActivityIndicator currentIndicator] displayCompleted:NSLocalizedString(@"Profil mis à jour",nil)];
                                                               [ApplicationDelegate.loginSession storeUserInfo:json];
                                                           }
                                                                onError:^(NSError* error) {
                                                                    [[SHKActivityIndicator currentIndicator] displayCompleted:NSLocalizedString(@"Profil non mis à jour",nil)];
                                                                    ALERT_TITLE(@"Erreur",[error localizedDescription])
                                                                }];
    }
}

- (IBAction)editProfileDone:(id)sender
{
    [self submitForm];
}

-(void)initCurrentValues
{
    [super initCurrentValues];
    
    Auth* auth = [ApplicationDelegate.loginSession authData];
    [self.currentValues trySetObject:auth.civility forKey:[NSIndexPath indexPathForRow:0 inSection:0]];
    [self.currentValues trySetObject:auth.firstName forKey:[NSIndexPath indexPathForRow:1 inSection:0]];
    [self.currentValues trySetObject:auth.lastName forKey:[NSIndexPath indexPathForRow:2 inSection:0]];
    [self.currentValues trySetObject:auth.profile forKey:[NSIndexPath indexPathForRow:3 inSection:0]];
    [self.currentValues trySetObject:[[DateCell getFormater] stringFromDate:[NSDate dateFromRFC1123:auth.birthDate]] forKey:[NSIndexPath indexPathForRow:4 inSection:0]];
    [self.currentValues trySetObject:auth.city forKey:[NSIndexPath indexPathForRow:5 inSection:0]];
    [self.currentValues trySetObject:auth.postalCode forKey:[NSIndexPath indexPathForRow:6 inSection:0]];
    [self.currentValues trySetObject:auth.description forKey:[NSIndexPath indexPathForRow:7 inSection:0]];
}

@end
