//
//  DBCommon.h
//  SenPosMaker
//
//  Created by 田中郁也 on 2013/03/21.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//


@interface DBCommon : NSObject {
    sqlite3 *database;

}
@property sqlite3 *database;

- (BOOL)loadDb;
- (void) openDb;
- (NSString *) getPhrase ;
- ( NSString * ) dbtext:( sqlite3_stmt *) statement index:(int)i ;
/*
- (NSString *)makeImageName:(NSString *)origin;
- (NSString *)webLanguage:(NSString *)lang;
- (NSString *)trimErrcd:(NSString *)errcd;
*/
@end
