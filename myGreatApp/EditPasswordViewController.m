//
//  EditPasswordViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 22/08/12.
//
//

#import "EditPasswordViewController.h"
#import "NSDate+TIAdditions.h"
#import "SHKActivityIndicator.h"
#import "AppDelegate.h"

@interface EditPasswordViewController ()

@end

@implementation EditPasswordViewController

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
    [self.tableView registerNib:[UINib nibWithNibName:kTextFielCellIdent bundle:nil] forCellReuseIdentifier:kTextFielCellIdent];
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"Editer mon mot de passe";
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone
                                                                                    target:self
                                                                                    action:@selector(editPasswordDone:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
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
    return 3;
}

- (NSString*) getIdentForIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    return kTextFielCellIdent;
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
                    [cell setLabel:@"Mot de passe"
                       placeHolder:@"Requis"
                      initialValue:(NSString*)[self getCurrentValueForPath:indexPath]
                         fieldType:TextfieldTypePassword
                            isLast:FALSE
                          delegate:self];
                    break;
                case 1:
                    [cell setLabel:@"Nouveau"
                       placeHolder:@"Requis"
                      initialValue:(NSString*)[self getCurrentValueForPath:indexPath]
                         fieldType:TextfieldTypePassword
                            isLast:FALSE
                          delegate:self];
                    break;
                case 2:
                    [cell setLabel:@"Confirmation"
                       placeHolder:@"Requis"
                      initialValue:(NSString*)[self getCurrentValueForPath:indexPath]
                         fieldType:TextfieldTypePassword
                            isLast:TRUE
                          delegate:self];
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

-(void) submitForm
{
    [super submitForm];
    
    NSString* oldpassword = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString* newpassword = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString* confirmpassword = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    if([oldpassword length]==0 || [newpassword length]==0 || [confirmpassword length]==0) {
        ALERT_TITLE(@"Erreur",@"Remplissez tous les chammps obligatoires")
    }
    else if(![confirmpassword isEqualToString:newpassword]) {
        ALERT_TITLE(@"Erreur",@"Le nouveau mot de passe et sa confirmation doivent être identiques")
    }
    else {
        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
        [params trySetObject:[ApplicationDelegate.loginSession authData].token forKey:@"token"];
        [params trySetObject:oldpassword forKey:@"oldpassword"];
        [params trySetObject:newpassword forKey:@"newpassword"];
        [params trySetObject:confirmpassword forKey:@"confirmpassword"];
        
        [[SHKActivityIndicator currentIndicator] displayActivity:@"Mise à jour en cours"];
        [ApplicationDelegate.localisationEngine enqueueOperationWithUrl:EDIT_PASSWORD_URL
                                                                 params:params
                                                             httpMethod:@"POST"
                                                           onCompletion:^(NSObject* json) {
                                                               [[SHKActivityIndicator currentIndicator] displayCompleted:@"Mot de passe mis à jour"];
                                                               [ApplicationDelegate.loginSession storeUserInfo:json];
                                                           }
                                                                onError:^(NSError* error) {
                                                                    [[SHKActivityIndicator currentIndicator] displayCompleted:@"Mot de passe non mis à jour"];
                                                                    ALERT_TITLE(@"Erreur",[error localizedDescription])
                                                                }];
    }
}

- (IBAction)editPasswordDone:(id)sender
{
    [self submitForm];
}

-(void)initCurrentValues
{
    [super initCurrentValues];
}

@end
