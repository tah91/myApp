//
//  SelectSearchViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectSearchViewController.h"
#import "ResultViewController.h"

@interface SelectSearchViewController ()

@end

@implementation SelectSearchViewController

@synthesize criteria;

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
	// Do any additional setup after loading the view.
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"resultSegue"]) {
        
        ResultViewController* rvc = [segue destinationViewController];
        
        SearchCriteria* toSet = [[SearchCriteria alloc] initWithPlace:criteria.place];
        [rvc setCriteria:toSet];
    }
}

- (IBAction)toogle:(id)sender {
    if ([sender isSelected]) {
        [sender setImage:[UIImage imageNamed:@"header.png"] forState:UIControlStateNormal];
        [sender setSelected:NO];
    }else {
        [sender setImage:[UIImage imageNamed:@"logo2.png"] forState:UIControlStateSelected];
        [sender setSelected:YES];
    }
}
@end
