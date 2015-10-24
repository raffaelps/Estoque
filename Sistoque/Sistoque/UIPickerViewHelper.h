//
//  UIPickerViewHelper.h
//  Sistoque
//
//  Created by Humberto Mendes on 31/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIPickerHelper.h"

@interface UIPickerViewHelper : UIPickerHelper<UIPickerViewDelegate, UIPickerViewDataSource>{
    NSArray* array;
}

-(id)initWithView:(UIView *)initView andArray:(NSArray*)array;
-(void)showPickerView;

@end
