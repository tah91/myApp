//
//  UITableView+TIAdditions.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 14/08/12.
//
//

#import "UITableView+TIAdditions.h"

@implementation UITableView (TIAdditions)

-(void)hideEmptyTableSeparators
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:v];
}

@end
