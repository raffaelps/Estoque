//
//  ListaProdutosViewController.m
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "ListaProdutosViewController.h"
#import "FormCadastroProdutoViewController.h"
#import "ListaMovimentoViewController.h"
#import "CellProdutos.h"
#import "Produto.h"
#import "GerenciadorBD.h"

@interface ListaProdutosViewController ()

@end

@implementation ListaProdutosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Produtos"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:174/255.0 green:228/255.0 blue:240/255.0 alpha:1];
    
    self.tabela.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"+"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(novoProduto)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidAppear:(BOOL)animated
{
    listaProdutos = [GerenciadorBD listarTodos:[Produto class] ordenacao:@"descricao"];
    [self.tabela reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)novoProduto
{
    FormCadastroProdutoViewController *cadastroProdutoViewController = [[FormCadastroProdutoViewController alloc] init];
    [self.navigationController pushViewController:cadastroProdutoViewController animated:YES];
    
    int next = listaProdutos.count + 1;
    [cadastroProdutoViewController setNextProduto:next];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listaProdutos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellProdutos";
    
    CellProdutos *cellTopo = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellTopo == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CellProdutos" owner:nil options:nil];
        
        for (id currenctObject in topLevelObjects)
        {
            if ([currenctObject isKindOfClass:[UITableViewCell class]])
            {
                cellTopo = (CellProdutos *) currenctObject;
            }
        }
    }
    
    Produto *p = [listaProdutos objectAtIndex:indexPath.row];
    
    cellTopo.nomeProduto.text = p.descricao;
    //cellTopo.nomeCategoria.text = p.idCategoria;
    cellTopo.quantMaxima.text = [NSString stringWithFormat:@"%@",p.qtdeMaxima];
    cellTopo.quantMin.text = [NSString stringWithFormat:@"%@",p.qtdeMinima];
    //cellTopo.quantEstoque.text = p.quantEstoque;
    cellTopo.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cellTopo;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListaMovimentoViewController *movimentos = [[ListaMovimentoViewController alloc]init];
    movimentos.produto = [listaProdutos objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:movimentos animated:YES];
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

@end
