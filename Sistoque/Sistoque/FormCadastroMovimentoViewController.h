//
//  FormCadastroMovimentoViewController.h
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormCadastroMovimentoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *labelNroMovimento;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedTipoMovimento;
@property (strong, nonatomic) IBOutlet UITextField *textProduto;
@property (strong, nonatomic) IBOutlet UITextField *textDataMovimento;
@property (strong, nonatomic) IBOutlet UITextField *qtdMovimento;
@property (strong, nonatomic) IBOutlet UITextField *vlrMovimento;
@property (strong, nonatomic) IBOutlet UISwitch *switchStatus;

-(void)setNextMovimento:(int)nextMovimento;
-(void)setProduto:(id)produto;
@end
