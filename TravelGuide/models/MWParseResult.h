//
//  MWParseResult.h
//  TravelGuide
//
//  Created by Christopher Martin on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kMWParseResultExternalLinkUrlKey;
extern NSString *const kMWParseResultExternalLinkPhoneKey;

@interface MWParseResult : NSObject

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSNumber *revId;
@property (nonatomic, readonly) NSString *text;
@property (nonatomic, readonly) NSArray *links;
@property (nonatomic, readonly) NSArray *images;
@property (nonatomic, readonly) NSString *displayTitle;

@property (nonatomic, readonly) NSArray *externalLinks;

@property (nonatomic, readonly) NSArray *sections;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

-(NSString*)leadText;
@end
