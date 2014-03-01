//
//  MWSearchResult.h
//  TravelGuide
//
//  Created by Christopher Martin on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWGeoSearchResult : NSObject

@property (nonatomic, readonly) NSNumber *distance;
@property (nonatomic, readonly) NSNumber *latitude;
@property (nonatomic, readonly) NSNumber *longitude;
@property (nonatomic, readonly) NSNumber *ns; //namespace is apparently a reserved word
@property (nonatomic, readonly) NSString *pageId;
@property (nonatomic, readonly) NSString *primary;
@property (nonatomic, readonly) NSString *title;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
