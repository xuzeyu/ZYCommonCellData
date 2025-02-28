//
//  ZYCommonCellData.m
//  YNFCGJ
//
//  Created by XUZY on 2022/6/1.
//

#import "ZYCommonCellData.h"
#import <UIKit/UIKit.h>

@interface ZYCellData ()
@property (nonatomic, strong, nullable) NSMutableDictionary *valueDic;
@end

@implementation ZYCellData
- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak __typeof(self)weakSelf = self;
        self.sIdentifier = ^ZYCellData * _Nonnull(NSString * _Nonnull identifier) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.identifier = identifier;
            return strongSelf;
        };
        
        self.sCellClass = ^ZYCellData * _Nonnull(Class  _Nonnull __unsafe_unretained cellClass) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.cellClass = cellClass;
            return strongSelf;
        };
        
        self.sValue = ^ZYCellData * _Nonnull(NSString * _Nonnull key, id  _Nonnull value) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            if (key.length > 0 && value) {
                [strongSelf.valueDic setObject:value forKey:key];
                if (strongSelf.sValueCallback) {
                    strongSelf.sValueCallback(key, value);
                }
            }
            return strongSelf;
        };
        
        self.sValueNotCallback = ^ZYCellData * _Nonnull(NSString * _Nonnull key, id  _Nonnull value) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            if (key.length > 0 && value) {
                [strongSelf.valueDic setObject:value forKey:key];
            }
            return strongSelf;
        };
        
        self.sSValueCallback = ^ZYCellData * _Nonnull(ZYCellDataCallbackKeyValue  _Nonnull sValueCallback) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.sValueCallback = sValueCallback;
            return strongSelf;
        };
        
        self.gValue = ^id _Nonnull(NSString * _Nonnull key) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            return [strongSelf.valueDic objectForKey:key];
        };
        
        self.rValue = ^ZYCellData * _Nonnull(NSString * _Nonnull key) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.valueDic removeObjectForKey:key];
            if (strongSelf.rValueCallback) {
                strongSelf.rValueCallback(key);
            }
            return strongSelf;
        };
        
        self.sRValueCallback = ^ZYCellData * _Nonnull(ZYCellDataCallbackKey  _Nonnull rValueCallback) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.rValueCallback = rValueCallback;
            return strongSelf;
        };
        
        self.sSelected = ^ZYCellData * _Nonnull(BOOL selected) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.selected = selected;
            return strongSelf;
        };
    }
    return self;
}

- (NSMutableDictionary *)valueDic {
    if (!_valueDic) {
        _valueDic = [NSMutableDictionary dictionary];
    }
    return _valueDic;
}
@end

@interface ZYSectionData ()
@property (nonatomic, strong, nullable) NSMutableDictionary *valueDic;
@end

@implementation ZYSectionData

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak __typeof(self)weakSelf = self;
        self.sTitle = ^ZYSectionData * _Nonnull(NSString * _Nonnull title) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.title = title;
            return strongSelf;
        };
        
        self.sIsAlone = ^ZYSectionData * _Nonnull(BOOL isAlone) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.isAlone = isAlone;
            return strongSelf;
        };
        
        self.sValue = ^ZYSectionData * _Nonnull(NSString * _Nonnull key, id  _Nonnull value) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            if (key.length > 0 && value) {
                [strongSelf.valueDic setObject:value forKey:key];
            }
            return strongSelf;
        };
        
        self.gValue = ^id _Nonnull(NSString * _Nonnull key) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            return [strongSelf.valueDic objectForKey:key];
        };
        
        self.sSelected = ^ZYSectionData * _Nonnull(BOOL selected) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.selected = selected;
            return strongSelf;
        };
    }
    return self;
}

- (NSMutableArray *)rows {
    if (!_rows) {
        _rows = [NSMutableArray array];
    }
    return _rows;
}

- (NSMutableDictionary *)valueDic {
    if (!_valueDic) {
        _valueDic = [NSMutableDictionary dictionary];
    }
    return _valueDic;
}

- (ZYCellDataSearchResult * _Nullable)searchCellDataByIdentifier:(NSString *)identifier {
    if (identifier.length == 0) return nil;
    for (NSInteger i = 0; i < self.rows.count; i++) {
        ZYCellData *cellData = self.rows[i];
        if ([identifier isEqualToString:cellData.identifier]) {
            ZYCellDataSearchResult *result = [[ZYCellDataSearchResult alloc] init];
            result.indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            result.sectionData = self;
            result.cellData = cellData;
            return result;
        }
    }
    return nil;
}

+ (ZYCellDataSearchResult *_Nullable)searchCellDataByIdentifier:(NSString *)identifier sectionDatas:(NSArray *)sectionDatas {
    if (identifier.length == 0) return nil;
    for (NSInteger i = 0; i < sectionDatas.count; i++) {
        ZYSectionData *sectionData = sectionDatas[i];
        for (NSInteger j = 0; j < sectionData.rows.count; j++) {
            ZYCellData *cellData = sectionData.rows[j];
            if ([identifier isEqualToString:cellData.identifier]) {
                ZYCellDataSearchResult *result = [[ZYCellDataSearchResult alloc] init];
                result.indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                result.sectionData = sectionData;
                result.cellData = cellData;
                return result;
            }
        }
    }
    return nil;
}

@end

@implementation ZYCellDataSearchResult

@end
