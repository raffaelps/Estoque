//
//  FormCadastroProdutoViewController.h
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Produto.h"
#import "Categoria.h"
#import "UIPickerViewHelper.h"
#import "ControllScrollView.h"

@interface FormCadastroProdutoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerHelper>
{
    IBOutlet UITableViewCell *cellCategoria;
    IBOutlet UITableViewCell *cellDescricao;
    IBOutlet UITableViewCell *cellValores;
    IBOutlet UITableViewCell *cellQuantidades;
    IBOutlet UITableViewCell *cellAtivo;
    
    IBOutlet UITextField *textCategoria;
    IBOutlet UITextField *textDescricao;
    IBOutlet UITextField *textValorEntrada;
    IBOutlet UITextField *textValorSaida;
    IBOutlet UITextField *textQuantMinima;
    IBOutlet UITextField *textQuantMaxima;
    IBOutlet UISwitch *ativo;
    
    IBOutlet UITableView *tableView;
    
    NSArray *categorias;
    NSMutableArray *categoriasDescricao;
    UIPickerViewHelper *pickerCategorias;
    int rowCategoria;
    
    int nextProduto;
    ControllScrollView *controllScrollView;
}

@property (strong, nonatomic) ControllScrollView *controllScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic,retain) IBOutlet UITableViewCell *cellCategoria;
@property(nonatomic,retain) IBOutlet UITableViewCell *cellDescricao;
@property(nonatomic,retain) IBOutlet UITableViewCell *cellValores;
@property(nonatomic,retain) IBOutlet UITableViewCell *cellQuantidades;
@property(nonatomic,retain) IBOutlet UITableViewCell *cellAtivo;

@property(nonatomic,retain) IBOutlet UITextField *textCategoria;
@property(nonatomic,retain) IBOutlet UITextField *textDescricao;
@property(nonatomic,retain) IBOutlet UITextField *textValorEntrada;
@property(nonatomic,retain) IBOutlet UITextField *textValorSaida;
@property(nonatomic,retain) IBOutlet UITextField *textQuantMinima;
@property(nonatomic,retain) IBOutlet UITextField *textQuantMaxima;
@property(nonatomic,retain) IBOutlet UISwitch *ativo;

@property(nonatomic,retain) IBOutlet UITableView *tableView;

@property(nonatomic,retain) Produto *produto;

-(void)setNextProduto:(int)next;

@end
