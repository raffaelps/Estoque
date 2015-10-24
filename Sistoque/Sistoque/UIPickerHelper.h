//
//  UIViewHelper.h
//  Sistoque
//
//  Created by Humberto Mendes on 31/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIPickerHelper <NSObject>
-(void)getPickerValue:(NSObject*)date;
@end

@interface UIPickerHelper : NSObject{
    NSObject *data;
    id<UIPickerHelper> delegate;
}

-(void)dismissPicker:(id)sender;
-(void)showPicker;

@property UIView *view;
@property UIView *picker;
@property id delegate;

@end
