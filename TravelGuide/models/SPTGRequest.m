//
//  SPTGRequest.m
//  TravelGuide
//
//  Created by Dave Shanley on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "SPTGRequest.h"

NSString *const kWMBaseUrl =  @"http://en.wikivoyage.org/w/api.php";

//////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark SPTGRequest


@implementation SPTGRequest

- (id)init {
    if (self = [super init]) {
        self.url = kWMBaseUrl;
    }
    return self;
}

- (NSURLRequest *)request {
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:self.url parameters:self.parameters error:nil];
    return request;
}

@end

//////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark SPTGQueryRequest


@implementation SPTGQueryRequest



@end

//////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark SPTGGeoRequest

@implementation SPTGGeoRequest

- (id)init {
    if (self = [super init]) {
        self.parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"format":@"json", @"action":@"query", @"list":@"geosearch", @"gsradius":@"10000", @"gslimits":@"10"}];
    }
    return self;
}

- (void)setCoordinates:(CLLocationCoordinate2D)coordinates {
    _coordinates = coordinates;
    NSString *latLonString = [NSString stringWithFormat:@"%f|%f", coordinates.latitude, coordinates.longitude];
    [self.parameters setObject:latLonString forKey:@"gscoord"];
}

@end
