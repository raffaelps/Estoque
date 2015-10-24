//
//  RelatorioEntradaSaidaMesViewController.h
//  Sistoque
//
//  Created by Raffael Patrício de Souza on 07/11/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RelatorioEntradaSaidaMesViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *listaProdutos;
    NSArray *listaMovimentacoes;
    NSMutableArray *listaMeses;
}

@property (nonatomic,retain)IBOutlet UITableView *tabela;
@property (nonatomic,retain)NSString *tipo;

@end
