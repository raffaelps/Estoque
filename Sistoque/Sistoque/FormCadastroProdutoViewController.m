//
//  FormCadastroProdutoViewController.m
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "FormCadastroProdutoViewController.h"

@interface FormCadastroProdutoViewController ()

@end

@implementation FormCadastroProdutoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Novo produto"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"OK"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(novoProduto)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)novoProduto
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
