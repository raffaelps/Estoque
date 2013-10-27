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
#import <QuartzCore/QuartzCore.h>

@interface FormCadastroMovimentoViewController ()

@end

@implementation FormCadastroMovimentoViewController
@synthesize movimento,produto,newMovimento;

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

    UIBarButtonItem *addButtonSalvar = [[UIBarButtonItem alloc]
                                        initWithTitle:@"OK"
                                        style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(btnAddMovimento)];
    self.navigationItem.rightBarButtonItem = addButtonSalvar;
    
    listaCellMovimento = [[NSMutableArray alloc]init];
    [self generateListaCells];
    
    
    self.view.userInteractionEnabled = YES;

    
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
    if(_txtNroMovimento.text == nil)
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
        
        _txtNroMovimento.text = [NSString stringWithFormat:@"%@",movimento.id];
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
        
        
        [movimento setId:[[NSNumber alloc] initWithUnsignedInt:[_txtNroMovimento.text intValue]]];
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
-(void) getDatePickerDate:(NSDate *)date{
    if(date != nil){
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-yyyy"];
        _txtDataMovimento.text = [dateFormat stringFromDate:date];
     }
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
    if([[listaCellMovimento objectAtIndex:indexPath.row] isEqual:_cellProduto])
    {
        return 88;
    }
    return 44;
}

-(void)generateListaCells
{
    CALayer *layer = _cellNil.layer;
    layer.borderWidth = 0;
    
    [listaCellMovimento addObject:_cellMovimento];
    [listaCellMovimento addObject:_cellProduto];
    [listaCellMovimento addObject:_cellDataMovimento];
    [listaCellMovimento addObject:_cellQuantidadeMovimento];
    [listaCellMovimento addObject:_cellValor];
    [listaCellMovimento addObject:_cellStatus];
    [listaCellMovimento addObject:_cellNil];
    [listaCellMovimento addObject:_cellNil];
    [listaCellMovimento addObject:_cellNil];
}

@end
