//
//  UIDatePickerHelper.m
//  Sistoque
//
//  Created by Humberto Mendes on 25/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "UIDatePickerHelper.h"

@implementation UIDatePickerHelper

@synthesize delegate;

-(id)initWithView:(UIView *)initView{
    if(self = [self init]){
        _view = initView;
    }
    return self;
}

- (void)changeDate:(UIDatePicker *)sender {
    data = sender.date;
}

- (void)removeViews:(id)object {
    [[_view viewWithTag:9] removeFromSuperview];
    [[_view viewWithTag:10] removeFromSuperview];
    [[_view viewWithTag:11] removeFromSuperview];
}

- (void)dismissDatePicker:(id)sender {
    CGRect toolbarTargetFrame = CGRectMake(0, _view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, _view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [_view viewWithTag:9].alpha = 0;
    [_view viewWithTag:10].frame = datePickerTargetFrame;
    [_view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
}

-(void)addData:(id)sender{
    
    //Verifica se alguém está escutando
    if([delegate respondsToSelector:@selector(getDatePickerDate:)])
    {
        if(data == nil){
            data = [NSDate date];
        }
        
        //Envia o resultado para a função
        [delegate getDatePickerDate:data];
    }
    
    [self dismissDatePicker:sender];
}

- (void)showDatePicker{
    
    if ([_view viewWithTag:9]){
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(0, _view.bounds.size.height-216-44, 320, 44);
    CGRect targetFrame = CGRectMake(0, _view.bounds.size.height-216, 320, 216);
    
    /**/
    
    UIView *darkView = [self createOverlay];
    [_view addSubview:darkView];
    
    UIView *pickerView = [self createDatePicker];
    [_view addSubview:pickerView];
    
    UIToolbar* toolBar = [self createToolbar];
    [_view addSubview:toolBar];
        
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    //datePicker.frame = targetFrame;
    pickerView.frame = targetFrame;
    [UIView commitAnimations];
    
}

-(UIToolbar*)createToolbar{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, _view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addData:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    return toolBar;
}

-(UIView*)createOverlay{
    UIView *darkView = [[UIView alloc] initWithFrame:_view.bounds];
    darkView.alpha = 0.5;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    
    return darkView;
}

-(UIDatePicker*)createDatePicker{    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, _view.bounds.size.height+44, 320, 216)];
    datePicker.tag = 10;
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    
    return datePicker;    
}

-(UIPickerView *)createPickerView{
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _view.bounds.size.height+44, 320, 216)];
    pickerView.tag = 10;
    
    return pickerView;
}

@end
