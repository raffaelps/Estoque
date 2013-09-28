//
//  FormCadastroCategoriaViewController.h
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormCadastroCategoriaViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textfieldDescricaoCategoria;
@property (weak, nonatomic) IBOutlet UISwitch *switchStatusCategoria;

- (IBAction)buttonSalvarCategoria:(id)sender;
@end
