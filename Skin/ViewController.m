//
//  ViewController.m
//  Skin
//
//  Created by intel on 10/1/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//

#import "ViewController.h"

//this controls the detail view for products -- see it in action in the currents and favorites lists

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *productDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.productNameLabel.text = self.passedProduct.productName;
    self.productDetailLabel.text = self.passedProduct.brand;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
