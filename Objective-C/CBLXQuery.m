//
//  CBLXQuery.m
//  CouchbaseLite
//
//  Created by Pasin Suriyentrakorn on 3/8/17.
//  Copyright © 2017 Couchbase. All rights reserved.
//

#import "CBLXQuery.h"
#import "CBLXQuery+Internal.h"

@implementation CBLXQuery

@synthesize select=_select, from=_from, where=_where, orderBy=_orderBy;


- (instancetype) initWithSelect: (CBLQuerySelect*)select
                           from: (CBLQueryDataSource*)from
                          where: (nullable CBLQueryExpression*)where
                        orderBy: (nullable CBLQueryOrderBy*)orderBy
{
    self = [super init];
    if (self) {
        _from = from;
        _select = [select copy];
        _where = [where copy];
        _orderBy = [orderBy copy];
    }
    return self;
}


#pragma mark - SELECT > FROM


+ (instancetype) select: (CBLQuerySelect*)select from: (CBLQueryDataSource*)from {
    return [[[self class] alloc] initWithSelect: select from: from where: nil orderBy: nil];
}


+ (instancetype) selectDistict: (CBLQuerySelect*)selectDistict from: (CBLQueryDataSource*)from {
    return [[[self class] alloc] initWithSelect: selectDistict from: from where: nil orderBy: nil];
}


#pragma mark - SELECT > FROM > WHERE


+ (instancetype) select: (CBLQuerySelect*)select
                   from: (CBLQueryDataSource*)from
                  where: (CBLQueryExpression*)where
{
    return [[[self class] alloc] initWithSelect: select from: from where: where orderBy: nil];
}


+ (instancetype) selectDistict: (CBLQuerySelect*)selectDistict
                          from: (CBLQueryDataSource*)from
                         where: (CBLQueryExpression*)where
{
    return [[[self class] alloc] initWithSelect: selectDistict from: from where: where orderBy: nil];
}


#pragma mark - SELECT > FROM > WHERE > ORDER BY


+ (instancetype) select: (CBLQuerySelect*)select
                   from: (CBLQueryDataSource*)from
                  where: (CBLQueryExpression*)where
                orderBy: (CBLQueryOrderBy*)orderBy
{
    return [[[self class] alloc] initWithSelect: select from: from where: where orderBy: orderBy];
}


+ (instancetype) selectDistict: (CBLQuerySelect*)selectDistict
                          from: (CBLQueryDataSource*)from
                         where: (CBLQueryExpression*)where
                       orderBy: (CBLQueryOrderBy*)orderBy
{
    return [[[self class] alloc] initWithSelect: selectDistict from: from where: where orderBy: orderBy];
}


#pragma mark - RUN


- (nullable NSEnumerator<CBLQueryRow*>*) run: (NSError**)error {
    return nil;
}


#pragma mark - INTERNAL

- (nullable NSData*) encodeAsJSON: (NSError**)outError {
    return [NSJSONSerialization dataWithJSONObject: [self jsonRepresentation]
                                           options: 0 error: outError];
}


- (id) jsonRepresentation {
    NSMutableDictionary* q = [NSMutableDictionary dictionary];
    q[@"WHAT"] = _select.jsonRepresentation;
    q[@"WHERE"] = _where.jsonRepresentation;
    q[@"ORDER_BY"] = _orderBy.jsonRepresentation;
    return q;
}

@end
