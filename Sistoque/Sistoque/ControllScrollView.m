//
//  IIVControllScrollView.m
//  iInterviews
//
//  Created by Pedro Farias Barbosa on 13/10/13.
//  Copyright (c) 2013 Pedro Farias Barbosa. All rights reserved.
//

#import "ControllScrollView.h"

@implementation ControllScrollView

-(void)sobeTela:(id)field scrollView:(UIScrollView *)scrollView fieldPosition:(CGPoint)fieldPosition deviceSize:(CGSize)deviceSize
{
    sobeTela = NO;
    
    if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait)
    {
        if(fieldPosition.y > -(deviceSize.height/2))
            sobeTela = NO;
        else
            sobeTela = YES;
    }
    else
    {
        if(fieldPosition.y > -(deviceSize.height/2))
            sobeTela = NO;
        else
            sobeTela = YES;
    }
    
    if (sobeTela)
    {
        CGPoint pt;
        CGRect rc = [field bounds];
        rc = [field convertRect:rc toView:scrollView];
        pt = rc.origin;
        pt.x = 0;
        pt.y -= 150;
        [scrollView setContentOffset:pt animated:YES];
    }
}

-(void)hideKeyBoard:(id)field scrollView:(UIScrollView *)scrollView navigationControllerHidden:(BOOL)navigationControllerHidden
{
    
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (sobeTela)
    {
        CGPoint pt;
        
        if(sysVer >= 7.00)
        {
            if (navigationControllerHidden)
            {
                pt = svos;
            }
            else
            {
                pt = svos;
                pt.y-=60;
            }
        }
        else
            pt = svos;
        
        
        [scrollView setContentOffset:pt animated:YES];
    }
    
    [field resignFirstResponder];
}

-(void)setSvos:(UIScrollView *)scrollView
{
    svos = scrollView.contentOffset;
}
@end
