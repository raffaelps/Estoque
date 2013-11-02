//
//  UIPickerViewHelper.m
//  Sistoque
//
//  Created by Humberto Mendes on 31/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "UIPickerViewHelper.h"
#import "Categoria.h"

@implementation UIPickerViewHelper

-(id)initWithView:(UIView *)initView andArray:(NSArray*)initArray{
    if(self = [self init]){
        super.view = initView;
        array = initArray;
        [self createPickerView];
    }
    return self;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    data = [NSNumber numberWithInt:row];
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    //title = [@"" stringByAppendingFormat:@"%d",row];
    //Categoria *categoria = [_array objectAtIndex:row];
    NSLog(@"%@", [array objectAtIndex:row]);
    return [array objectAtIndex:row];
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

/*INIT PickerViewDataSouce*/
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return array.count;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)showPickerView{
    
    UIView *pickerView = [self createPickerView];
    super.picker = pickerView;
    
    [super showPicker];
    
}

/*END PickerViewDataSouce*/

-(UIPickerView*)createPickerView{
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, super.view.bounds.size.height+44, 320, 216)];
    pickerView.tag = 10;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    return pickerView;
}


@end
