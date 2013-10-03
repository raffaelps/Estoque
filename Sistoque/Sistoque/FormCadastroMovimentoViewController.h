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

@interface FormCadastroMovimentoViewController : UIViewController <UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    Movimento *movimento;
    Produto *produto;
    BOOL newMovimento;
}

@property (retain,nonatomic) Movimento *movimento;
@property (retain,nonatomic) Produto *produto;
@property  BOOL newMovimento;
@property (weak, nonatomic) IBOutlet UILabel *labelNroMovimento;
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
@end
