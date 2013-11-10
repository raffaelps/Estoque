//
//  FormCadastroProdutoViewController.m
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "FormCadastroProdutoViewController.h"
#import "GerenciadorBD.h"
#import "UIBarButtonItemHelper.h"
#import "UIPickerViewHelper.h"
#import "SisUtil.h"

@interface FormCadastroProdutoViewController ()

@end

@implementation FormCadastroProdutoViewController

@synthesize cellAtivo,cellValores,cellQuantidades,cellDescricao,cellCategoria,textCategoria,textDescricao,textQuantMaxima,textQuantMinima,textValorEntrada,textValorSaida,ativo,tableView,controllScrollView;

id elementFocus;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Novo produto"];
        rowCategoria = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self adicionaBotaoOk];
    [self carregaCategorias];
    [self defineReconhecedorToque];
    
    self.view.backgroundColor = [UIColor colorWithRed:174/255.0 green:228/255.0 blue:240/255.0 alpha:1];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    controllScrollView = [[ControllScrollView alloc]init];
    [controllScrollView setSvos:_scrollView];
}

- (void)carregarProduto
{
    if (self.produto)
    {
        
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)novoProduto
{
    Produto *newProduto = (Produto *)[GerenciadorBD getNovaInstancia:[Produto class]];
    
    NSNumber *idProduto = [[NSNumber alloc]initWithInt:nextProduto];
    NSString *descricao = self.textDescricao.text;
    NSNumber *quantidadeMinima = [SisUtil stringToInt:self.textQuantMinima.text];
    NSNumber *quantidadeMaxima = [SisUtil stringToInt:self.textQuantMaxima.text];
    NSNumber *idCategoria = 0;
    if(rowCategoria > -1){
        Categoria *categoria = [categorias objectAtIndex: rowCategoria];
        idCategoria = categoria.id;
    }
    NSNumber *valorEntrada = [SisUtil stringToInt:self.textValorEntrada.text];
    NSNumber *valorSaida = [SisUtil stringToInt:self.textValorEntrada.text];
    int switchValue = (self.ativo.isOn?0:1);
    NSNumber *produtoAtivo = [[NSNumber alloc] initWithInt:switchValue];
    
    [newProduto setId:idProduto];
    [newProduto setDescricao:descricao];
    [newProduto setQtdeMinima:quantidadeMinima];
    [newProduto setQtdeMaxima:quantidadeMaxima];
    [newProduto setIdCategoria:idCategoria];
    [newProduto setValorEntrada:valorEntrada];
    [newProduto setValorSaida:valorSaida];
    [newProduto setAtivo:produtoAtivo];
    
    NSString *mensagem = [self validaCampos:newProduto];
    
    if([SisUtil verificaTextoVazioOuNulo:mensagem]){
        [GerenciadorBD inserir:newProduto];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self exibeAlertaErro:mensagem];
    }
}

-(NSString*)validaCampos:(Produto*)produto{
    
    NSString *mensagemErro = @"";
    
    if([SisUtil verificaTextoVazioOuNulo: produto.descricao])
        return @"A descrição do produto não pode ser vazia.";
    
    if(![SisUtil isGreaterThanZero:produto.idCategoria])
        return @"A categoria não pode ser vazia.";
        
    if(![SisUtil isGreaterThanZero:produto.qtdeMaxima])
        return @"A quantidade máxima deve ser superior a 0.";
    
    if([produto.qtdeMinima integerValue] > [produto.qtdeMaxima integerValue])
        return @"A quantidade mínima não pode ser superior à máxima.";
    
    return mensagemErro;
}

-(void)exibeAlertaErro:(NSString*)mensagemErro{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Campos Inválidos!" message:mensagemErro delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return cellDescricao;
    }
    if (indexPath.row == 1) {
        return cellCategoria;
    }
    if (indexPath.row == 2) {
        return cellQuantidades;
    }
    if (indexPath.row == 3) {
        return cellValores;
    }
    
    return cellAtivo;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 || indexPath.row == 3) {
        return 88;
    }
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, -200, 0);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.tableView.contentInset = edge;
    [UIView commitAnimations];
	[textField resignFirstResponder];
	return YES;
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, 200, 0);
//    self.tableView.contentInset = edge;
//    UITableViewCell *cell = (UITableViewCell *)[[textField superview] superview];
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}

-(void)setNextProduto:(int)next
{
    nextProduto = next;
}

-(void)adicionaBotaoOk{
    
    NSString *title = @"OK";
    UIBarButtonItemStyle style = UIBarButtonItemStyleBordered;
    id target = self;
    SEL selector = @selector(novoProduto);
    
    UIBarButtonItemHelper *btnHelper = [[UIBarButtonItemHelper alloc] initWithTitle:title andStyle:style andTarget:target andSelector:&selector];
    
    UIBarButtonItem *btnSalvar = [btnHelper createBarButtonItemHelper];
    self.navigationItem.rightBarButtonItem = btnSalvar;
}

//Verifica se o Field pode começar a editar.
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == textCategoria){
        
        [self hideKeyboard];
        [self showCategoria:textField];
        return NO;
    }
    return YES;
}

- (void)showCategoria:(id)sender {
    
    if (categorias.count > 0)
    {
        pickerCategorias = [[UIPickerViewHelper alloc] initWithView:self.view andArray:categoriasDescricao];
        pickerCategorias.delegate = self;
        
        [pickerCategorias showPickerView];
    }
    else
    {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Alerta" message:@"Favor cadastrar categorias." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
}

-(void)hideKeyboard{
    /*for (UIView *textField in [self.view subviews]) {
        if ([textField isKindOfClass:[UITextField class]]) {
            [textField resignFirstResponder];
        }
    }*/
    [textCategoria resignFirstResponder];
    [textDescricao resignFirstResponder];
    [textValorEntrada resignFirstResponder];
    [textValorSaida resignFirstResponder];
    [textQuantMinima resignFirstResponder];
    [textQuantMaxima resignFirstResponder];
}

//PickerView

//Função de retorno do Delegate
-(void) getPickerValue:(NSNumber *)row{
    if(row == nil)
        row = 0;
    rowCategoria = [row integerValue];
    textCategoria.text = [categoriasDescricao objectAtIndex: rowCategoria];
    
}

-(void)defineReconhecedorToque{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [_scrollView addGestureRecognizer:gestureRecognizer];
}

-(void)carregaCategorias{    
    categoriasDescricao = [[NSMutableArray alloc]init];
    
    categorias = [GerenciadorBD listarTodosAtivo: [Categoria class] ordenacao:@"descricao"];
    
    for(Categoria *categoria in categorias){
        [categoriasDescricao addObject:categoria.descricao];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    elementFocus = textField;
    
    [controllScrollView sobeTela:textField scrollView:_scrollView fieldPosition:[textField convertPoint:textField.bounds.origin fromView:self.view] deviceSize:self.view.bounds.size];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    elementFocus = textView;
    
    [controllScrollView sobeTela:textView scrollView:_scrollView fieldPosition:[textView convertPoint:textView.bounds.origin fromView:self.view] deviceSize:self.view.bounds.size];
}

-(void)hideKeyBoard
{
    [controllScrollView hideKeyBoard:elementFocus scrollView:_scrollView navigationControllerHidden:NO];
}

@end
