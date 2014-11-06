//
//  ProductSearchTableViewController.m
//  Skin
//
//  Created by intel on 10/4/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//
#import "AddAProductViewController.h"
#import "ProductSearchTableViewController.h"
#import "ImageCache.h"

#define kProductBaseURL @"http://api.v3.factual.com/t/products-cpg-nutrition"
#define kProductAPIKey @"q64jrzULu3dY7ozineqqGWUBHjCCQfA8Oc8gnr7S"
#define kProductOAuthSecret @"dQDY2t03yMvBS7IcYz7aDEDfYordRDTEOtZBibuO"

@interface ProductSearchTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *products;
@property Product *selectedProduct;
@property NSString *prevQuery;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *loaderIcon;

@end

@implementation ProductSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //animating load indicator
    [self.loaderIcon startAnimating];
    
    //initializing array to hold products from search query
    self.products = [[NSMutableArray alloc] init];
    
    //grabbing product data
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self grabProductData];
    });
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) grabProductData
{
    //losing spaces in query string
    self.query = [self.query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    //creating full query URL
    NSString *queryString = [NSString stringWithFormat:@"%@?KEY=%@&q=%@", kProductBaseURL, kProductAPIKey, self.query];
    NSData *totalProductQuery = [NSData dataWithContentsOfURL:[NSURL URLWithString:queryString]];
    //creating dictionary with results
    NSDictionary *products = [NSJSONSerialization JSONObjectWithData:totalProductQuery options:kNilOptions error:Nil];
    
    NSMutableArray *newIndexPaths = [NSMutableArray new];
    
    NSDictionary *response = products[@"response"];
    if ([response objectForKey:@"data"] != nil) { //making sure there's product data to get

        NSArray *theProducts = response[@"data"]; //finally getting product data
    
        int previousProductCount = self.products.count;
    
        if(theProducts != nil) //if no products, should be caught above with data parameter, but just in case
        {
            //creating an array of products
            for (NSDictionary *aProduct in theProducts)
            {
                Product *thisProduct = [[Product alloc] initWithJSONDictionary:aProduct];
                [self.products addObject:thisProduct];
            }
    
            for(int i = previousProductCount; i < self.products.count; i ++)
            {
                [newIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
    
        }//end of if
    }//end of if
    else
    {
        self.products[0] = nil; //if no products
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView insertRowsAtIndexPaths:newIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    });
    
    //stopping the loading indicator
    [self.loaderIcon stopAnimating];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //initialize cells with query results
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Product *aProduct = self.products[indexPath.row];
    if(self.products[0] == nil)
    {
        cell.textLabel.text = @"No Products Found";
    }
    else
    {
        cell.textLabel.text = aProduct.productName;
        cell.detailTextLabel.text = aProduct.brand;
    
        //if the same query entered twice, images will be produced from cache not looked up again
        if (self.query == self.prevQuery) {
            [[ImageCache sharedInstance] downloadImageAtURL:[NSURL URLWithString:aProduct.thumbnailURL] completionHandler:^(UIImage *image) {
                cell.imageView.image = image;
                [cell setNeedsLayout];
            }];
        }
        else
        {
            //threading get image data...
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *imageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:aProduct.thumbnailURL]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageView.image = [UIImage imageWithData:imageData];
                    [cell layoutSubviews];
                });
    
            });
        } //end of else
    } //end of else
    
    self.prevQuery = self.query;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //selected product saved and sent back to add product view controller
    self.selectedProduct = [[Product alloc] init];
    
    self.selectedProduct = self.products[indexPath.row];
    
    [self.delegate ProductSearchTableViewController:self didFinishAddingItem:self.selectedProduct];

    
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //AddAProductViewController *dest = [segue destinationViewController];
    //dest.productToAddasObj = self.selectedProduct;
    //[dest createSelectedProduct:self.selectedProduct.brand productName:self.selectedProduct.productName ingredients:self.selectedProduct.ingredients thumbnailURL:self.selectedProduct.thumbnailURL];
    //add call to dest function to create Product from new NSObject in addaproductcontroller?
}*/



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
