//
//  ReviewsViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 14/08/12.
//
//

#import "CommentsViewController.h"
#import "Comment.h"
#import "CommentCell.h"
#import "UIView+TIAdditions.h"

@interface CommentsViewController ()

@end

@implementation CommentsViewController

@synthesize localisation;

@synthesize tableView;
@synthesize addCommentBtn;


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
    
    [self.tableView setBackgroundColor:BNG_PATTERN];
    [self.addCommentBtn setButtonWithStyle:NSLocalizedString(@"Rédiger un avis",nil)];
    self.navigationItem.title = NSLocalizedString(@"Commentaires",nil);
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setAddCommentBtn:nil];
    [super viewDidUnload];
    
    self.localisation = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"addCommentSegue"]) {
        
        AddCommentViewController* acc = [segue destinationViewController];
        [acc setLocalisation:localisation];
        [acc setDelegate:self];
    }
    
}

#pragma mark - AddComment delegate

-(void)commentDone:(Localisation*)newLoc
{
    [self dismissModalViewControllerAnimated:YES];
    [self setLocalisation:newLoc];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.localisation.comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableViewVal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell* cell = [tableViewVal dequeueReusableCellWithIdentifier:@"commentCell"];
    
    Comment* comment = [self.localisation.comments objectAtIndex:indexPath.row];
    [cell setFieldsFromCom:comment];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    Comment* comment = [self.localisation.comments objectAtIndex:indexPath.row];
    CGFloat height = [CommentCell computeHeightFromPost:comment.post];
    
    return POST_CELL_HEIGHT - POST_CONTENT_HEIGHT + height;
}

@end
