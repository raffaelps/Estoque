//
//  UIDatePickerHelper.m
//  Sistoque
//
//  Created by Humberto Mendes on 25/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "UIDatePickerHelper.h"
#import "UIPickerHelper.h"

@implementation UIDatePickerHelper

-(id)initWithView:(UIView *)initView{
    if(self = [self init]){
        super.view = initView;
    }
    return self;
}

- (void)changeDate:(UIDatePicker *)sender {
    data = sender.date;
}

- (void)showDatePicker{
    
    UIView *datePicker = [self createDatePicker];
    super.pickerView = datePicker;
    
    [super showPicker];
    
}

-(UIDatePicker*)createDatePicker{    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, super.view.bounds.size.height+44, 320, 216)];
    datePicker.tag = 10;
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    
    return datePicker;    
}

@end