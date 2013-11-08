//
//  CellRelatorioProduto.h
//  Sistoque
//
//  Created by Raffael Patrício de Souza on 07/11/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellRelatorioProduto : UITableViewCell

@property(nonatomic,retain)IBOutlet UILabel *nomeProduto;
@property(nonatomic,retain)IBOutlet UILabel *saidaProduto;
@property(nonatomic,retain)IBOutlet UILabel *valorProduto;

@end
