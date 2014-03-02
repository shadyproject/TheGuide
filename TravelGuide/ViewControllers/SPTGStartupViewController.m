//
//  SPTGStartupViewController.m
//  TravelGuide
//
//  Created by Christopher Martin on 2/28/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

//view controllers
#import "SPTGStartupViewController.h"

//data controllers
#import "SPTGArticleController.h"

//models
#import "MWGeoSearchResult.h"
#import "MWParseResult.h"

@interface SPTGStartupViewController () <SPTGArticleControllerDelegate, UITextViewDelegate>

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UILabel *loadingLabel;
@property (nonatomic, strong) IBOutlet UITextView *articleView;

@property (nonatomic, strong) SPTGArticleController *articleController;
@end

@implementation SPTGStartupViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.articleController = [[SPTGArticleController alloc] init];
    self.articleController.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self showLoadingUi];
    [self.articleController fetchArticleForCurrentLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Controller Methods
-(void)showLoadingUi{
    self.loadingLabel.hidden = NO;
    [self.activityIndicator startAnimating];
}

-(void)hideLoadingUi{
    self.loadingLabel.hidden = YES;
    [self.activityIndicator stopAnimating];
}

#pragma mark - SPTGArticleCOntrollerDelegate
-(void)articleController:(SPTGArticleController*)controller
         didFetchArticle:(MWParseResult *)article{

    [self hideLoadingUi];
    
    NSLog(@"Displaying article");
    
    self.articleView.text = article.text;
}

-(void)articleController:(SPTGArticleController *)controller failedToFetchArticleWithError:(NSError *)error{
    [self hideLoadingUi];
    
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Error Loading Article"
                                                   message:error.localizedDescription delegate:nil
                                         cancelButtonTitle:@"Okay"
                                         otherButtonTitles:nil];
    
    [view show];
}

-(MWGeoSearchResult*)searchResultToLoadFromList:(NSArray *)resultsList{
   //TODO: present this with a UI
    MWGeoSearchResult *result = [resultsList firstObject];
    self.loadingLabel.text = [NSString stringWithFormat:@"Loading article for %@", result.title];
    
    return result;
}

@end
