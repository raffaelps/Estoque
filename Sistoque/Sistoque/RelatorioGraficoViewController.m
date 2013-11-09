//
//  RelatorioGraficoViewController.m
//  Sistoque
//
//  Created by Raffael Patrício de Souza on 08/11/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "RelatorioGraficoViewController.h"
#import "NQBarGraph.h"
#import "NQData.h"
#import "GerenciadorBD.h"
#import "Movimento.h"
#import "MesesRelatorio.h"
#import "ProdutoRelatorio.h"

@interface RelatorioGraficoViewController ()

@end

@implementation RelatorioGraficoViewController

@synthesize listaMeses;

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
    
    self.title = [self.tipo rangeOfString:@"Entrada"].location == NSNotFound ? @"Saídas por mês" : @"Entradas por mês";
    
    NQBarGraph * barGraph=[[NQBarGraph alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20, self.view.bounds.size.height-20)];
    barGraph.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    [self.view addSubview:barGraph];
    NSMutableArray * dataArray=[NSMutableArray array];
    
    [self prepararDados];
    
    NSNumber *maiorValor = 0;
    
    for (MesesRelatorio *mesRelatorio in listaMeses) {
        
        ProdutoRelatorio *produto = [mesRelatorio.produtos objectAtIndex:0];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-01 01:01:01",mesRelatorio.ano,mesRelatorio.mes]];
        
        NQData * data=[NQData dataWithDate:date andNumber:produto.valor];
        [dataArray addObject:data];
        
        if ([maiorValor intValue] < [produto.valor intValue])
            maiorValor = produto.valor;
    }
    
    barGraph.numberOfVerticalElements = [maiorValor intValue];
    barGraph.dataSource = dataArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepararDados
{
    NSArray *listaMovimentacoes = [GerenciadorBD listarPropriedades:[Movimento class] comPropriedades:nil eFiltro:[NSString stringWithFormat:@"tipo = '%@'",self.tipo] eOrdem:@"data" eAscending:FALSE];
    
    listaMeses = [[NSMutableArray alloc]init];
    
    for (Movimento *item in listaMovimentacoes) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:item.data];
        
        MesesRelatorio *novo = [[MesesRelatorio alloc]init];
        novo.mes = [components month];
        novo.ano = [components year];
        novo.produtos = [[NSMutableArray alloc]init];
        
        
        NSArray *mesUnico = [listaMeses filteredArrayUsingPredicate:[NSPredicate
                                                                     predicateWithFormat:@"mes == %d && ano == %d", novo.mes,novo.ano]];
        
        if (mesUnico.count <= 0)
        {
            [listaMeses addObject:novo];
        }
    }
    
    NSMutableArray *produtosMes = [[NSMutableArray alloc] init];
    
    for (MesesRelatorio *item in listaMeses) {
        
        [produtosMes removeAllObjects];
        
        ProdutoRelatorio *produto = [[ProdutoRelatorio alloc]init];
        
        for (Movimento *movimento in listaMovimentacoes)
        {
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:movimento.data];
            
            MesesRelatorio *novoMovimento = [[MesesRelatorio alloc]init];
            novoMovimento.mes = [components month];
            novoMovimento.ano = [components year];
            
            if (item.mes == novoMovimento.mes && item.ano == novoMovimento.ano)
            {
                produto.id = movimento.idProduto;
                produto.valor = [NSNumber numberWithFloat:([movimento.valor floatValue] + [produto.valor floatValue])];
                produto.qtde = [NSNumber numberWithFloat:([movimento.qtde floatValue] + [produto.qtde floatValue])];
            }
        }
        
        [produtosMes addObject:produto];
        
        [item.produtos addObjectsFromArray:produtosMes];
    }
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
