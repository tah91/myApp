//
//  DetailViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 30/07/12.
//
//

#import "DetailViewController.h"
#import "ControllerHelper.h"
#import "AppDelegate.h"
#import "DescriptionViewController.h"
#import "GalleryViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize picture;
@synthesize tableView;
@synthesize nameLabel;
@synthesize typeLabel;
@synthesize addressLabel;
@synthesize cityLabel;
@synthesize localisation,locId;

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
    
    [ApplicationDelegate.localisationEngine detailsWithId:[NSNumber numberWithInt:locId]
                                             onCompletion:^(NSObject* localisationJson) {
                                                 NSMutableDictionary* json = (NSMutableDictionary*)localisationJson;
                                                 [self loadData:json];
                                             }
                                                  onError:^(NSError* error) {
                                                      ALERT_TITLE(@"Erreur",[error localizedDescription])
                                                  }];
}

- (void)viewDidUnload
{
    [self setPicture:nil];
    [self setTableView:nil];
    [self setNameLabel:nil];
    [self setTypeLabel:nil];
    [self setAddressLabel:nil];
    [self setCityLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadData:(NSMutableDictionary*)json {
    localisation = [[Localisation alloc] initWithDictionary:json];
    picture.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:[localisation getMainImage:false]]]];
    nameLabel.text = localisation.name;
    typeLabel.text = localisation.type;
    addressLabel.text = localisation.address;
    cityLabel.text = localisation.city;
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
        
    } else if ([[segue identifier] isEqualToString:@"reviewsSegue"]) {
        
    } else if ([[segue identifier] isEqualToString:@"desktopsSegue"]) {
        
    } else if ([[segue identifier] isEqualToString:@"meetingsSegue"]) {
        
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

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ident = @"featureCell";
    UITableViewCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    switch (indexPath.section) {
        case 0:
        {
            OffersSummary* elem = [[localisation offerSummaries] objectAtIndex:indexPath.row];
            cell.textLabel.text = [elem getTitle:true];
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"avis";
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"description";
                    break;
                case 1:
                    cell.textLabel.text = localisation.description;
                    break;
                case 2:
                    cell.textLabel.text = @"infos pratiques";
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"gallerie";
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
    switch (indexPath.section) {
        case 0:
        {
            OffersSummary* elem = [[localisation offerSummaries] objectAtIndex:indexPath.row];
            switch (elem.type) {
                case os_desktop:
                    [self performSegueWithIdentifier:@"desktopsSegue" sender:self];
                    break;
                case os_meetingRoom:
                    [self performSegueWithIdentifier:@"meetingsSegue" sender:self];
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            [self performSegueWithIdentifier:@"reviewsSegue" sender:self];
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                case 1:
                    [self performSegueWithIdentifier:@"descriptionSegue" sender:self];
                    break;
                case 2:
                    [self performSegueWithIdentifier:@"infosSegue" sender:self];
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            [self performSegueWithIdentifier:@"gallerySegue" sender:self];
        }
            break;
        default:
            break;
    }
}

@end
