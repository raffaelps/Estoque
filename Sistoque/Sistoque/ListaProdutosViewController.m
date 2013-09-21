//
//  ListaProdutosViewController.m
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "ListaProdutosViewController.h"
#import "CellProdutos.h"

@interface ListaProdutosViewController ()

@end

@implementation ListaProdutosViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)novoProduto:(id)sender
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellProdutos";
    
    CellProdutos *cellTopo = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellTopo == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CellTopo" owner:nil options:nil];
        
        for (id currenctObject in topLevelObjects)
        {
            if ([currenctObject isKindOfClass:[UITableViewCell class]])
            {
                cellTopo = (CellProdutos *) currenctObject;
            }
        }
    }
    
    cellTopo.nomeProduto.text = @"Nome do produto de teste";
    
    return cellTopo;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

@end
