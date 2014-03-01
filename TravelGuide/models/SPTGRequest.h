//
//  SPTGRequest.h
//  TravelGuide
//
//  Created by Dave Shanley on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

@import CoreLocation;

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface SPTGRequest : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSMutableDictionary *parameters;

- (NSURLRequest *)request;

@end

@interface SPTGQueryRequest : SPTGRequest


@end

@interface SPTGGeoRequest : SPTGRequest

@property (nonatomic, assign) CLLocationCoordinate2D coordinates;

@end
