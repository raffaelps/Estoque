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
#import "UIBarButtonItemHelper.h"
#import "SisUtil.h"

@interface FormCadastroCategoriaViewController ()

@end

@implementation FormCadastroCategoriaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)setCategoria:(Categoria *)categoria {
    categoriaSelect = categoria;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:174/255.0 green:228/255.0 blue:240/255.0 alpha:1];
    
    tabela.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    if(categoriaSelect.id > 0){
        //NSLog(@"Object do tipo categoria encontrado");
        [self setTitle:@"Edita categoria"];
        novaCategoria = NO;
        self.textfieldDescricaoCategoria.text = categoriaSelect.descricao;
        NSNumber *number = [NSNumber numberWithInteger: 1];
        if(categoriaSelect.ativo == number){
            self.switchStatusCategoria.on = TRUE;
        }
        else{
            self.switchStatusCategoria.on = FALSE;
        }
    }
    else {
        [self setTitle:@"Nova categoria"];
        categoriaSelect = (Categoria*)[GerenciadorBD getNovaInstancia:[Categoria class]];
        novaCategoria = YES;
    }
    
    UIBarButtonItem *addButtonSalvar = [[UIBarButtonItem alloc]
                                        initWithTitle:@"OK"
                                        style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(salvaCategoria)];
    self.navigationItem.rightBarButtonItem = addButtonSalvar;
    
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
	if (indexPath.row == 0)
    {
        return cellDescricao;
    }
    else
    {
        return cellStatus;
    }
}

- (IBAction)salvaCategoria {
    
    NSString *desc = self.textfieldDescricaoCategoria.text;
    
    desc = [desc stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //if(desc != nil && [desc length] > 0 && ![desc isEqualToString: @""] ){
    if(![SisUtil verificaTextoVazioOuNulo:desc]){
        [categoriaSelect setDescricao: desc];
        
        if ([self.switchStatusCategoria isOn]){
            [categoriaSelect setAtivo:[NSNumber numberWithInt:1]];
        }
        else{
            [categoriaSelect setAtivo:[NSNumber numberWithInt:0]];
        }
        
        if(novaCategoria){
            NSNumber *next = [GerenciadorBD getNextAutoIncrement:@"Categoria" fieldIdKey:@"id"];
            [categoriaSelect setId: next];
            [GerenciadorBD inserir: categoriaSelect];
        }
        else{
            [GerenciadorBD salvar: categoriaSelect];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sistoque" message:@"Campo descrição da categoria vazio " delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}



@end
