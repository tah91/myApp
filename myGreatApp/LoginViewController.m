//
//  LoginViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"
#import "TextFieldCell.h"
#import "UIView+TIAdditions.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize fbLoginBtn;
@synthesize registerBtn;
@synthesize alreadyMember1;
@synthesize alreadyMember2;
@synthesize needAccount1;
@synthesize needAccount2;
@synthesize loginDelegate;

+(void)setLoginDelegate:(id <LoginViewControllerDelegate>)delegate toController:(id)controller
{
    UINavigationController *parent = controller;
    LoginViewController *lvc = (LoginViewController*)[parent topViewController];
    lvc.loginDelegate = delegate; // For the delegate method
}

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
    
    [self.fbLoginBtn setButtonWithStyle:NSLocalizedString(@"S'inscrire avec Facebook",nil)];
    [self.registerBtn setButtonWithStyle:NSLocalizedString(@"S'inscrire",nil)];
    [self.alreadyMember1 setTitleWithStyle:NSLocalizedString(@"Déjà membre eWorky ?",nil)];
    [self.alreadyMember2 setSubtitleWithStyle:NSLocalizedString(@"Connectez-vous à votre compte eWorky",nil)];
    [self.needAccount1 setTitleWithStyle:NSLocalizedString(@"Besoin d'un compte ?",nil)];
    [self.needAccount2 setSubtitleWithStyle:NSLocalizedString(@"S'inscrire sur eWorky",nil)];
    
    self.navigationItem.title = NSLocalizedString(@"Connexion",nil);
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setFbLoginBtn:nil];
    [self setRegisterBtn:nil];
    [self setAlreadyMember1:nil];
    [self setAlreadyMember2:nil];
    [self setNeedAccount1:nil];
    [self setNeedAccount2:nil];
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFieldCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:kTextFielCellIdent];
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    [cell setLabel:NSLocalizedString(@"E-mail",nil)
                       placeHolder:NSLocalizedString(@"Requis",nil)
                      initialValue:[self getCurrentValueForPath:indexPath]
                         fieldType:TextfieldTypeEmail
                            isLast:FALSE
                          delegate:self];
                    break;
                case 1:
                    [cell setLabel:NSLocalizedString(@"Password",nil)
                       placeHolder:NSLocalizedString(@"Requis",nil)
                      initialValue:[self getCurrentValueForPath:indexPath]
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"registerSegue"]) {
        RegisterViewController* dest = segue.destinationViewController;
        dest.loginDelegate = self.loginDelegate; // For the delegate method
    }
}

-(void)initCurrentValues
{
    [super initCurrentValues];
}

-(void) submitForm
{
    [super submitForm];
    
    NSString* email = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString* password = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if([email length]==0 || [password length]==0 ) {
        ALERT_TITLE(NSLocalizedString(@"Erreur",nil),NSLocalizedString(@"Remplissez tous les chammps",nil))
    } else {
        [ApplicationDelegate.loginSession login:email
                                       password:password
                                       onSucess:^(void){
                                           [loginDelegate finishedLoadingUserInfo];
                                       }onError:^(NSError* error) {
                                           ALERT_TITLE(NSLocalizedString(@"Erreur",nil),[error localizedDescription])
                                       }];
    }
}

- (IBAction)fbLogin:(id)sender
{
    [ApplicationDelegate.loginSession fbLoginOnSucess:^(void){
        [loginDelegate finishedLoadingUserInfo];
                                        }
                                              onError:^(NSError* error) {
                                                  ALERT_TITLE(NSLocalizedString(@"Erreur",nil),[error localizedDescription])
                                              }];
}

- (IBAction)login:(id)sender
{
    [self submitForm];
}

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
