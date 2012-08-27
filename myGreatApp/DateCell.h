//
//  DateCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 25/08/12.
//
//

#import "TextFieldCell.h"
#import "InteractionLabel.h"

#define kDateCellIdent @"DateCell"

@interface DateCell : TextFieldCell <InteractionLabelSelection>

@property (nonatomic,strong) IBOutlet InteractionLabel* dateDisplay;
@property (nonatomic,strong) id<InteractionLabelDelegate> delegate;

- (void)setLabel:(NSString*)text initialValue:(NSDate*)initial isLast:(BOOL)isLast delegate:(id<InteractionLabelDelegate>)dropdownDelegate;

+ (NSDateFormatter*) getFormater;

@end
