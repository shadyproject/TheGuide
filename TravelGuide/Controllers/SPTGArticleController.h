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

@protocol SPTGArticleControllerDelegate

-(void)articleController:(SPTGArticleController*)controller didFetchArticle:(NSAttributedString*)article forLocation:(CLLocation*)location;
-(void)articleController:(SPTGArticleController *)controller failedToFetchArticleWithError:(NSError*)error;

@optional
//if multiple search results, allow the delegate to decide which to load
-(NSString*)nameOfArticleToFetchFromList:(NSArray*)listOfNames;

@end

@interface SPTGArticleController : NSObject

@property (nonatomic, weak) id<SPTGArticleControllerDelegate> delegate;

-(void)fetchArticleForCurrentLocation;

@end
