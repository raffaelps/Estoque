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
#import "UIDatePickerHelper.h"
#import "SisUtil.h"
#import "UIBarButtonItemHelper.h"
#import "GerenciadorBD.h"
#import <QuartzCore/QuartzCore.h>

@interface FormCadastroMovimentoViewController ()

@end

@implementation FormCadastroMovimentoViewController

@synthesize movimento,produto,newMovimento,controllScrollView,cellStatus,cellDataMovimento,cellMovimento,cellProduto,cellQuantidadeMovimento,cellTipo,cellValor,tableView;

id elementFocus;

static NSMutableArray *listaCellMovimento;

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
    
    self.title = @"Movimentações";
    
    listaCellMovimento = [[NSMutableArray alloc]init];
    [self generateListaCells];
    
    [self delegaCampos];
    [self adicionaBotaoOk];
    [self defineReconhecedorToque];
    
    self.view.backgroundColor = [UIColor colorWithRed:174/255.0 green:228/255.0 blue:240/255.0 alpha:1];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)validaFields
{
    BOOL numeroMovimentoVazio = [SisUtil verificaTextoVazioOuNulo:_txtNroMovimento.text];
    BOOL produtoVazio = [SisUtil verificaTextoVazioOuNulo:_txtProduto.text];
    BOOL dataMovimentoVazio = [SisUtil verificaTextoVazioOuNulo:_txtDataMovimento.text];
    BOOL quantidadeMovimentoVazio = [SisUtil verificaTextoVazioOuNulo:_txtQuantMovimento.text];
    BOOL quantidadeValorVazio = [SisUtil verificaTextoVazioOuNulo:_txtVlrMovimento.text];
    
    if(numeroMovimentoVazio||
       produtoVazio||
       dataMovimentoVazio||
       quantidadeMovimentoVazio||
       quantidadeValorVazio)
        return FALSE;
    return TRUE;
}

-(void)defineReconhecedorToque{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [_scrollView addGestureRecognizer:gestureRecognizer];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    controllScrollView = [[ControllScrollView alloc]init];
    [controllScrollView setSvos:_scrollView];
    
    if(movimento != nil)
    {
        NSString *data = [SisUtil dateToString:movimento.data withMask:@"dd-MM-yyyy"];
        
        newMovimento = FALSE;
        
        [_txtNroMovimento setText:[NSString stringWithFormat:@"%@",movimento.id]];
        _txtDataMovimento.text = [NSString stringWithFormat:@"%@", data];
        _txtNroMovimento.text = [NSString stringWithFormat:@"%@",movimento.id];
        _txtQuantMovimento.text = [NSString stringWithFormat:@"%d",[movimento.qtde intValue]];
        _txtVlrMovimento.text = [NSString stringWithFormat:@"%d",[movimento.valor intValue]];
        
        BOOL movimentoAtivo = ([movimento.ativo intValue]==0?YES:NO);
        [_switchStatus setOn:movimentoAtivo animated:YES];
        
        int movimentoEntrada = ([movimento.tipo isEqual:@"Entrada"]?0:1);
        _segementedTipoMovimento.selectedSegmentIndex = movimentoEntrada;
    }
    else
    {
        newMovimento = TRUE;
        movimento = (Movimento*)[GerenciadorBD getNovaInstancia:[Movimento class]];
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
        if (textField == _txtQuantMovimento) {
            [_txtVlrMovimento becomeFirstResponder];
            return YES;
        }
    }
    
    return NO;
}

//Verifica se o Field pode começar a editar.
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == _txtDataMovimento){
        [self setData:textField];
        return NO;
    }
    return YES;
}

