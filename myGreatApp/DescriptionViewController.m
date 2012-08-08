//
//  DescriptionViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 24/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DescriptionViewController.h"
#import "ControllerHelper.h"

@interface DescriptionViewController ()

@end

@implementation DescriptionViewController
@synthesize containerView;
@synthesize tabSelector;
@synthesize descLabel;
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
    
    [tabSelector setSelectedSegmentIndex:selectedTab];
    descLabel.text = localisation.description;
    [descLabel sizeToFit];
    
    [ControllerHelper hideEmptyTableSeparators:featuresTableView];
    
    [self setSubviewAtIndex:selectedTab];
}

- (void)viewDidUnload
{
    [self setTabSelector:nil];
    [self setDescLabel:nil];
    [self setContainerView:nil];
    [self setFeaturesTableView:nil];
    [self setInfosTableView:nil];
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
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ident];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        }
        switch (indexPath.section) {
            case 0:
            {
                switch (indexPath.row) {
                    case 0:
                        cell.textLabel.text = localisation.access.roadAccess;
                        break;
                    case 1:
                        cell.textLabel.text = localisation.access.publicTransport;
                        break;
                    case 2:
                        cell.textLabel.text = localisation.access.station;
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
                        cell.textLabel.text = localisation.openingTimes.monday;
                        break;
                    case 1:
                        cell.textLabel.text = localisation.openingTimes.tuesday;
                        break;
                    case 2:
                        cell.textLabel.text = localisation.openingTimes.wednesday;
                        break;
                    case 3:
                        cell.textLabel.text = localisation.openingTimes.thursday;
                        break;
                    case 4:
                        cell.textLabel.text = localisation.openingTimes.friday;
                        break;
                    case 5:
                        cell.textLabel.text = localisation.openingTimes.saturday;
                        break;
                    case 6:
                        cell.textLabel.text = localisation.openingTimes.sunday;
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
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ident];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        }
        Feature* feature = [localisation.features objectAtIndex:indexPath.row];
        cell.textLabel.text = feature.featureDisplay;
        return cell;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == infosTableView) {
        switch (section) {
            case 0:
                return @"Acces";
                break;
            case 1:
                return @"Horaires";
                break;
            case 2:
                return @"Itinéraire";
                break;
            default:
                break;
        }
    }
    else if(tableView == featuresTableView) {
        return nil;
    }
    return nil;
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
