//
//  SPTGArticleController.m
//  TravelGuide
//
//  Created by Christopher Martin on 2/28/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

@import CoreLocation;
#import <AFNetworking/AFNetworking.h>

//contollers
#import "SPTGArticleController.h"

//models
#import "SPTGRequest.h"
#import "MWGeoSearchResult.h"
#import "MWParseResult.h"

@interface SPTGArticleController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation SPTGArticleController

-(instancetype)init{
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.distanceFilter = 1000; //1km
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        self.locationManager.delegate = self;
    }
    
    return self;
}

-(void)fetchArticleForCurrentLocation{
    [self.locationManager startUpdatingLocation];
}

-(void)fetchArticleForLocation:(CLLocation*)location{
    
    [self.locationManager stopUpdatingLocation];
    
    SPTGGeoRequest *searchRequest = [[SPTGGeoRequest alloc] init];
    searchRequest.coordinates = location.coordinate;
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:searchRequest.request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
     typeof(self)weakSelf = self;
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        //TODO make these constants and maybe use a custom serializer above?
        NSArray *results = responseObject[@"query"][@"geosearch"];
        MWGeoSearchResult *searchForThis = nil;
        
        if (results.count > 1 && [strongSelf.delegate respondsToSelector:@selector(searchResultToLoadFromList:)]) {
            __block NSMutableArray *options = [NSMutableArray array];
            [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                MWGeoSearchResult *r = [[MWGeoSearchResult alloc] initWithDictionary:obj];
                [options addObject:r];
            }];
            
            searchForThis = [strongSelf.delegate searchResultToLoadFromList:options];
        } else {
            searchForThis = [[MWGeoSearchResult alloc] initWithDictionary:[results firstObject]];
        }
        
        NSLog(@"Will search for %@", searchForThis);
        [strongSelf fetchArticleForPageId:searchForThis.pageId];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error occured during operation: %@", operation);
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf forwardErrorToDelegate:error];
    }];
    
    [op start];
}

-(void)fetchArticleForPageId:(NSString*)pageId{
    SPTGQueryRequest *queryReq = [[SPTGQueryRequest alloc] init];
    queryReq.pageId = pageId;
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:queryReq.request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    typeof(self)weakSelf = self;
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        MWParseResult *article = [[MWParseResult alloc] initWithDictionary:responseObject[@"parse"]];
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.delegate articleController:strongSelf didFetchArticle:article];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error occured during operation: %@", operation);
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf forwardErrorToDelegate:error];
    }];
    
    [op start];
}

-(void)forwardErrorToDelegate:(NSError*)error{
    NSLog(@"Error occured: %@", error);
    [self.delegate articleController:self failedToFetchArticleWithError:error];
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager*)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *firstLocation = locations[0];
    
    NSTimeInterval t = [[firstLocation timestamp] timeIntervalSinceNow];
    
    //ignore location if it was more than 3 minutes ago since CLLocatioNManager
    //will return a cached location first
    if (t < -180) {
        NSLog(@"Ignoring first location");
        return;
    }
    
    [self fetchArticleForLocation:firstLocation];
    
}

@end
