//
//  MWParseResult.m
//  TravelGuide
//
//  Created by Christopher Martin on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "MWParseResult.h"

@interface MWParseResult ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *revId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray *links;
@property (nonatomic, strong) NSArray *images;

//these seem to be paired up, but not in a distinct object
@property (nonatomic, strong) NSArray *externalLinks;
@property (nonatomic, strong) NSArray *phoneNumbers;

@property (nonatomic, strong) NSArray *sections;
@end

@implementation MWParseResult

-(instancetype)init{
    NSAssert(false, @"Please use the designated initializer %@", NSStringFromSelector(@selector(initWithDictionary:)));
    return nil;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        //TODO: implement me
    }
    
    return self;
}
@end
