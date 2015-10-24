//
//  CellRelatorioProduto.m
//  Sistoque
//
//  Created by Raffael Patrício de Souza on 07/11/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "CellRelatorioProduto.h"

@implementation CellRelatorioProduto

@synthesize nomeProduto,saidaProduto,valorProduto;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
