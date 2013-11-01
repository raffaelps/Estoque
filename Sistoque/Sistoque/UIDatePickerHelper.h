//
//  UIDatePickerHelper.h
//  Sistoque
//
//  Created by Humberto Mendes on 25/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIPickerHelper.h"

/*@protocol UIDatePickerHelper <NSObject>
    -(void)getDatePickerDate:(NSDate*)date;
@end*/

@interface UIDatePickerHelper : UIPickerHelper{
    //id<UIDatePickerHelper> delegate;
}

-(id)initWithView:(UIView *)initView;
- (void)showDatePicker;

//@property id delegate;

@end
