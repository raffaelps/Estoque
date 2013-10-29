//
//  ListaMovimentoViewController.m
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "ListaMovimentoViewController.h"
#import "FormCadastroMovimentoViewController.h"
#import "GerenciadorBD.h"
#import "CellMovimentos.h"
#import "Movimento.h"
#import "Produto.h"

@interface ListaMovimentoViewController ()

@end

@implementation ListaMovimentoViewController
@synthesize produto;

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]];
    self.tableMovimentos.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    [self gerarLista];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self gerarLista];
    [self.tableMovimentos reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"+"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(btnAddMovimento:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listaMovimentosProduto count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    static NSString *CellIdentifier = @"CellMovimentos";
    
     CellMovimentos *cellTopo = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellTopo == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CellMovimentos" owner:nil options:nil];
        
        for (id currenctObject in topLevelObjects)
        {
            if ([currenctObject isKindOfClass:[UITableViewCell class]])
            {
                cellTopo = (CellMovimentos *) currenctObject;
            }
        }
    }
    
    Movimento *m = [listaMovimentosProduto objectAtIndex:indexPath.row];
    
    cellTopo.movimento.text = [NSString stringWithFormat:@"%@",m.id];;
    cellTopo.produto.text = produto.descricao;
    cellTopo.data.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:m.data]];
    cellTopo.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cellTopo;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FormCadastroMovimentoViewController *formMovimento = [FormCadastroMovimentoViewController alloc];
    
    Movimento *movimento =  [listaMovimentosProduto objectAtIndex:indexPath.row];
    
    [formMovimento setMovimento:movimento];
    
    [self.navigationController pushViewController:formMovimento animated:YES];
    
    [formMovimento setProduto:produto];
}
-(void)gerarLista
{
    listaAllMovimentos = [GerenciadorBD listarTodos:[Movimento class] ordenacao:@"id"];
    
    listaMovimentosProduto = [[NSMutableArray alloc]init];
    
    for (Movimento *mov in listaAllMovimentos) {
        if([mov.idProduto isEqualToNumber:produto.id])
            [listaMovimentosProduto addObject:mov];
    }
}

-(void)setProduto:(Produto *)prod
{
    produto = prod;
}

-(void)btnAddMovimento:(UIBarButtonItem*)sender {
    
    FormCadastroMovimentoViewController *formMovimento = [FormCadastroMovimentoViewController alloc];
    
    
    [self.navigationController pushViewController:formMovimento animated:YES];
    
    [formMovimento setProduto:produto];
    [formMovimento setNextMovimento:listaAllMovimentos.count + 1];
}

@end
