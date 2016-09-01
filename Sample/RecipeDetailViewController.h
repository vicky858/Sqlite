//
//  RecipeDetailViewController.h
//  RecipeBook
//
//  Created by vignesh on 31/08/16.
//  Copyright © 2016 vignesh. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *recipePhoto;
@property (weak, nonatomic) IBOutlet UILabel *prepTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *ingredientTextView;

@property (nonatomic, strong) Recipe *recipe;

@end
