//
//  DetailViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 30/07/12.
//
//

#import "DetailViewController.h"
#import "DescriptionViewController.h"
#import "GalleryViewController.h"
#import "CommentsViewController.h"
#import "DetailCell.h"
#import "UIView+TIAdditions.h"
#import "SHK.h"
#import "AppDelegate.h"
#import "NSDate+TIAdditions.h"

#define kTitleLength 20

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize picture;
@synthesize tableView;
@synthesize nameLabel;
@synthesize typeLabel;
@synthesize addressLabel;
@synthesize cityLabel;
@synthesize shareBtn;
@synthesize localisation;
@synthesize locId;
@synthesize imageLoadingOperation;

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
    [self.tableView registerNib:[UINib nibWithNibName:kDetailCellIdent bundle:nil] forCellReuseIdentifier:kDetailCellIdent];
    [super viewDidLoad];
    
    [self.tableView setBackgroundColor:BNG_PATTERN];
    UIBarButtonItem* navShareBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-btn-share.png"]
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(shareThis:)];
    
    UIBarButtonItem* favBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-btn-like.png"]
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self
                                                              action:@selector(addToFavorites:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:navShareBtn, favBtn, nil];
    
    [self.shareBtn setButtonWithStyle:NSLocalizedString(@"Partager",nil)];
    
    [self trySetLocalisationData];
}

- (void)viewDidUnload
{
    [self setPicture:nil];
    [self setTableView:nil];
    [self setNameLabel:nil];
    [self setTypeLabel:nil];
    [self setAddressLabel:nil];
    [self setCityLabel:nil];
    [self setShareBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)trySetLocalisationData
{
    if(self.localisation != nil) {
        return [self loadLocalisationData];
    }
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params trySetObject:[NSNumber numberWithInt:self.locId] forKey:@"id"];
    
    [[SHKActivityIndicator currentIndicator] displayActivity:NSLocalizedString(@"Chargement en cours",nil)];
    [ApplicationDelegate.localisationEngine enqueueOperationWithUrl:DETAILS_URL
                                                             params:params
                                                         httpMethod:@"GET"
                                                       onCompletion:^(NSObject* json) {
                                                           [[SHKActivityIndicator currentIndicator] displayCompleted:NSLocalizedString(@"Chargement terminé",nil)];
                                                           self.localisation = [[Localisation alloc] initWithDictionary:(NSDictionary*)json];
                                                           [self loadLocalisationData];
                                                       }
                                                            onError:^(NSError* error) {
                                                                [[SHKActivityIndicator currentIndicator] displayCompleted:NSLocalizedString(@"Echec lors du chargement",nil)];
                                                                //ALERT_TITLE(NSLocalizedString(@"Erreur",nil),[error localizedDescription])
                                                            }];
}

