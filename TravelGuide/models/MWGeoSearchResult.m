//
//  MWSearchResult.m
//  TravelGuide
//
//  Created by Christopher Martin on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "MWGeoSearchResult.h"
NSString *const kMWGeoSearchDistanceKey =  @"distance";
NSString *const kMWGeoSearchLatitudeKey =  @"lat";
NSString *const kMWGeoSearchLongitudeKey =  @"lon";
NSString *const kMWGeoSearchNamespaceKey =  @"ns";
NSString *const kMWGeoSearchPageIdKey =  @"pageid";
NSString *const kMWGeoSearchPrimaryKey =  @"primary";
NSString *const kMWGeoSearchTitleKey =  @"title";

@interface MWGeoSearchResult ()

@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *ns; //namespace is apparently a reserved word
@property (nonatomic, strong) NSString *pageId;
@property (nonatomic, strong) NSString *primary;
@property (nonatomic, strong) NSString *title;

@end

@implementation MWGeoSearchResult

-(instancetype)init{
    NSAssert(false, @"Please used the designated initializer %@", NSStringFromSelector(@selector(initWithDictionary:)));
    return nil;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    
    if (self) {
        self.distance = [NSNumber numberWithFloat:[dictionary[kMWGeoSearchDistanceKey] floatValue]];
        self.latitude = [NSNumber numberWithFloat:[dictionary[kMWGeoSearchLatitudeKey] floatValue]];
        self.longitude = [NSNumber numberWithFloat:[dictionary[kMWGeoSearchLongitudeKey] floatValue]];
        self.ns = [NSNumber numberWithInt:[dictionary[kMWGeoSearchDistanceKey] intValue]];
        
        self.pageId = dictionary[kMWGeoSearchPageIdKey];
        self.primary = dictionary[kMWGeoSearchPrimaryKey];
        self.title = dictionary[kMWGeoSearchTitleKey];
    }
    
    return self;
}

-(NSString*)description{
    NSString *desc = [NSString stringWithFormat:@"%@ (pageid: %@) (%@, %@)", self.title, self.pageId, self.latitude, self.longitude];
    return desc;
}

@end