- (IBAction)btnAddMovimento {
    
    if([self validaFields])
    {
        NSNumber *numeroMovimento = [SisUtil stringToInt:_txtNroMovimento.text];
        NSString *tipoMovimento = [_segementedTipoMovimento titleForSegmentAtIndex:_segementedTipoMovimento.selectedSegmentIndex];
        NSDate *data = [SisUtil stringToDate:_txtDataMovimento.text withMask:@"dd-MM-yyyy"];
        NSNumber *quantidadeMovimento = [SisUtil stringToInt:_txtQuantMovimento.text];
        NSNumber *valorMovimento = [SisUtil stringToInt: _txtVlrMovimento.text];
        int switchValue = (_switchStatus.isOn?0:1);
        NSNumber *ativo = [[NSNumber alloc] initWithInt:switchValue];
        
        [movimento setId:numeroMovimento];
        [movimento setIdProduto:produto.id];
        [movimento setTipo:tipoMovimento];
        [movimento setData:data];
        [movimento setQtde:quantidadeMovimento];
        [movimento setValor:valorMovimento];
        [movimento setAtivo:ativo];
        
        if (newMovimento)
            [GerenciadorBD inserir:movimento];
        else
            [GerenciadorBD salvar:movimento];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self exibeAlertaErro];
    }
}

-(void)setNextMovimento:(int)nextMovimento
{
    _txtNroMovimento.text = [NSString stringWithFormat:@"%d",nextMovimento];
}

-(void)setProduto:(Produto *)prod
{
    produto = prod;
    _txtNroProduto.text = [NSString stringWithFormat:@"%@",produto.id];
    _txtProduto.text = produto.descricao;
}

- (IBAction)setData:(id)sender {
    
    datePickerHelper = [[UIDatePickerHelper alloc] initWithView:self.view];
    //Delegando para si próprio a responsabilidade do DatePickerHelper
    datePickerHelper.delegate = self;
    
    [datePickerHelper showDatePicker];
    
}

//Função de retorno do Delegate
-(void) getPickerValue:(NSDate *)date{
    if(date == nil)
        date = [NSDate date];
    _txtDataMovimento.text = [SisUtil dateToString:date withMask:@"dd-MM-yyyy"];
}

-(void)exibeAlertaErro{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Campos Inválidos!" message:@"Favor preencher todos os campos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

-(void)delegaCampos{
    _txtProduto.delegate = self;
    _txtDataMovimento.delegate = self;
    _txtQuantMovimento.delegate = self;
    _txtVlrMovimento.delegate = self;
}

-(void)adicionaBotaoOk{
    NSString *title = @"OK";
    UIBarButtonItemStyle style = UIBarButtonItemStyleBordered;
    id target = self;
    SEL selector = @selector(btnAddMovimento);
    
    UIBarButtonItemHelper *btnHelper = [[UIBarButtonItemHelper alloc] initWithTitle:title andStyle:style andTarget:target andSelector:&selector];
    
    UIBarButtonItem *btnSalvar = [btnHelper createBarButtonItemHelper];
    self.navigationItem.rightBarButtonItem = btnSalvar;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listaCellMovimento.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [listaCellMovimento objectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[listaCellMovimento objectAtIndex:indexPath.row] isEqual:cellProduto])
    {
        return 88;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)generateListaCells
{
    [listaCellMovimento addObject:cellTipo];
    [listaCellMovimento addObject:cellMovimento];
    [listaCellMovimento addObject:cellProduto];
    [listaCellMovimento addObject:cellDataMovimento];
    [listaCellMovimento addObject:cellQuantidadeMovimento];
    [listaCellMovimento addObject:cellValor];
    [listaCellMovimento addObject:cellStatus];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    elementFocus = textField;
    
    [controllScrollView sobeTela:textField scrollView:_scrollView fieldPosition:[textField convertPoint:textField.bounds.origin fromView:self.view] deviceSize:self.view.bounds.size];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    elementFocus = textView;
    
    [controllScrollView sobeTela:textView scrollView:_scrollView fieldPosition:[textView convertPoint:textView.bounds.origin fromView:self.view] deviceSize:self.view.bounds.size];
}

-(void)hideKeyBoard
{
    [controllScrollView hideKeyBoard:elementFocus scrollView:_scrollView navigationControllerHidden:NO];
}

@end