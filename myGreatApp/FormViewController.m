//
//  FormViewController.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 18/08/12.
//
//

#import "FormViewController.h"
#import "UIViewController+TIAdditions.h"
#import "NSDate+TIAdditions.h"

@interface FormViewController ()

@end

@implementation FormViewController

@synthesize tableView, currentCell, currentValues;

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
    
    self.currentCell = nil;
    [self initCurrentValues];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    self.currentCell = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)goToNext:(TextFieldCell*)cell
{
    //store cell value
    NSIndexPath* currentIndex = [self updateValue:cell];

    //go to next
    NSIndexPath* nextIndexPath = nil;
    BOOL inLastSection = currentIndex.section + 1  == [self.tableView numberOfSections];
    BOOL lastRowOfSection = currentIndex.row + 1 == [self.tableView numberOfRowsInSection:currentIndex.section];
    
    //last section and last cell => close keyboard
    if( inLastSection && lastRowOfSection ) {
        [self.currentCell doResignFirstResponder];
        if(self.currentCell.shouldSubmit) {
            [self submitForm];
        }
        return;
    }
    //last cell in a section => got to next section
    else if(lastRowOfSection) {
        nextIndexPath = [NSIndexPath indexPathForRow:0 inSection:currentIndex.section +1];
    }
    //a cell in a section
    else {
        nextIndexPath = [NSIndexPath indexPathForRow:currentIndex.row + 1 inSection:currentIndex.section];
    }
    
    [self.tableView scrollToRowAtIndexPath:nextIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    TextFieldCell* nextCell = (TextFieldCell*)[self.tableView cellForRowAtIndexPath:nextIndexPath];
    [self updateCurrentCell:nextCell];
    [nextCell doBecomeFirstResponder];
}

static bool animated = true;

-(void) showCurrentField
{
    NSIndexPath* currentIndex = [self.tableView indexPathForCell:self.currentCell];
    
    if(currentIndex != nil) {
        [self.tableView scrollToRowAtIndexPath:currentIndex atScrollPosition:UITableViewScrollPositionMiddle animated:animated];
    } else {
        
        CGPoint point = [self.currentCell.textLabel.superview convertPoint:self.currentCell.textLabel.frame.origin toView:self.tableView];
        CGPoint offset = self.tableView.contentOffset;
        offset.y =  point.y - 80.0f;
        if(point.y != 0) {
            [self.tableView setContentOffset:offset animated:animated];
        }
    }
}

-(void) updateCurrentCell:(TextFieldCell*)cell
{
    self.currentCell = cell;
    [self.currentCell setFieldType];
}

-(NSIndexPath*) updateValue:(TextFieldCell*)cell
{
    NSIndexPath* currentIndex = [self.tableView indexPathForCell:cell];
    [self.currentValues trySetObject:[cell getCurrentValue] forKey:currentIndex];
    
    return currentIndex;
}

#pragma mark - InteractionLabel Delegate

-(void)selectionDone
{
    [self goToNext:self.currentCell];
}

-(void)interactionBegin:(TextFieldCell*)cell
{
    [self updateCurrentCell:cell];
}

#pragma mark - Text View edition

-(void)editionDone
{
    [self goToNext:self.currentCell];
}

#pragma mark - Text View Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    TextFieldCell* toSet = (TextFieldCell*)[[textView superview] superview];
    [self updateCurrentCell:toSet];
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    TextFieldCell* toSet = (TextFieldCell*)[[textField superview] superview];
    [self goToNext:toSet];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    TextFieldCell* toSet = (TextFieldCell*)[[textField superview] superview];
    [self updateValue:toSet];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    TextFieldCell* toSet = (TextFieldCell*)[[textField superview] superview];
    [self updateCurrentCell:toSet];
}

-(void) keyboardWillShow:(NSNotification *)note
{
    // Get the keyboard size
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    
    // Detect orientation
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect frame = self.tableView.frame;
    
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
    [self showCurrentField];
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
    [self.currentCell doResignFirstResponder];
    [self updateValue:self.currentCell];
    //Do nothing by default
}

-(void)initCurrentValues
{
    self.currentValues = [[NSMutableDictionary alloc] init];
}

-(void)setCurrentValue:(NSString*)value forPath:(NSIndexPath*)indexPath
{
    [currentValues setObject:value forKey:indexPath];
}

-(NSString*)getCurrentValueForPath:(NSIndexPath*)indexPath
{
    return [currentValues objectForKey:indexPath];
}

@end
