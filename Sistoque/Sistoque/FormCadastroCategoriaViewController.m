//
//  FormCadastroCategoriaViewController.m
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "FormCadastroCategoriaViewController.h"
#import "GerenciadorBD.h"
#import "Categoria.h"

@interface FormCadastroCategoriaViewController ()

@end

@implementation FormCadastroCategoriaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         [self setTitle:@"Nova categoria"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *addButtonSalvar = [[UIBarButtonItem alloc]
                                  initWithTitle:@"OK"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(salvaNovaCategoria)];
    self.navigationItem.rightBarButtonItem = addButtonSalvar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)salvaNovaCategoria {
    
    Categoria *novaCategoria = [GerenciadorBD getNovaInstancia:[Categoria class]];
    
    [novaCategoria setDescricao:self.textfieldDescricaoCategoria.text];
    
    if ([self.switchStatusCategoria isOn])
    {
        [novaCategoria setAtivo:[NSNumber numberWithInt:1]];
    }
    else
    {
        [novaCategoria setAtivo:[NSNumber numberWithInt:0]];
    }
    
    [GerenciadorBD inserir:novaCategoria];

    [self.navigationController  popViewControllerAnimated:YES];
}

@end
