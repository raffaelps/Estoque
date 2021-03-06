//
//  ListaRelatorioViewController.m
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "ListaRelatorioViewController.h"
#import "RelatorioEntradaSaidaMesViewController.h"

@interface ListaRelatorioViewController ()

@end

@implementation ListaRelatorioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Relatórios";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:174/255.0 green:228/255.0 blue:240/255.0 alpha:1];
    
    tabela.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CelulaPrincipalCacheID = @"CelulaPrincipalCacheID";
	UITableViewCell *cell = [tabela dequeueReusableCellWithIdentifier:CelulaPrincipalCacheID];
    
	if (!cell) {
		cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CelulaPrincipalCacheID];
	}
	
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Saídas por mês";
            break;
        case 1:
            cell.textLabel.text = @"Entradas por mês";
            break;
        default:
            break;
    }
    
    cell.textLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        RelatorioEntradaSaidaMesViewController *relatorioView = [[RelatorioEntradaSaidaMesViewController alloc] init];
        relatorioView.tipo = @"Saida";
        [self.navigationController pushViewController:relatorioView animated:YES];
    }
    else if (indexPath.row == 1)
    {
        RelatorioEntradaSaidaMesViewController *relatorioView = [[RelatorioEntradaSaidaMesViewController alloc] init];
        relatorioView.tipo = @"Entrada";
        [self.navigationController pushViewController:relatorioView animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

@end
