//
//  FormCadastroProdutoViewController.m
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "FormCadastroProdutoViewController.h"
#import "GerenciadorBD.h"

@interface FormCadastroProdutoViewController ()

@end

@implementation FormCadastroProdutoViewController

@synthesize cellAtivo,cellValores,cellQuantidades,cellDescricao,cellCategoria,textCategoria,textDescricao,textQuantMaxima,textQuantMinima,textValorEntrada,textValorSaida,ativo,tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Novo produto"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"OK"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(novoProduto)];
    self.navigationItem.rightBarButtonItem = addButton;
    
}

- (void)carregarProduto
{
    if (self.produto)
    {
        
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)novoProduto
{
    Produto *newProduto = [GerenciadorBD getNovaInstancia:[Produto class]];
    
    [newProduto setDescricao:self.textDescricao.text];
    [newProduto setQtdeMaxima:[NSNumber numberWithInt:[self.textQuantMaxima.text intValue]]];
    [newProduto setQtdeMinima:[NSNumber numberWithInt:[self.textQuantMinima.text intValue]]];
    [newProduto setValorEntrada:[NSNumber numberWithInt:[self.textValorEntrada.text intValue]]];
    [newProduto setValorSaida:[NSNumber numberWithInt:[self.textValorSaida.text intValue]]];
    
    if ([self.ativo isOn])
    {
        [newProduto setAtivo:[NSNumber numberWithInt:1]];
    }
    else
    {
        [newProduto setAtivo:[NSNumber numberWithInt:0]];
    }
    
    [GerenciadorBD inserir:newProduto];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return cellDescricao;
    }
    if (indexPath.row == 1) {
        return cellCategoria;
    }
    if (indexPath.row == 2) {
        return cellQuantidades;
    }
    if (indexPath.row == 3) {
        return cellValores;
    }
    
    return cellAtivo;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 || indexPath.row == 3) {
        return 88;
    }
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, -200, 0);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.tableView.contentInset = edge;
    [UIView commitAnimations];
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, 200, 0);
    self.tableView.contentInset = edge;
    UITableViewCell *cell = (UITableViewCell *)[[textField superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
