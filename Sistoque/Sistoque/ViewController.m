//
//  ViewController.m
//  Sistoque
//
//  Created by Raffael Patrício de Souza on 27/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "ViewController.h"
#import "ListaProdutosViewController.h"
#import "ListaCategoriaViewController.h"
#import "ListaRelatorioViewController.h"
#import "Principal.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"SISTOQUE"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadMenu];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]];

    
    self.tabelaPrincipal.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];

    /*headerLabel.text = NSLocalizedString(@"Header for the table", @"");
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.shadowColor = [UIColor blackColor];
    headerLabel.shadowOffset = CGSizeMake(0, 1);
    headerLabel.font = [UIFont boldSystemFontOfSize:22];
    headerLabel.backgroundColor = [UIColor clearColor];
    [containerView addSubview:headerLabel];
    self.tabelaPrincipal.tableHeaderView = containerView;
    */
    //self.tabelaPrincipal.layer.borderColor = [UIColor colorWithRed:0.0 green:0.0 blue:255.0 alpha:1].CGColor;
    self.tabelaPrincipal.layer.borderColor = [UIColor whiteColor].CGColor;
    self.tabelaPrincipal.layer.borderWidth = 2;
    self.tabelaPrincipal.layer.cornerRadius = 10;
    self.tabelaPrincipal.layer.masksToBounds = YES;
}

-(void) loadMenu {
    
    NSString *plistCaminho = [[NSBundle mainBundle]
            pathForResource:@"principal"  ofType:@"plist"];
    NSDictionary *pl = [NSDictionary
                        dictionaryWithContentsOfFile:plistCaminho];
    NSArray *dados = [pl objectForKey:@"menu"];
    menu = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in dados) {
        NSString *nome = [item objectForKey:@"nome"];
        Principal *c = [[Principal alloc] initWithMenu:nome];
        [menu addObject:c];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnProduto:(id)sender {
    ListaProdutosViewController  *tela = [[ListaProdutosViewController alloc] init];
    [self.navigationController pushViewController:tela animated:YES];
}

- (IBAction)btnCategoria:(id)sender {
    ListaCategoriaViewController  *tela = [[ListaCategoriaViewController alloc] init];
    [self.navigationController pushViewController:tela animated:YES];
}

- (IBAction)btnRelatorio:(id)sender {
    ListaRelatorioViewController  *tela = [[ListaRelatorioViewController alloc] init];
    [self.navigationController pushViewController:tela animated:YES];

}


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"Menu count: %d", menu.count);
    return menu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CelulaPrincipalCacheID = @"CelulaPrincipalCacheID";
	UITableViewCell *cell = [self.tabelaPrincipal dequeueReusableCellWithIdentifier:CelulaPrincipalCacheID];
    
	if (!cell) {
		cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:CelulaPrincipalCacheID];
	}
	
	Principal *principal = [menu objectAtIndex:indexPath.row];
    
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text = principal.itemMenu;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tabelaPrincipal deselectRowAtIndexPath:indexPath animated:YES];
    ViewController *tela;
    
    switch (indexPath.row) {
        case 0:
            tela = [[ListaProdutosViewController alloc] init];
            [self.navigationController pushViewController:tela animated:YES];
            break;
        case 1:
            tela = [[ListaCategoriaViewController alloc] init];
            [self.navigationController pushViewController:tela animated:YES];
            NSLog(@"sou a categoria");
            break;
        default:
            tela = [[ListaRelatorioViewController alloc] init];
            [self.navigationController pushViewController:tela animated:YES];
            NSLog(@"sou o relatório");
            break;

    }
    
}

@end
