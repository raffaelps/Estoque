//
//  FormCadastroMovimentoViewController.m
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "FormCadastroMovimentoViewController.h"

@interface FormCadastroMovimentoViewController ()

@end

@implementation FormCadastroMovimentoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)validaFields
{
    if(_labelNroMovimento.text == nil)
        return FALSE;
    if(_textProduto.text == nil)
        return FALSE;
    if(_textDataMovimento.text == nil)
        return FALSE;
    if(_vlrMovimento.text == nil)
        return FALSE;
    if(_qtdMovimento.text == nil)
        return FALSE;
    
    return TRUE;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    if([self validaFields])
    {
        NSString *idMovimento = _labelNroMovimento.text;
        NSString *idProdudo = _textProduto.text;
        NSString *tipo = [_segmentedTipoMovimento titleForSegmentAtIndex:_segmentedTipoMovimento.selectedSegmentIndex];
        NSString *dataMovimento = _textDataMovimento.text;
        NSString *qtd = _qtdMovimento.text;
        NSString *vlrMovimento = _vlrMovimento.text;
        BOOL status = _switchStatus.selected;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Campos Inválidos!" message:@"Favor preencher todos os campos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

-(void)setNextMovimento:(int)nextMovimento
{
    _labelNroMovimento.text = [NSString stringWithFormat:@"%d",nextMovimento];
}

-(void)setProduto:(id)produto
{
    //_textProduto.text = [NSString stringWithFormat:@"%d - %@",];
}

@end
