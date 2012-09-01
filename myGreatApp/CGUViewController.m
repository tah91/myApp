//
//  CGUViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 01/09/12.
//
//

#import "CGUViewController.h"
#import "AppDelegate.h"

@interface CGUViewController ()

@end

@implementation CGUViewController
@synthesize cguView;

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
    cguView.scalesPageToFit = YES;
    NSString* language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString* cguUrl = [NSString stringWithFormat:@"http://%@/home/tos?locale-culture=%@&force-non-mobile=1",HOST_NAME,language];
    [cguView loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:cguUrl]]];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setCguView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
