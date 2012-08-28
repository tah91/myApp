//
//  GalleryViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 25/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryViewController.h"

@interface GalleryViewController ()

@end

@implementation GalleryViewController

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

#pragma mark ATPagingViewDelegate methods

- (NSInteger)numberOfPagesInPagingView:(ATPagingView *)pagingView {
    return [[localisation images] count];
}

- (UIView *)viewForPageInPagingView:(ATPagingView *)pagingView atIndex:(NSInteger)index {
    UIImageView *view = (UIImageView*)[pagingView dequeueReusablePage];
    if (view == nil) {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 50)];
        Image* image = [[localisation images] objectAtIndex:index];
        view.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:image.url]]];
        view.contentMode = UIViewContentModeScaleAspectFit;
    }
    return view;
}

- (void)currentPageDidChangeInPagingView:(ATPagingView *)pagingView {
    self.navigationItem.title = [NSString stringWithFormat:NSLocalizedString(@"%d sur %d",nil), pagingView.currentPageIndex+1, pagingView.pageCount];
}

@end
