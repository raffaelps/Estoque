//
//  FormCadastroCategoriaViewController.h
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categoria.h"

@interface FormCadastroCategoriaViewController : UIViewController{
    NSArray *conta_categorias;
    Categoria *categoriaSelect;
    BOOL novaCategoria;
}
@property (weak, nonatomic) IBOutlet UITextField *textfieldDescricaoCategoria;
@property (weak, nonatomic) IBOutlet UISwitch *switchStatusCategoria;

-(void)setCategoria:(Categoria *)categoria;

@end
