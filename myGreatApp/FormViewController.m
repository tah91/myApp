//
//  FormViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 18/08/12.
//
//

#import "FormViewController.h"
#import "UINavigationController+TIAdditions.h"

@interface FormViewController ()

@end

@implementation FormViewController

@synthesize tableView;

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
    
    // Register notification when the keyboard will be show
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    // Register notification when the keyboard will be hide
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)goToNext:(TextFieldCell*)cell
{
    NSIndexPath* pathOfTheCell = [self.tableView indexPathForCell:cell];
    
    NSIndexPath* nextIndexPath = nil;
    BOOL inLastSection = pathOfTheCell.section + 1  == [self.tableView numberOfSections];
    BOOL lastRowOfSection = pathOfTheCell.row + 1 == [self.tableView numberOfRowsInSection:pathOfTheCell.section];
    
    //last section and last cell => close keyboard
    if( inLastSection && lastRowOfSection ) {
        [cell doResignFirstResponder];
        [self submitForm];
        return;
    }
    //last cell in a section => got to next section
    else if(lastRowOfSection) {
        nextIndexPath = [NSIndexPath indexPathForRow:0 inSection:pathOfTheCell.section +1];
    }
    //a cell in a section
    else {
        nextIndexPath = [NSIndexPath indexPathForRow:pathOfTheCell.row + 1 inSection:pathOfTheCell.section];
    }
    
    [self.tableView scrollToRowAtIndexPath:nextIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    TextFieldCell* nextCell = (TextFieldCell*)[self.tableView cellForRowAtIndexPath:nextIndexPath];
    [nextCell doBecomeFirstResponder];
}

#pragma mark - DropdownCell Delegate

-(void)selectionDone:(DropdownCell*)cell
{
    [self goToNext:cell];
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    TextFieldCell* cell = (TextFieldCell*) textField.superview.superview;
    [self goToNext:cell];
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    UITableViewCell *cell = (UITableViewCell*) [[textField superview] superview];
    [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

-(void) keyboardWillShow:(NSNotification *)note
{
    // Get the keyboard size
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    
    // Detect orientation
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect frame = self.tableView.frame;
    
    //keyboard already here
    /*if(frame.size.height != self.view.frame.size.height) {
        return;
    }*/
    
    // Reduce size of the Table view
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        frame.size.height = self.view.frame.size.height - keyboardBounds.size.height;
    else
        frame.size.height = self.view.frame.size.height - keyboardBounds.size.width;
    
    if (![self isModal]) {
        frame.size.height += 49;
    }
    
    // Apply new size of table view
    self.tableView.frame = frame;
}

-(void) keyboardWillHide:(NSNotification *)note
{
    // Get the keyboard size
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    
    // Detect orientation
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect frame = self.tableView.frame;
    
    // Reduce size of the Table view
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        frame.size.height += keyboardBounds.size.height;
    else
        frame.size.height += keyboardBounds.size.width;
    
    // Apply new size of table view
    self.tableView.frame = frame;
}

-(void) submitForm
{
    //Do nothing by default
}

@end
