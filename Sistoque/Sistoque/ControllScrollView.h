//
//  IIVControllScrollView.h
//  iInterviews
//
//  Created by Pedro Farias Barbosa on 13/10/13.
//  Copyright (c) 2013 Pedro Farias Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControllScrollView : NSObject
{
    CGPoint svos;
    BOOL sobeTela;
}
-(void)sobeTela:(id)field scrollView:(UIScrollView *)scrollView fieldPosition:(CGPoint)fieldPosition deviceSize:(CGSize)deviceSize;
-(void)hideKeyBoard:(id)field scrollView:(UIScrollView *)scrollView navigationControllerHidden:(BOOL)navigationControllerHidden;
-(void)setSvos:(UIScrollView *)scrollView;
@end
