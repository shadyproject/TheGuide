//
//  SPTGArticleViewController.m
//  TravelGuide
//
//  Created by Christopher Martin on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "SPTGArticleViewController.h"

//data controllers
#import "SPTGArticleController.h"

//models
#import "MWGeoSearchResult.h"
#import "MWParseResult.h"

//cells
#import "SPTGLeadCell.h"
#import "SPTGSectionCell.h"

@interface SPTGArticleViewController () <SPTGArticleControllerDelegate,
                                         UICollectionViewDataSource,
                                         UICollectionViewDelegate,
                                         UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UILabel *loadingLabel;

@property (nonatomic, strong) SPTGArticleController *articleController;

@property (nonatomic, strong) MWParseResult *article;
@end

@implementation SPTGArticleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureCollectionView];
    
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

-(void)configureCollectionView{
    [self.collectionView registerNib:[UINib nibWithNibName:@"SPTGLeadCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:[SPTGLeadCell cellReuseId]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SPTGSectionCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:[SPTGSectionCell cellReuseId]];
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

    
    NSLog(@"Displaying article");
    
    self.article = article;
    
    NSDictionary *options = @{
                              NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]
                              };
    NSAttributedString *convertedText = [[NSAttributedString alloc] initWithData:[article.text dataUsingEncoding:NSUTF8StringEncoding]
                                                                         options:options
                                                              documentAttributes:nil error:nil];
    [self hideLoadingUi];
    [self.collectionView reloadData];
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

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.article) {
        return 0;
    } else {
        return self.article.sections.count;
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UICollectionViewDelegate
@end
