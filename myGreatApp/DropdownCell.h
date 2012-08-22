//
//  DropdownCell.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 22/08/12.
//
//

#import "TextFieldCell.h"

@class DropdownCell;

@protocol DropdownCellDelegate

-(void)selectionDone:(DropdownCell*)cell;

@end

@interface UIDropdownLabel : UILabel

@property (nonatomic, retain) UIView *inputView;
@property (nonatomic, retain) UIView *inputAccessoryView;

@end

@interface DropdownCell : TextFieldCell <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) IBOutlet UIDropdownLabel* dropdownValueDisplay;
@property (nonatomic,strong) NSNumber*              dropdownValue;
@property (nonatomic,strong) NSDictionary*   dropdownDict;
@property (nonatomic,strong) NSArray*        dropdownKeys;
@property (nonatomic,strong) id<DropdownCellDelegate> delegate;

- (void)setLabel:(NSString*)text initialValue:(NSNumber*)initial isLast:(BOOL)isLast source:(NSDictionary *)source delegate:(id<DropdownCellDelegate>)dropdownDelegate;
- (void)selectionDone:(id)sender;

@end
