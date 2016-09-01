//
//  RecipeBookViewController.m
//  RecipeBook
//
//  Created by vignesh on 31/08/16.
//  Copyright © 2016 vignesh. All rights reserved.
//


#import "RecipeBookViewController.h"
#import "RecipeDetailViewController.h"
#import "Recipe.h"

@interface RecipeBookViewController ()

@end

@implementation RecipeBookViewController {
    NSArray *recipes;
}

@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Recipe *recipe1 = [Recipe new];
    recipe1.name = @"Egg Benedict";
    recipe1.prepTime = @"30 min";
    recipe1.imageFile = @"egg_benedict.jpg";
    recipe1.ingredients = [NSArray arrayWithObjects:@"2 fresh English muffins", @"4 eggs", @"4 rashers of back bacon", @"2 egg yolks", @"1 tbsp of lemon juice", @"125 g of butter", @"salt and pepper", nil];
    
    Recipe *recipe2 = [Recipe new];
    recipe2.name = @"Mushroom Risotto";
    recipe2.prepTime = @"30 min";
    recipe2.imageFile = @"mushroom_risotto.jpg";
    recipe2.ingredients = [NSArray arrayWithObjects:@"1 tbsp dried porcini mushrooms", @"2 tbsp olive oil", @"1 onion, chopped", @"2 garlic cloves", @"350g/12oz arborio rice", @"1.2 litres/2 pints hot vegetable stock", @"salt and pepper", @"25g/1oz butter", nil];
    
    Recipe *recipe3 = [Recipe new];
    recipe3.name = @"Full Breakfast";
    recipe3.prepTime = @"20 min";
    recipe3.imageFile = @"full_breakfast.jpg";
    recipe3.ingredients = [NSArray arrayWithObjects:@"2 sausages", @"100 grams of mushrooms", @"2 rashers of bacon", @"2 eggs", @"150 grams of baked beans", @"Vegetable oil", nil];
    
    Recipe *recipe4 = [Recipe new];
    recipe4.name = @"Hamburger";
    recipe4.prepTime = @"30 min";
    recipe4.imageFile = @"hamburger.jpg";
    recipe4.ingredients = [NSArray arrayWithObjects:@"400g of ground beef", @"1/4 onion (minced)", @"1 tbsp butter", @"hamburger bun", @"1 teaspoon dry mustard", @"Salt and pepper", nil];
    
    Recipe *recipe5 = [Recipe new];
    recipe5.name = @"Ham and Egg Sandwich";
    recipe5.prepTime = @"10 min";
    recipe5.imageFile = @"ham_and_egg_sandwich.jpg";
    recipe5.ingredients = [NSArray arrayWithObjects:@"1 unsliced loaf (1 pound) French bread", @"4 tablespoons butter", @"2 tablespoons mayonnaise", @"8 thin slices deli ham", @"1 large tomato, sliced", @"1 small onion", @"8 eggs", @"8 slices cheddar cheese", nil];
    
    
    
    recipes = [NSArray arrayWithObjects:recipe1, recipe2, recipe3, recipe4, recipe5, nil];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Assign our own backgroud for the view
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // Add padding to the top of the table view
    UIEdgeInsets inset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.contentInset = inset;
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Recipe *recipe = [recipes objectAtIndex:indexPath.row];
    cell.textLabel.text = recipe.name;
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:recipe.imageFile];
    
    UILabel *recipeNameLabel = (UILabel *)[cell viewWithTag:200];
    recipeNameLabel.text = recipe.name;
//
//    UILabel *recipeDetailLabel = (UILabel *)[cell viewWithTag:120];
//    recipeDetailLabel.text = recipe.detail;
    
    // Assign our own background image for the cell
        return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RecipeDetailViewController *destViewController = segue.destinationViewController;
        destViewController.recipe = [recipes objectAtIndex:indexPath.row];

        // Hide bottom tab bar in the detail view
     //   destViewController.hidesBottomBarWhenPushed = YES;
    }
}


@end
