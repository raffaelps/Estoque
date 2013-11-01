//
//  UIViewHelper.m
//  Sistoque
//
//  Created by Humberto Mendes on 31/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "UIPickerHelper.h"

@implementation UIPickerHelper
@synthesize delegate;

-(void)sendDataSelector:(id)sender{
    
    //Verifica se alguém está escutando
    if([delegate respondsToSelector:@selector(getPickerValue:)])
    {
        //Envia o resultado para a função
        [delegate getPickerValue:data];
    }
    
    [self dismissPicker:sender];
}

- (void)removeViews:(id)object {
    [[_view viewWithTag:9] removeFromSuperview];
    [[_view viewWithTag:10] removeFromSuperview];
    [[_view viewWithTag:11] removeFromSuperview];
}

- (void)dismissPicker:(id)sender {
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

-(UIToolbar*)createToolbar{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, _view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(sendDataSelector:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    return toolBar;
}

-(UIView*)createOverlay{
    UIView *darkView = [[UIView alloc] initWithFrame:_view.bounds];
    darkView.alpha = 0.5;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker:)];
    [darkView addGestureRecognizer:tapGesture];
    
    return darkView;
}

- (void)showPicker{
    
    if ([_view viewWithTag:9]){
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(0, _view.bounds.size.height-216-44, 320, 44);
    CGRect targetFrame = CGRectMake(0, _view.bounds.size.height-216, 320, 216);
    
    UIView *darkView = [self createOverlay];
    [_view addSubview:darkView];
    
    //UIView *pickerView = [self createDatePicker];
    [_view addSubview:_pickerView];
    
    UIToolbar* toolBar = [self createToolbar];
    [_view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    //datePicker.frame = targetFrame;
    _pickerView.frame = targetFrame;
    [UIView commitAnimations];
    
}

@end
