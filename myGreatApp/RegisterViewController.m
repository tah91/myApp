//
//  RegisterViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "UIView+TIAdditions.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize fbRegisterBtn;
@synthesize noFbLabel;
@synthesize registerBtn;
@synthesize cguLabel;
@synthesize loginDelegate;

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
    [self.fbRegisterBtn setFBButtonWithStyle:NSLocalizedString(@"Inscrivez-vous avec Facebook",nil)];
    [self.noFbLabel setSubtitleWithStyle:NSLocalizedString(@"Pas de compte Facebook ?",nil)];
    [self.registerBtn setButtonWithStyle:NSLocalizedString(@"Créer un compte",nil)];
    [self.cguLabel setSubtitleWithStyle:NSLocalizedString(@"En cliquant sur " "Créer un compte"" ou ""Inscrivez-vous avec Facebook"", vous confirmez que vous acceptez les conditions générales.",nil)];
    self.navigationItem.title = NSLocalizedString(@"Inscription",nil);
    
    self.tableView.backgroundColor = BNG_PATTERN;
}

- (void)viewDidUnload
{
    [self setFbRegisterBtn:nil];
    [self setNoFbLabel:nil];
    [self setRegisterBtn:nil];
    [self setCguLabel:nil];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFieldCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:kTextFielCellIdent];
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    [cell setLabel:NSLocalizedString(@"Prénom",nil) placeHolder:NSLocalizedString(@"Requis",nil) initialValue:[self getCurrentValueForPath:indexPath] fieldType:TextfieldTypeStandard isLast:FALSE delegate:self];
                    break;
                case 1:
                    [cell setLabel:NSLocalizedString(@"Nom",nil) placeHolder:NSLocalizedString(@"Requis",nil) initialValue:[self getCurrentValueForPath:indexPath] fieldType:TextfieldTypeStandard isLast:FALSE delegate:self];
                    break;
                case 2:
                    [cell setLabel:NSLocalizedString(@"E-mail",nil) placeHolder:NSLocalizedString(@"Requis",nil) initialValue:[self getCurrentValueForPath:indexPath] fieldType:TextfieldTypeEmail isLast:FALSE delegate:self];
                    break;
                case 3:
                    [cell setLabel:NSLocalizedString(@"Mot de passe",nil) placeHolder:NSLocalizedString(@"Requis",nil) initialValue:[self getCurrentValueForPath:indexPath] fieldType:TextfieldTypePassword isLast:TRUE delegate:self];
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

-(void)initCurrentValues
{
    [super initCurrentValues];
}

-(void) submitForm
{
    [super submitForm];
    
    NSString* firstName = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString* lastName = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString* email = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString* password = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    if([firstName length]==0 || [lastName length]==0 || [email length]==0 || [password length]==0) {
        ALERT_TITLE(NSLocalizedString(@"Erreur",nil),NSLocalizedString(@"Remplissez tous les champs",nil))
    } else {
        [ApplicationDelegate.loginSession registerWithName:firstName
                                                  lastName:lastName
                                                     login:email
                                                  password:password
                                                  onSucess:^(void) {
                                                      [loginDelegate finishedLoadingUserInfo];
                                                  }
                                                   onError:^(NSError* error) {
                                                       ALERT_TITLE(NSLocalizedString(@"Erreur",nil),[error localizedDescription])
                                                   }];
    }
}


- (IBAction)fbRegister:(id)sender {
    [ApplicationDelegate.loginSession fbLoginOnSucess:^(void) {
        [loginDelegate finishedLoadingUserInfo];
    }
                                              onError:^(NSError* error) {
                                                  ALERT_TITLE(NSLocalizedString(@"Erreur",nil),[error localizedDescription])
                                              }];
}

- (IBAction)ewRegister:(id)sender
{
    [self submitForm];
}

@end
