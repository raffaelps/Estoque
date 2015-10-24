//
//  UIBarButtonItemHelper.m
//  Sistoque
//
//  Created by Humberto Mendes on 27/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "UIBarButtonItemHelper.h"

@implementation UIBarButtonItemHelper

-(id)initWithTitle:(NSString*)title andStyle:(enum UIBarButtonItemStyle)style andTarget:(id)target andSelector:(SEL*)selector{
    
    if(self = [self init]){
        _title = title;
        _style = style;
        _target = target;
        _selector = selector;
    }
    return self;
    
}

-(UIBarButtonItem*)createBarButtonItemHelper{
    return [[UIBarButtonItem alloc]
            initWithTitle:_title
            style:_style
            target:_target
            action:*_selector];
}

@end
