//
//  ViewController.m
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "ViewController.h"
#import "ListaProdutosViewController.h"
#import "ListaCategoriaViewController.h"
#import "ListaRelatorioViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)abrirJanela:(UIViewController *)tela {
    tela.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:tela animated:YES];
    
}

- (IBAction)btnProduto:(id)sender {
    ListaProdutosViewController  *tela = [[ListaProdutosViewController alloc] init];
    [self abrirJanela:tela];
}

- (IBAction)btnCategoria:(id)sender {
    ListaCategoriaViewController  *tela = [[ListaCategoriaViewController alloc] init];
    [self abrirJanela:tela];
}

- (IBAction)btnRelatorio:(id)sender {
    ListaRelatorioViewController  *tela = [[ListaRelatorioViewController alloc] init];
    [self abrirJanela:tela];
}
@end
