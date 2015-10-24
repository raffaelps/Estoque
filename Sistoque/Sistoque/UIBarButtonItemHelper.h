//
//  UIBarButtonItemHelper.h
//  Sistoque
//
//  Created by Humberto Mendes on 27/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIBarButtonItemHelper : NSObject

-(id)initWithTitle:(NSString*)title andStyle:(enum UIBarButtonItemStyle)style andTarget:(id)target andSelector:(SEL*)selector;
-(UIBarButtonItem*)createBarButtonItemHelper;

@property NSString* title;
@property UIBarButtonItemStyle style;
@property id target;
@property SEL * selector;

@end
