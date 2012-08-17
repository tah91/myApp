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

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize picture;
@synthesize tableView;
@synthesize nameLabel;
@synthesize typeLabel;
@synthesize addressLabel;
@synthesize cityLabel;
@synthesize headerView;
@synthesize footerView;
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
    [super viewDidLoad];
    
    [self loadData];
}

- (void)viewDidUnload
{
    [self setPicture:nil];
    [self setTableView:nil];
    [self setNameLabel:nil];
    [self setTypeLabel:nil];
    [self setAddressLabel:nil];
    [self setCityLabel:nil];
    [self setHeaderView:nil];
    [self setFooterView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadData
{
    [self.tableView setBackgroundColor:BNG_PATTERN];
    [self.headerView setBackgroundColor:BNG_PATTERN];
    [self.footerView setBackgroundColor:BNG_PATTERN];
    
    self.picture.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:[localisation getMainImage:false]]]];
    self.nameLabel.text = localisation.name;
    self.nameLabel.textColor = BLUE_COLOR;
    self.typeLabel.text = localisation.type;
    self.typeLabel.textColor = ORANGE_COLOR;
    self.addressLabel.text = localisation.address;
    self.addressLabel.textColor = WHITE_COLOR;
    self.cityLabel.text = localisation.city;
    self.cityLabel.textColor = WHITE_COLOR;
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
    static NSString* detailIdent = @"detailCell";
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
            cell.titleLabel.text = [elem getTitle:true];
        }
            break;
        case 1:
        {
            cell.titleLabel.text = @"Commentaires";
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                    cell.titleLabel.text = @"Description";
                    break;
                case 1:
                    cell.titleLabel.text = localisation.description;
                    cell.accessoryView = nil;
                    break;
                case 2:
                    cell.titleLabel.text = @"Infos pratiques";
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            cell.titleLabel.text = @"Gallerie";
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
            [self performSegueWithIdentifier:@"commentsSegue" sender:self];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
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

@end
