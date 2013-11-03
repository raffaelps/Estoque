//
//  FormCadastroMovimentoViewController.h
//  Sistoque
//
//  Created by Pedro Farias Barbosa on 29/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movimento.h"
#import "Produto.h"
#import "UIDatePickerHelper.h"
#import "ControllScrollView.h"

@interface FormCadastroMovimentoViewController : UIViewController <UITextFieldDelegate, UIGestureRecognizerDelegate, UIPickerHelper>
{
    Movimento *movimento;
    Produto *produto;
    BOOL newMovimento;
    
    NSArray *categorias;
    UIDatePickerHelper *datePickerHelper;
    
     ControllScrollView *controllScrollView;
}

@property (strong, nonatomic) ControllScrollView *controllScrollView;

@property (weak, nonatomic) IBOutlet UITextField *txtNroProduto;

@property (strong, nonatomic) IBOutlet UITableViewCell *cellMovimento;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellProduto;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellDataMovimento;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellQuantidadeMovimento;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellValor;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellStatus;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellNil;
@property (weak, nonatomic) IBOutlet UITableView *tableDadosMovimentos;
@property (weak, nonatomic) IBOutlet UITextField *txtNroMovimento;



@property (retain,nonatomic) Movimento *movimento;
@property (retain,nonatomic) Produto *produto;
@property  BOOL newMovimento;
@property (weak, nonatomic) IBOutlet UITextField *txtProduto;
@property (weak, nonatomic) IBOutlet UITextField *txtDataMovimento;
@property (weak, nonatomic) IBOutlet UITextField *txtQuantMovimento;
@property (weak, nonatomic) IBOutlet UITextField *txtVlrMovimento;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segementedTipoMovimento;
@property (weak, nonatomic) IBOutlet UISwitch *switchStatus;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

-(void)setNextMovimento:(int)nextMovimento;
-(void)setProduto:(Produto *)prod;
-(void)setMovimento:(Movimento *)mov;
- (IBAction)setData:(id)sender;
@end
