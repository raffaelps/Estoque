//
//  FormCadastroProdutoViewController.m
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "FormCadastroProdutoViewController.h"

@interface FormCadastroProdutoViewController ()

@end

@implementation FormCadastroProdutoViewController

@synthesize cellAtivo,cellValores,cellQuantidades,cellDescricao,cellCategoria,cellNome,textCategoria,textDescricao,textNome,textQuantMaxima,textQuantMinima,textValorEntrada,textValorSaida,ativo,tableView;

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
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return cellNome;
    }
    if (indexPath.row == 1) {
        return cellCategoria;
    }
    if (indexPath.row == 2) {
        return cellDescricao;
    }
    if (indexPath.row == 3) {
        return cellQuantidades;
    }
    if (indexPath.row == 4) {
        return cellValores;
    }
    
    return cellAtivo;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3 || indexPath.row == 4) {
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
