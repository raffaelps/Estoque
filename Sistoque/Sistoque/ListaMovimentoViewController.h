//
//  ListaMovimentoViewController.h
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Produto.h"

@interface ListaMovimentoViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *listaAllMovimentos;
    NSMutableArray *listaMovimentosProduto;
    Produto *produto;
}

@property (weak, nonatomic) IBOutlet UITableView *tableMovimentos;
@property (nonatomic,retain) Produto *produto;
-(void)setProduto:(Produto *)prod;

@end
