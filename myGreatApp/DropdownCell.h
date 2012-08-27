//
//  DropdownCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 22/08/12.
//
//

#import "TextFieldCell.h"
#import "InteractionLabel.h"

#define kDropdownCellIdent @"DropdownCell"

@class DropdownCell;

@interface DropdownCell : TextFieldCell <UIPickerViewDataSource, UIPickerViewDelegate, InteractionLabelSelection>

@property (nonatomic,strong) IBOutlet InteractionLabel* dropdownValueDisplay;
@property (nonatomic,strong) NSString*       dropdownValue;
@property (nonatomic,strong) NSDictionary*   dropdownDict;
@property (nonatomic,strong) NSArray*        dropdownKeys;
@property (nonatomic,strong) id<InteractionLabelDelegate> delegate;

- (void)setLabel:(NSString*)text initialValue:(NSString*)initial isLast:(BOOL)isLast source:(NSDictionary *)source delegate:(id<InteractionLabelDelegate>)dropdownDelegate;

@end
