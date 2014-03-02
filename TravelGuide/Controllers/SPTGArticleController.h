//
//  SPTGArticleController.h
//  TravelGuide
//
//  Created by Christopher Martin on 2/28/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;
@class SPTGArticleController;
@class MWGeoSearchResult;
@class MWParseResult;

@protocol SPTGArticleControllerDelegate

-(void)articleController:(SPTGArticleController*)controller didFetchArticle:(MWParseResult*)article;
-(void)articleController:(SPTGArticleController *)controller failedToFetchArticleWithError:(NSError*)error;

@optional
//if multiple search results, allow the delegate to decide which to load
-(MWGeoSearchResult*)searchResultToLoadFromList:(NSArray*)resultsList;

@end

@interface SPTGArticleController : NSObject

@property (nonatomic, weak) NSObject<SPTGArticleControllerDelegate> *delegate;

-(void)fetchArticleForCurrentLocation;

@end
