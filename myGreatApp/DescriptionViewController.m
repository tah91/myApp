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
@synthesize infosView;
@synthesize featuresTableView;
@synthesize localisation;
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
    [self setInfosView:nil];
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
    return [localisation.features count];
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ident = @"featureCell";
    UITableViewCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
	cell.textLabel.text = [localisation.features objectAtIndex:indexPath.row];
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

-(void)setSubviewAtIndex:(NSInteger)index{
    switch (index) {
        case 0:
            [infosView removeFromSuperview];
            [featuresTableView removeFromSuperview];
            [containerView addSubview:descLabel];
            break;
        case 1:
            [descLabel removeFromSuperview];
            [featuresTableView removeFromSuperview];
            [containerView addSubview:infosView]; 
            break;
        case 2:
            [descLabel removeFromSuperview];
            [infosView removeFromSuperview];
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