- (void)loadLocalisationData
{
    NSString* imageUrl = [localisation getMainImage:false];
    if([imageUrl length] != 0) {
        self.imageLoadingOperation = [ApplicationDelegate.localisationEngine imageAtURL:[NSURL URLWithString:imageUrl]
                                                                           onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                               
                                                                               if([imageUrl isEqualToString:[url absoluteString]]) {
                                                                                   
                                                                                   if (isInCache) {
                                                                                       self.picture.image = fetchedImage;
                                                                                   } else {
                                                                                       UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                                                                                       loadedImageView.frame = self.picture.frame;
                                                                                       loadedImageView.alpha = 0;
                                                                                       [self.view addSubview:loadedImageView];
                                                                                       
                                                                                       [UIView animateWithDuration:0.4
                                                                                                        animations:^
                                                                                        {
                                                                                            loadedImageView.alpha = 1;
                                                                                            self.picture.alpha = 0;
                                                                                        }
                                                                                                        completion:^(BOOL finished)
                                                                                        {
                                                                                            self.picture.image = fetchedImage;
                                                                                            self.picture.alpha = 1;
                                                                                            [loadedImageView removeFromSuperview];
                                                                                        }];
                                                                                   }
                                                                               }
                                                                           }];
    }

    self.nameLabel.text = localisation.name;
    self.nameLabel.textColor = BLUE_COLOR;
    self.typeLabel.text = localisation.type;
    self.typeLabel.textColor = ORANGE_COLOR;
    self.addressLabel.text = localisation.address;
    self.addressLabel.textColor = GREY_COLOR;
    self.cityLabel.text = localisation.city;
    self.cityLabel.textColor = GREY_COLOR;

    NSString* title = localisation.name;
    if([title length] > kTitleLength) {
        //title = [title substringToIndex:kTitleLength];
    }
    
    if([localisation.images count] == 0) {
        [self.picture removeAndHide];
    }
    self.navigationItem.title = title;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"descriptionSegue"] || [[segue identifier] isEqualToString:@"descDetailSegue"]) {
        
        DescriptionViewController* dc = [segue destinationViewController];
        [dc setLocalisation:localisation];
        [dc setSelectedTab:0];
        
    } else if ([[segue identifier] isEqualToString:@"infosSegue"]) {
        
        DescriptionViewController* dc = [segue destinationViewController];
        [dc setLocalisation:localisation];
        [dc setSelectedTab:1];
        
    } else if ([[segue identifier] isEqualToString:@"gallerySegue"]) {
        
        GalleryViewController* gc = [segue destinationViewController];
        [gc setLocalisation:localisation];
        
    } else if ([[segue identifier] isEqualToString:@"commentsSegue"]) {
        
        CommentsViewController* cc = [segue destinationViewController];
        [cc setLocalisation:localisation];
        
    } else if ([[segue identifier] isEqualToString:@"desktopsSegue"]) {
        
    } else if ([[segue identifier] isEqualToString:@"meetingsSegue"]) {
        
    } else if ([segue.identifier isEqualToString:@"detailToLoginSegue"]) {
        [LoginViewController setLoginDelegate:self toController:segue.destinationViewController];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [[localisation offerSummaries] count];
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (NSString*) getIdentForIndexPath:(NSIndexPath *)indexPath
{
    static NSString* detailIdent = kDetailCellIdent;
    static NSString* descriptionIdent = @"descriptionCell";
    
    switch (indexPath.section) {
        case 2:
            switch (indexPath.row) {
                case 1:
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
    DetailCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:ident];
    
    cell.accessoryView = [[UIView alloc] initWithFrame:CGRectZero];
    
    switch (indexPath.section) {
        case 0:
        {
            OffersSummary* elem = [[localisation offerSummaries] objectAtIndex:indexPath.row];
            [cell setLabel:[elem getTitle:TRUE] withSegue:@"" andController:self];
            cell.titleLabel.text = [elem getTitle:true];
        }
            break;
        case 1:
        {
            [cell setLabel:NSLocalizedString(@"Commentaires",nil) withSegue:@"commentsSegue" andController:self];
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                    [cell setLabel:NSLocalizedString(@"Description",nil) withSegue:@"descriptionSegue" andController:self];
                    cell.titleLabel.text = NSLocalizedString(@"Description",nil);
                    break;
                case 1:
                    [cell setLabelWithoutAccessory:localisation.description withSegue:@"descriptionSegue" andController:self];
                    cell.titleLabel.text = localisation.description;
                    break;
                case 2:
                    [cell setLabel:NSLocalizedString(@"Infos pratiques",nil) withSegue:@"infosSegue" andController:self];
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            [cell setLabel:NSLocalizedString(@"Gallerie",nil) withSegue:@"gallerySegue" andController:self];
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

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 2:
            switch (indexPath.row) {
                case 1:
                    return 80.f;
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

#pragma mark - LoginViewController Delegate Method

-(void)finishedLoadingUserInfo
{
    // Dismiss the LoginViewController that we instantiated earlier
    [self dismissModalViewControllerAnimated:YES];
    
    // Do other stuff as needed
    [self addToFavorites];
}

-(void) addToFavorites
{
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params trySetObject:[ApplicationDelegate.loginSession authData].token forKey:@"token"];
    [params trySetObject:[NSNumber numberWithInt:self.localisation.id] forKey:@"id"];
    
    [[SHKActivityIndicator currentIndicator] displayActivity:NSLocalizedString(@"Mise à jour en cours",nil)];
    [ApplicationDelegate.localisationEngine enqueueOperationWithUrl:ADD_TO_FAV_URL
                                                             params:params
                                                         httpMethod:@"POST"
                                                       onCompletion:^(NSObject* json) {
                                                           [[SHKActivityIndicator currentIndicator] displayCompleted:NSLocalizedString(@"Ajouté aux favoris",nil)];
                                                       }
                                                            onError:^(NSError* error) {
                                                                [[SHKActivityIndicator currentIndicator] displayCompleted:NSLocalizedString(@"Non ajouté aux favoris",nil)];
                                                                ALERT_TITLE(NSLocalizedString(@"Erreur",nil),[error localizedDescription])
                                                            }];
}

- (IBAction)shareThis:(id)sender
{
    // Create the item to share (in this example, a url)
    NSURL *url = [NSURL URLWithString:self.localisation.url];
    SHKItem *item = [SHKItem URL:url
                           title:[NSString stringWithFormat:NSLocalizedString(@"Je travaille à %@ via eworky",nil), self.localisation.name]
                     contentType:SHKURLContentTypeWebpage];
    
    // Get the ShareKit action sheet
    SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    
    // ShareKit detects top view controller (the one intended to present ShareKit UI) automatically,
    // but sometimes it may not find one. To be safe, set it explicitly
    [SHK setRootViewController:self];
    
    // Display the action sheet
    [actionSheet showInView:self.view];
}

- (IBAction)addToFavorites:(id)sender
{
    if([ApplicationDelegate.loginSession isLogged]){
        [self addToFavorites];
    } else {
        [self performSegueWithIdentifier:@"detailToLoginSegue" sender:self];
    }
}

@end
