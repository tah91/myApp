//
//  DescriptionViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 24/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DescriptionViewController.h"
#import "UITableView+TIAdditions.h"
#import "FeatureCell.h"
#import "DetailCell.h"
#import "UIView+TIAdditions.h"

@interface DescriptionViewController ()

@end

@implementation DescriptionViewController
@synthesize containerView;
@synthesize tabSelector;
@synthesize descLabel;
@synthesize descScrollView;
@synthesize featuresTableView;
@synthesize localisation;
@synthesize infosTableView;
@synthesize selectedTab;

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
    [self.view setBackgroundColor:BNG_PATTERN];
    [self.descScrollView setBackgroundColor:BNG_PATTERN];
    [self.infosTableView setBackgroundColor:BNG_PATTERN];
    [self.featuresTableView setBackgroundColor:BNG_PATTERN];
    
    [self.tabSelector setSelectedSegmentIndex:selectedTab];
    self.descLabel.text = localisation.description;
    self.descLabel.textColor = GREY_COLOR;
    [self.descLabel sizeToFit];
    
    [self.featuresTableView hideEmptyTableSeparators];
    
    [self setSubviewAtIndex:selectedTab];
    self.navigationItem.title = NSLocalizedString(@"Détails",nil);
    
    [self.descScrollView setContentSizeFromSubviews];
}

- (void)viewDidUnload
{
    [self setTabSelector:nil];
    [self setDescLabel:nil];
    [self setContainerView:nil];
    [self setFeaturesTableView:nil];
    [self setInfosTableView:nil];
    [self setDescScrollView:nil];
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
    if (tableView == infosTableView) {
        return 3;
    }
    else if(tableView == featuresTableView) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == infosTableView) {
        switch (section) {
            case 0:
                return 3;
                break;
            case 1:
                return 7;
                break;
            case 2:
                return 0;
                break;
            default:
                break;
        }
    }
    else if(tableView == featuresTableView){
         return [localisation.features count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == infosTableView) {
        static NSString* ident = @"infosCell";
        DetailCell* cell = [tableView dequeueReusableCellWithIdentifier:ident];
        switch (indexPath.section) {
            case 0:
            {
                switch (indexPath.row) {
                    case 0:
                        cell.titleLabel.text = NSLocalizedString(@"Accès routiers",nil);
                        cell.descriptionLabel.text = localisation.access.roadAccess;
                        break;
                    case 1:
                        cell.titleLabel.text = NSLocalizedString(@"Transports",nil);
                        cell.descriptionLabel.text = localisation.access.publicTransport;
                        break;
                    case 2:
                        cell.titleLabel.text = NSLocalizedString(@"Station",nil);
                        cell.descriptionLabel.text = localisation.access.station;
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            case 1:
            {
                switch (indexPath.row) {
                    case 0:
                        cell.titleLabel.text = NSLocalizedString(@"Lundi",nil);
                        cell.descriptionLabel.text = localisation.openingTimes.monday;
                        break;
                    case 1:
                        cell.titleLabel.text = NSLocalizedString(@"Mardi",nil);
                        cell.descriptionLabel.text = localisation.openingTimes.tuesday;
                        break;
                    case 2:
                        cell.titleLabel.text = NSLocalizedString(@"Mercredi",nil);
                        cell.descriptionLabel.text = localisation.openingTimes.wednesday;
                        break;
                    case 3:
                        cell.titleLabel.text = NSLocalizedString(@"Jeudi",nil);
                        cell.descriptionLabel.text = localisation.openingTimes.thursday;
                        break;
                    case 4:
                        cell.titleLabel.text = NSLocalizedString(@"Vendredi",nil);
                        cell.descriptionLabel.text = localisation.openingTimes.friday;
                        break;
                    case 5:
                        cell.titleLabel.text = NSLocalizedString(@"Samedi",nil);
                        cell.descriptionLabel.text = localisation.openingTimes.saturday;
                        break;
                    case 6:
                        cell.titleLabel.text = NSLocalizedString(@"Dimanche",nil);
                        cell.descriptionLabel.text = localisation.openingTimes.sunday;
                        break;
                    default:
                        break;
                }
            }
                break;
                
            case 2:
            {
                
            }
                break;
                
            default:
                break;
        }
        return cell;
    }
    else if(tableView == featuresTableView) {
        
        static NSString* ident = @"featureCell";
        FeatureCell* cell = [tableView dequeueReusableCellWithIdentifier:ident];
        Feature* feature = [localisation.features objectAtIndex:indexPath.row];
        cell.featureLabel.text = feature.featureDisplay;
        return cell;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == infosTableView) {
        switch (section) {
            case 0:
                return NSLocalizedString(@"Accès",nil);
                break;
            case 1:
                return NSLocalizedString(@"Horaires",nil);
                break;
            case 2:
                return NSLocalizedString(@"Itinéraire",nil);
                break;
            default:
                break;
        }
    }
    return nil;
}

#pragma mark - Table view delegate

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == infosTableView) {
        
        UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 0)];
        //[headerView setBackgroundColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]];
        
        UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = BLUE_COLOR;
        headerLabel.font = FONT_BOLD(17.0f);
        headerLabel.frame = CGRectMake(20, 0, 320.0, 25);
        headerLabel.text = [self tableView:tableView titleForHeaderInSection:section];
        
        [headerView addSubview:headerLabel];
        
        return headerView;
    }
    return [[UIView alloc] initWithFrame:CGRectZero];
}

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

-(void)setSubviewAtIndex:(NSInteger)index{
    switch (index) {
        case 0:
            [infosTableView removeFromSuperview];
            [featuresTableView removeFromSuperview];
            [containerView addSubview:descLabel];
            break;
        case 1:
            [descLabel removeFromSuperview];
            [featuresTableView removeFromSuperview];
            [containerView addSubview:infosTableView];
            break;
        case 2:
            [descLabel removeFromSuperview];
            [infosTableView removeFromSuperview];
            [containerView addSubview:featuresTableView];
            break;
        default:
            break;
    }
}
- (IBAction)tabChanged:(id)sender {
    UISegmentedControl* seg = (UISegmentedControl*)sender;
    
    [self setSubviewAtIndex:seg.selectedSegmentIndex];
}
@end
