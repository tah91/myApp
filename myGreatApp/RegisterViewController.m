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
    [self.fbRegisterBtn setButtonWithStyle:@"Inscrivez-vous avec Facebook"];
    [self.noFbLabel setSubtitleWithStyle:@"Pas de compte Facebook ?"];
    [self.registerBtn setButtonWithStyle:@"Créer un compte"];
    [self.cguLabel setSubtitleWithStyle:@"En cliquant sur ""Créer un compte"" ou ""Inscrivez-vous avec Facebook"", vous confirmez que vous acceptez les conditions générales."];
    self.navigationItem.title = @"Inscription";
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
                    [cell setLabel:@"Prénom" placeHolder:@"Requis" initialValue:[self getCurrentValueForPath:indexPath] fieldType:TextfieldTypeStandard isLast:FALSE delegate:self];
                    break;
                case 1:
                    [cell setLabel:@"Nom" placeHolder:@"Requis" initialValue:[self getCurrentValueForPath:indexPath] fieldType:TextfieldTypeStandard isLast:FALSE delegate:self];
                    break;
                case 2:
                    [cell setLabel:@"E-mail" placeHolder:@"Requis" initialValue:[self getCurrentValueForPath:indexPath] fieldType:TextfieldTypeEmail isLast:FALSE delegate:self];
                    break;
                case 3:
                    [cell setLabel:@"Mot de passe" placeHolder:@"Requis" initialValue:[self getCurrentValueForPath:indexPath] fieldType:TextfieldTypePassword isLast:TRUE delegate:self];
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
        ALERT_TITLE(@"Erreur",@"Remplissez tous les champs")
    } else {
        [ApplicationDelegate.loginSession registerWithName:firstName
                                                  lastName:lastName
                                                     login:email
                                                  password:password
                                                  onSucess:^(void) {
                                                      [loginDelegate finishedLoadingUserInfo];
                                                  }
                                                   onError:^(NSError* error) {
                                                       ALERT_TITLE(@"Erreur",[error localizedDescription])
                                                   }];
    }
}


- (IBAction)fbRegister:(id)sender {
    [ApplicationDelegate.loginSession fbLoginOnSucess:^(void) {
        [loginDelegate finishedLoadingUserInfo];
    }
                                              onError:^(NSError* error) {
                                                  ALERT_TITLE(@"Erreur",[error localizedDescription])
                                              }];
}

- (IBAction)ewRegister:(id)sender
{
    [self submitForm];
}

@end
