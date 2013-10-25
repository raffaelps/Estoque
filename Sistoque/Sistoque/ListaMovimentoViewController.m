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
    
    [addButton setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica-Bold" size:24.0f],UITextAttributeFont,nil] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = addButton;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listaMovimentosProduto count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellMovimentos";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (listaMovimentosProduto.count > 0) {
        Movimento *m = [listaMovimentosProduto objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@ - %@",m.idProduto,produto.descricao,[dateFormatter stringFromDate:m.data]];
        
    }
    return cell;
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
