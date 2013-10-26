//
//  UIDatePickerHelper.h
//  Sistoque
//
//  Created by Humberto Mendes on 25/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIDatePickerHelper <NSObject>
    -(void)getDatePickerDate:(NSDate*)date;
@end

@interface UIDatePickerHelper : NSObject{
    NSDate *data;
    
    id<UIDatePickerHelper> delegate;
}

@property UIView *view;
-(id)initWithView:(UIView *)initView;
-(void)showDatePicker;

@property id delegate;

@end
