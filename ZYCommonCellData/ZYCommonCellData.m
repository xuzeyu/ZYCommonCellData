//
//  ZYCommonCellData.m
//  YNFCGJ
//
//  Created by XUZY on 2022/6/1.
//

#import "ZYCommonCellData.h"

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
        
        self.sObj = ^ZYCellData * _Nonnull(id  _Nonnull obj) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.obj = obj;
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

@implementation ZYSectionData

- (NSMutableArray *)rows {
    if (!_rows) {
        _rows = [NSMutableArray array];
    }
    return _rows;
}

@end
