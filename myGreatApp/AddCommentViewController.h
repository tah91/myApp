//
//  AddCommentViewController.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 27/08/12.
//
//

#import <UIKit/UIKit.h>
#import "FormViewController.h"
#import "Localisation.h"

@protocol AddCommentDelegate

-(void)commentDone:(Localisation*)localisation;

@end

@interface AddCommentViewController : FormViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)addCommentDone:(id)sender;
- (IBAction)addCommentCancel:(id)sender;

@property (strong, nonatomic) Localisation* localisation;
@property (nonatomic,strong) id<AddCommentDelegate> delegate;

@end
