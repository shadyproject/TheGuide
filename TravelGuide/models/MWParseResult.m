//
//  MWParseResult.m
//  TravelGuide
//
//  Created by Christopher Martin on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "MWParseResult.h"

NSString *const kMWParseResultTitleKey =  @"title";
NSString *const kMWParseResultRevIdKey =  @"revid";
NSString *const kMWParseResultTextKey =  @"text";
NSString *const kMWParseResultLinksKey =  @"links";
NSString *const kMWParseResultImagesKey =  @"images";
NSString *const kMWParseResultExternalLinksKey =  @"externallinks";
NSString *const kMWParseResultSectionsKey =  @"sections";
NSString *const kMWParseResultDisplayTitleKey =  @"displaytitle";

NSString *const kMWParseResultExternalLinkUrlKey = @"externalLinkUrl";
NSString *const kMWParseResultExternalLinkPhoneKey = @"externalLinkPhone";



@interface MWParseResult ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *displayTitle;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSNumber *revId;

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *links;
@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSArray *externalLinks;

@end

@implementation MWParseResult

-(instancetype)init{
    NSAssert(false, @"Please use the designated initializer %@", NSStringFromSelector(@selector(initWithDictionary:)));
    return nil;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        self.title = dictionary[kMWParseResultTitleKey];
        self.displayTitle = dictionary[kMWParseResultDisplayTitleKey];
        self.text = dictionary[kMWParseResultTextKey][@"*"];
        
        self.revId = [NSNumber numberWithInt:[dictionary[kMWParseResultRevIdKey] intValue]];
        
        __block  NSMutableArray *images = [NSMutableArray array];
        [dictionary[kMWParseResultImagesKey] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [images addObject:obj];
        }];
        
        self.images = images;
        
        __block NSMutableArray *links = [NSMutableArray array];
        [dictionary[kMWParseResultLinksKey] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *link = obj[@"*"];
            [links addObject:link];
        }];
        
        self.links = links;
        
        __block NSMutableArray *sections = [NSMutableArray array];
        [dictionary[kMWParseResultSectionsKey] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //TODO: make this an MWSection object or something like that
            NSString *section = obj[@"line"];
            [sections addObject:section];
        }];
        
        self.sections = sections;
        
        /*
        __block NSMutableArray *externalLinks = [NSMutableArray array];
        //if index+1 is a tel:// don't create standalone external link dict for it
        __block BOOL didProcessNextIndex = NO;
        
        //what we're working with, with the block attribtue to avoid retain cycle weirdness
        __block NSArray *workingArray = dictionary[kMWParseResultExternalLinksKey];
        
        [workingArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
             if (didProcessNextIndex) {
                didProcessNextIndex = NO;
                return;
            }
            
            NSString *link = obj;
            //try to avoid getting telephone nmbers by themselves
            if ([link hasPrefix:@"tel:"]) {
                return;
            }
            
            //half assed attempt at associating phone numbers and others with links
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:link forKey:kMWParseResultExternalLinkUrlKey];
            NSInteger next = idx + 1;
            if (idx > workingArray.count) {
                return;
            }
            NSString *phoneNumber = workingArray[next];
         //enumerate until we find the next http link then stop iterating and pull each item associated with the url
            NSArray *subset = [workingArray subarrayWithRange:NSMakeRange(idx, workingArray.count - idx)];
            if ([phoneNumber hasPrefix:@"tel:"]) {
                didProcessNextIndex = YES;
                [dict setObject:phoneNumber forKey:kMWParseResultExternalLinkPhoneKey];
            }
            
            [externalLinks addObject:obj];
        }];
         */
        
        self.externalLinks = [NSArray arrayWithArray:dictionary[kMWParseResultExternalLinksKey]];
    }
    
    return self;
}
@end
