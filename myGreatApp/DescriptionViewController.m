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
#import "UIView+TIAdditions.h"
#import "DescriptionCell.h"
#import "MapCell.h"
#import "AppDelegate.h"

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
    [self.infosTableView registerNib:[UINib nibWithNibName:kDescriptionCellIdent bundle:nil] forCellReuseIdentifier:kDescriptionCellIdent];
    [self.infosTableView registerNib:[UINib nibWithNibName:kDetailCellIdent bundle:nil] forCellReuseIdentifier:kDetailCellIdent];
    
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
    [self.tabSelector setTitle:NSLocalizedString(@"Description",nil) forSegmentAtIndex:0];
    [self.tabSelector setTitle:NSLocalizedString(@"Infos pratiques",nil) forSegmentAtIndex:1];
    [self.tabSelector setTitle:NSLocalizedString(@"Services",nil) forSegmentAtIndex:2];
    
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
                return 4;
                break;
            case 1:
                return 8;
                break;
            case 2:
                return 3;
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
        static NSString* descIdent = kDescriptionCellIdent;
        static NSString* detailIdent = kDetailCellIdent;
        static NSString* mapIdent = @"mapCell";
        switch (indexPath.section) {
            case 0:
            {
                switch (indexPath.row) {
                    case 0: {
                        DetailCell* cell = [tableView dequeueReusableCellWithIdentifier:detailIdent];
                        [cell setLabel:NSLocalizedString(@"Accès",nil) withSegue:@"" andController:nil];
                        return cell;
                    }
                    case 1: {
                        DescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier:descIdent];
                        [cell setLabel:NSLocalizedString(@"Accès routiers",nil) andDesc:localisation.access.roadAccess];
                        return cell;
                    }
                    case 2: {
                        DescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier:descIdent];
                        [cell setLabel:NSLocalizedString(@"Transports",nil) andDesc:localisation.access.publicTransport];
                        return cell;
                    }
                    case 3: {
                        DescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier:descIdent];
                        [cell setLabel:NSLocalizedString(@"Station",nil) andDesc:localisation.access.station];
                        return cell;
                    }
                        
                    default:
                        break;
                }
            }
                break;
                
            case 1:
            {
                switch (indexPath.row) {
                    case 0: {
                        DetailCell* cell = [tableView dequeueReusableCellWithIdentifier:detailIdent];
                        [cell setLabel:NSLocalizedString(@"Horaires",nil) withSegue:@"" andController:nil];
                        return cell;
                    }
                    case 1: {
                        DescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier:descIdent];
                        [cell setLabel:NSLocalizedString(@"Lundi",nil) andDesc:localisation.openingTimes.monday];
                        return cell;
                    }
                    case 2: {
                        DescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier:descIdent];
                        [cell setLabel:NSLocalizedString(@"Mardi",nil) andDesc:localisation.openingTimes.tuesday];
                        return cell;
                    }
                    case 3: {
                        DescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier:descIdent];
                        [cell setLabel:NSLocalizedString(@"Mercredi",nil) andDesc:localisation.openingTimes.wednesday];
                        return cell;
                    }
                    case 4: {
                        DescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier:descIdent];
                        [cell setLabel:NSLocalizedString(@"Jeudi",nil) andDesc:localisation.openingTimes.thursday];
                        return cell;
                    }
                    case 5: {
                        DescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier:descIdent];
                        [cell setLabel:NSLocalizedString(@"Vendredi",nil) andDesc:localisation.openingTimes.friday];
                        return cell;
                    }
                    case 6: {
                        DescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier:descIdent];
                        [cell setLabel:NSLocalizedString(@"Samedi",nil) andDesc:localisation.openingTimes.saturday];
                        return cell;
                    }
                    case 7: {
                        DescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier:descIdent];
                        [cell setLabel:NSLocalizedString(@"Dimanche",nil) andDesc:localisation.openingTimes.sunday];
                        return cell;
                    }
                    default:
                        break;
                }
            }
                break;
                
            case 2:
            {
                switch (indexPath.row) {
                    case 0: {
                        DetailCell* cell = [tableView dequeueReusableCellWithIdentifier:detailIdent];
                        [cell setLabel:NSLocalizedString(@"Itinéraire",nil) withSegue:@"" andController:nil];
                        return cell;
                    }
                    case 1: {
                        MapCell* mapCell = [tableView dequeueReusableCellWithIdentifier:mapIdent];
                        [mapCell setPositionFromLat:localisation.latitude lng:localisation.longitude];
                        return mapCell;
                    }
                    case 2: {
                        DetailCell* cell = [tableView dequeueReusableCellWithIdentifier:detailIdent];
                        [cell setLabelWithAccessory:[NSString stringWithFormat:@"%@ - %@",localisation.address, localisation.city]];
                        return cell;
                    }
                    default:
                        break;
                }
            }
                break;
                
            default:
                break;
        }
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == infosTableView) {
        switch (indexPath.section) {
            case 2:
                switch (indexPath.row) {
                    case 2: {
                        NSString* itin = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%@,%@&daddr=%@,%@",
                                         ApplicationDelegate.latitude, ApplicationDelegate.longitude,
                                         localisation.latitude, localisation.longitude];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itin]];
                        return;
                    }
                    default:
                        break;
                }
                break;
                
            default:
                break;
        }
        return;
    } else if(tableView == featuresTableView) {
        return;
    }
    return;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == infosTableView) {
        switch (indexPath.section) {
            case 2:
                switch (indexPath.row) {
                    case 1:
                        return 100.f;
                        
                    default:
                        break;
                }
                break;
                
            default:
                break;
        }
        return 44.0f;
    } else if(tableView == featuresTableView) {
        return tableView.rowHeight;
    }
    return 0;
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
- (IBAction)tabChanged:(id)sender
{
    UISegmentedControl* seg = (UISegmentedControl*)sender;
    
    [self setSubviewAtIndex:seg.selectedSegmentIndex];
}

@end
