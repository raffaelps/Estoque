//
//  FormCadastroMovimentoViewController.m
//  Sistoque
//
//  Created by Pedro Farias Barbosa on 29/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "FormCadastroMovimentoViewController.h"
#import "Movimento.h"
#import "Produto.h"
#import "GerenciadorBD.h"

@interface FormCadastroMovimentoViewController ()

@end

@implementation FormCadastroMovimentoViewController
@synthesize movimento,produto,newMovimento;

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

    UIBarButtonItem *addButtonSalvar = [[UIBarButtonItem alloc]
                                        initWithTitle:@"OK"
                                        style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(btnAddMovimento)];
    self.navigationItem.rightBarButtonItem = addButtonSalvar;
    
    self.view.userInteractionEnabled = YES;
    
    _txtProduto.delegate = self;
    _txtDataMovimento.delegate = self;
    _txtQuantMovimento.delegate = self;
    _txtVlrMovimento.delegate = self;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    gestureRecognizer.delegate = self;
    [_scrollView addGestureRecognizer:gestureRecognizer];
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
    if(_txtProduto.text == nil)
        return FALSE;
    if(_txtDataMovimento.text == nil)
        return FALSE;
    if(_txtQuantMovimento.text == nil)
        return FALSE;
    if(_txtVlrMovimento.text == nil)
        return FALSE;
    
    return TRUE;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    if(movimento != nil)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        
        newMovimento = FALSE;
        
        [_labelNroMovimento setText:[NSString stringWithFormat:@"%@",movimento.id]];
        _txtDataMovimento.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:movimento.data]];
        _txtQuantMovimento.text = [NSString stringWithFormat:@"%d",[movimento.qtde intValue]];
        _txtVlrMovimento.text = [NSString stringWithFormat:@"%d",[movimento.valor intValue]];
        
        if([movimento.ativo intValue] == 0)
            [_switchStatus setOn:YES animated:YES];
        else
            [_switchStatus setOn:NO animated:YES];
        
        if([movimento.tipo isEqual:@"Entrada"])
            _segementedTipoMovimento.selectedSegmentIndex = 0;
        else
            _segementedTipoMovimento.selectedSegmentIndex = 1;
    }
    else
    {
        newMovimento = TRUE;
        movimento = [GerenciadorBD getNovaInstancia:[Movimento class]];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _txtProduto) {
        [_txtDataMovimento becomeFirstResponder];
        return YES;
    }
    else
    {
        if (textField == _txtDataMovimento)
        {
            [_txtQuantMovimento becomeFirstResponder];
            return YES;
        }
        else
        {
            if (textField == _txtQuantMovimento) {
                [_txtVlrMovimento becomeFirstResponder];
                return YES;
            }
        }
    }
    
    return NO;
}

-(void) hideKeyBoard:(id) sender
{
    [_txtProduto resignFirstResponder];
    [_txtDataMovimento resignFirstResponder];
    [_txtQuantMovimento resignFirstResponder];
    [_txtVlrMovimento resignFirstResponder];
}

- (IBAction)btnAddMovimento {
    
    if([self validaFields])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        
        NSString *dataString = [NSString stringWithFormat:@"%@",_txtDataMovimento.text];
        
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:dataString];
        
        
        [movimento setId:[[NSNumber alloc] initWithUnsignedInt:[_labelNroMovimento.text intValue]]];
        [movimento setIdProduto:produto.id];
        
        [movimento setTipo:[_segementedTipoMovimento titleForSegmentAtIndex:_segementedTipoMovimento.selectedSegmentIndex]];
        
        [movimento setData:dateFromString];
        
        [movimento setQtde:[[NSNumber alloc] initWithUnsignedInt:[_txtQuantMovimento.text intValue]] ];
        [movimento setValor:[[NSNumber alloc] initWithUnsignedInt:[_txtVlrMovimento.text intValue]]];
        
        int switchValue = 1;
        
        if (_switchStatus.isOn)
            switchValue = 0;

        [movimento setAtivo:[[NSNumber alloc] initWithInt:switchValue]];
        
        
        if (newMovimento)
            [GerenciadorBD inserir:movimento];
        else
            [GerenciadorBD salvar:movimento];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Campos Inválidos!" message:@"Favor preencher todos os campos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

- (IBAction)btnCancelMovimento:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setNextMovimento:(int)nextMovimento
{
    [_labelNroMovimento setText:[NSString stringWithFormat:@"%d",nextMovimento]];
}

-(void)setProduto:(Produto *)prod
{
    produto = prod;
    _txtProduto.text = [NSString stringWithFormat:@"%@ - %@",produto.id,produto.descricao];
}

@end
