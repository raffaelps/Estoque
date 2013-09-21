//
//  CellProdutos.h
//  Sistoque
//
//  Created by Raffael Patrício de Souza on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellProdutos : UITableViewCell

@property(nonatomic,retain)IBOutlet UILabel *linha;
@property(nonatomic,retain)IBOutlet UILabel *nomeProduto;
@property(nonatomic,retain)IBOutlet UILabel *nomeCategoria;
@property(nonatomic,retain)IBOutlet UILabel *quantMaxima;
@property(nonatomic,retain)IBOutlet UILabel *quantMin;
@property(nonatomic,retain)IBOutlet UILabel *quantEstoque;

@end
