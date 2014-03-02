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

const NSInteger kSPTGArticleLeadSection = 0;
const NSInteger kSPTGArticleSectionSection = 1;

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
    
    /*
    NSDictionary *options = @{
                              NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]
                              };
    NSAttributedString *convertedText = [[NSAttributedString alloc] initWithData:[article.text dataUsingEncoding:NSUTF8StringEncoding]
                                                                         options:options
                                                              documentAttributes:nil error:nil];
     */
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
    NSLog(@"Available search results: %@", resultsList);
    MWGeoSearchResult *result = [resultsList firstObject];
    self.loadingLabel.text = [NSString stringWithFormat:@"Loading article for %@", result.title];
    
    return result;
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = 0;
    if (!self.article) {
        return count;
    }
    
    switch (section) {
        case kSPTGArticleLeadSection:
            count = 1;
            break;
            
        case kSPTGArticleSectionSection:
            count = self.article.sections.count - 1;
            break;
            
        default:
            count = 0;
            break;
    }
    
    return count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (!self.article) {
        return 0;
    }
    
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = nil;
    
    switch (indexPath.section) {
        case kSPTGArticleLeadSection:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SPTGLeadCell cellReuseId] forIndexPath:indexPath];
            [self configureLeadCell:cell forItemAtIndexPath:indexPath];
            break;
        
        case kSPTGArticleSectionSection:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SPTGSectionCell cellReuseId] forIndexPath:indexPath];
            [self configureSectionCell:cell forItemAtIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)configureSectionCell:(UICollectionViewCell*)cell forItemAtIndexPath:(NSIndexPath*)indexPath{
    SPTGSectionCell *sectionCell = (SPTGSectionCell*)cell;
    
    NSString *sectionName = self.article.sections[indexPath.item];
    sectionCell.sectionText = [[NSAttributedString alloc] initWithString:sectionName];
    
}

-(void)configureLeadCell:(UICollectionViewCell*)cell forItemAtIndexPath:(NSIndexPath*)indexPath{
    SPTGLeadCell *leadCell = (SPTGLeadCell*)cell;
    
    leadCell.title = self.article.displayTitle;
    leadCell.bodyText = [[NSAttributedString alloc] initWithString:@"There should be a lot more text here"];
    //leadCell.backgroundImage = [UIImage imageNamed:@"continents"];
}

#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeZero;
    
    //TODO: pull the heights out into constants
    switch (indexPath.section) {
        case kSPTGArticleLeadSection:
            size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 10, 150);
            break;
            
        case kSPTGArticleSectionSection:
            size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 10, 50);
            break;
            
        default:
            break;
    }
    
    return size;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2.5, 5.0, 2.5, 5.0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2.5;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2.5;
}
@end
