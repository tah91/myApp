//
//  AddCommentViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 27/08/12.
//
//

#import "AddCommentViewController.h"
#import "TextViewCell.h"
#import "AppDelegate.h"
#import "NSDate+TIAdditions.h"
#import "SHKActivityIndicator.h"

@interface AddCommentViewController ()

@end

@implementation AddCommentViewController

@synthesize localisation;

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
    [self.tableView registerNib:[UINib nibWithNibName:kTextViewCellIdent bundle:nil] forCellReuseIdentifier:kTextViewCellIdent];
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"Commenter";
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
    return 2;
}

- (NSString*) getIdentForIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 1:
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

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* ident = [self getIdentForIndexPath:indexPath];
    TextFieldCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:ident];
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    [cell setLabel:@"Note"
                       placeHolder:@"Requis"
                      initialValue:(NSString*)[self getCurrentValueForPath:indexPath]
                         fieldType:TextfieldTypeNumber
                            isLast:FALSE
                          delegate:self];
                    break;
                case 1:
                {
                    TextViewCell* textView = (TextViewCell*)cell;
                    [textView  setLabel:@"Description"
                           initialValue:[self getCurrentValueForPath:indexPath]
                                 isLast:FALSE
                               delegate:self];
                    break;
                }
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
                case 1:
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

-(void)initCurrentValues
{
    [super initCurrentValues];
}

-(void) submitForm
{
    [super submitForm];
    
    NSString* rating = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString* post = [self getCurrentValueForPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if([rating length]==0 || [post length]==0) {
        ALERT_TITLE(@"Erreur",@"Remplissez tous les chammps obligatoires")
    }
    else {
        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
        [params trySetObject:[ApplicationDelegate.loginSession authData].token forKey:@"token"];
        [params trySetObject:[NSNumber numberWithInt:self.localisation.id] forKey:@"id"];
        [params trySetObject:rating forKey:@"rating"];
        [params trySetObject:post forKey:@"post"];
        
        [[SHKActivityIndicator currentIndicator] displayActivity:@"Envoi en cours"];
        [ApplicationDelegate.localisationEngine enqueueOperationWithUrl:COMMENT_URL
                                                                 params:params
                                                             httpMethod:@"POST"
                                                           onCompletion:^(NSObject* json) {
                                                               [[SHKActivityIndicator currentIndicator] displayCompleted:@"Commentaire envoyé"];
                                                           }
                                                                onError:^(NSError* error) {
                                                                    [[SHKActivityIndicator currentIndicator] displayCompleted:@"Commentaire non envoyé"];
                                                                    ALERT_TITLE(@"Erreur",[error localizedDescription])
                                                                }];
    }
}

- (IBAction)addCommentDone:(id)sender
{
    [self submitForm];
}

- (IBAction)addCommentCancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
