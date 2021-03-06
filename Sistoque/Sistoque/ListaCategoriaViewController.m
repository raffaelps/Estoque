//
//  ListaCategoriaViewController.m
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "ListaCategoriaViewController.h"
#import "FormCadastroCategoriaViewController.h"
#import "Categoria.h"
#import "GerenciadorBD.h"

@interface ListaCategoriaViewController ()

@end

@implementation ListaCategoriaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Categorias"];
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"+"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(novaCategoria)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.view.backgroundColor = [UIColor colorWithRed:174/255.0 green:228/255.0 blue:240/255.0 alpha:1];
    
    self.tableviewCategorias.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    
    [self carregaCategorias];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [self carregaCategorias];
    //[self.tableviewCategorias reloadData];
}


- (void) carregaCategorias{
    
    categorias = [GerenciadorBD listarTodos:[Categoria class] ordenacao:@"descricao"];
    [self.tableviewCategorias reloadData];
}


- (IBAction) novaCategoria{
    
    FormCadastroCategoriaViewController *formCadastroCategoriaViewController = [[FormCadastroCategoriaViewController alloc] init];
    [self.navigationController pushViewController:formCadastroCategoriaViewController animated:YES];
}



- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"Itens da categoria %d",categorias.count);
    return categorias.count;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cacheID = @"cacheID";
    
    UITableViewCell *cell = [self.tableviewCategorias dequeueReusableCellWithIdentifier:cacheID];
    
    if(!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cacheID];
    }
    
    Categoria *categoria = [categorias objectAtIndex:indexPath.row];
    
    cell.textLabel.text = categoria.descricao;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:@"icones-menu_2.png"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Categoria *categoriaSelecionada = [categorias objectAtIndex:indexPath.row];
    FormCadastroCategoriaViewController  *tela = [[FormCadastroCategoriaViewController alloc] init];
    
    [tela setCategoria:categoriaSelecionada];
    [self.navigationController pushViewController:tela animated:YES];

}


@end
