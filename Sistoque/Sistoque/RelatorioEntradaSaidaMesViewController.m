//
//  RelatorioEntradaSaidaMesViewController.m
//  Sistoque
//
//  Created by Raffael Patrício de Souza on 07/11/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "RelatorioEntradaSaidaMesViewController.h"
#import "CellRelatorioProduto.h"
#import "GerenciadorBD.h"
#import "Produto.h"
#import "Movimento.h"
#import "MesesRelatorio.h"
#import "ProdutoRelatorio.h"

@interface RelatorioEntradaSaidaMesViewController ()

@end

@implementation RelatorioEntradaSaidaMesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [self.tipo rangeOfString:@"Entrada"].location == NSNotFound ? @"Saídas por mês" : @"Entradas por mês";
    
    listaProdutos = [GerenciadorBD listarTodos:[Produto class] ordenacao:@"descricao"];
    listaMovimentacoes = [GerenciadorBD listarPropriedades:[Movimento class] comPropriedades:nil eFiltro:[NSString stringWithFormat:@"tipo = '%@'",self.tipo] eOrdem:@"data"];
    
    listaMeses = [[NSMutableArray alloc]init];
    
    //Criei mais tá péssimo isso kkkkkkkkkkk
    for (Movimento *item in listaMovimentacoes) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:item.data];
        
        MesesRelatorio *novo = [[MesesRelatorio alloc]init];
        novo.mes = [components month];
        novo.ano = [components year];
        novo.produtos = [[NSMutableArray alloc]init];
        
        if ([listaMeses count] > 0)
        {
            BOOL existe = false;
            
            for (MesesRelatorio *item2 in listaMeses) {
                if (item2.mes == novo.mes && item2.ano == novo.ano)
                {
                    existe = true;
                }
            }
            
            if (!existe)
            {
                [listaMeses addObject:novo];
            }
        }
        else
        {
            [listaMeses addObject:novo];
        }
    }
    
    for (MesesRelatorio *item in listaMeses) {
    
        for (Movimento *movimento in listaMovimentacoes)
        {
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:movimento.data];
            
            MesesRelatorio *novoMovimento = [[MesesRelatorio alloc]init];
            novoMovimento.mes = [components month];
            novoMovimento.ano = [components year];
            
            if (item.mes == novoMovimento.mes && item.ano == novoMovimento.ano)
            {
                for (ProdutoRelatorio *produto in item.produtos)
                {
                    if (produto.id == movimento.idProduto)
                    {
                        produto.valor = [NSNumber numberWithFloat:([movimento.valor floatValue] + [produto.valor floatValue])];
                        produto.qtde = [NSNumber numberWithFloat:([movimento.qtde floatValue] + [produto.qtde floatValue])];
                    }
                    else
                    {
                        ProdutoRelatorio *produto = [[ProdutoRelatorio alloc]init];
                        produto.id = movimento.idProduto;
                        produto.valor = movimento.valor;
                        produto.qtde = movimento.qtde;
                        
                        NSArray *produtoUnico = [listaProdutos filteredArrayUsingPredicate:[NSPredicate
                                                              predicateWithFormat:@"id == %@", movimento.idProduto]];
                        
                        if (produtoUnico.count > 0)
                        {
                            Produto *p = [produtoUnico objectAtIndex:0];
                            produto.nome = p.descricao;
                        }
                        
                        [item.produtos addObject:produto];
                    }
                }
                
                if (item.produtos.count == 0) {
                    ProdutoRelatorio *produto = [[ProdutoRelatorio alloc]init];
                    produto.id = movimento.id;
                    produto.valor = movimento.valor;
                    produto.qtde = movimento.qtde;
                    
                    NSArray *produtoUnico = [listaProdutos filteredArrayUsingPredicate:[NSPredicate
                                                                                        predicateWithFormat:@"id == %@", movimento.idProduto]];
                    
                    if (produtoUnico.count > 0)
                    {
                        Produto *p = [produtoUnico objectAtIndex:0];
                        produto.nome = p.descricao;
                    }
                    
                    [item.produtos addObject:produto];
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return listaMeses.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MesesRelatorio *aux = [listaMeses objectAtIndex:section];
    return aux.produtos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellRelatorioProduto";
    
    CellRelatorioProduto *cellTopo = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellTopo == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CellRelatorioProduto" owner:nil options:nil];
        
        for (id currenctObject in topLevelObjects)
        {
            if ([currenctObject isKindOfClass:[UITableViewCell class]])
            {
                cellTopo = (CellRelatorioProduto *) currenctObject;
            }
        }
    }
    
    MesesRelatorio *obj = [listaMeses objectAtIndex:indexPath.section];
    ProdutoRelatorio *produto = [obj.produtos objectAtIndex:indexPath.row];
    
    cellTopo.nomeProduto.text = produto.nome;
    cellTopo.valorProduto.text = [NSString stringWithFormat:@"%@",produto.valor];
    cellTopo.saidaProduto.text = [NSString stringWithFormat:@"%@",produto.qtde];
    
    return cellTopo;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MesesRelatorio *aux = [listaMeses objectAtIndex:section];
    return [NSString stringWithFormat:@"%d/%d",aux.mes,aux.ano];
}

@end
