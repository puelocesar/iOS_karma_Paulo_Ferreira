//
//  KCBluetoothCentral.m
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import "KCBluetoothCentral.h"

@implementation KCBluetoothCentral

CBCentralManager *centralManager;
CBUUID* karma_service_id;

-(id)init
{
    karma_service_id = [CBUUID UUIDWithString:UUID_KARMA_SERVICE_STRING];
    centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    self.peripherals = [[NSMutableDictionary alloc] init];
    
    return self;
}

//center part: this will receive the karma
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    [central scanForPeripheralsWithServices:@[karma_service_id] options:nil];
}

- (KCAvatarData *) getAvatarDataForPeripheral: (CBPeripheral *) peripheral
{
    return [self.peripherals objectForKey:peripheral.identifier.UUIDString];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"did discover peripheral");

    KCAvatarData* data = [self getAvatarDataForPeripheral:peripheral];

    if (data == NULL) {
        data = [[KCAvatarData alloc] init];
        data.peripheral = peripheral;

        [self.peripherals setValue:data forKey:peripheral.identifier.UUIDString];

        NSLog(@"%@", peripheral.identifier.UUIDString);

        //connect to the peripheral the first time to get the name
        [centralManager connectPeripheral:peripheral options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central
  didConnectPeripheral:(CBPeripheral *)peripheral {
    
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
}

//delegate methods to peripheral
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    
    if (error) {
        NSLog(@"Error finding peripheral: %@",
              [error debugDescription]);
    }
    
    for (CBService *service in peripheral.services) {
        if ([service.UUID isEqual:karma_service_id])
            [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service
             error:(NSError *)error {
    
    if (error) {
        NSLog(@"Error on discover characteristic value: %@",
              [error debugDescription]);
    }

    CBUUID *karmaID = [CBUUID UUIDWithString:UUID_KARMA_CHARACTERISTIC_STRING];
    CBUUID *nameID = [CBUUID UUIDWithString:UUID_NAME_CHARACTERISTIC_STRING];

    bool already_set_name = [self getAvatarDataForPeripheral:peripheral].name != nil;

    for (CBCharacteristic *characteristic in service.characteristics) {

        //if the peripheral already has a name, it means this connection is for sending karma
        if (already_set_name && [characteristic.UUID isEqual:karmaID])
            [self sendsKarmaToPeripheral:peripheral withCharacteristic:characteristic];

        //if it doesn't have a name yet, it means it' the first connection to get the name
        else if (!already_set_name && [characteristic.UUID isEqual:nameID])
            [peripheral readValueForCharacteristic:characteristic];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral
        didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
        error:(NSError *)error
{
    if (error) {
        NSLog(@"Error getting name: %@", [error debugDescription]);
    }
    else {
        NSData *value = characteristic.value;

        KCAvatarData *data = [self getAvatarDataForPeripheral:peripheral];
        data.name = [NSString stringWithUTF8String:value.bytes];

        //add peripheral to the UI
        [self.delegate registeredNewPeripheral:data];

        //cancel the connection, as we already read what we needed
        [centralManager cancelPeripheralConnection:peripheral];
    }
}

- (void)sendKarmaWithPeripheral: (CBPeripheral*) peripheral
{
    //connects to the peripheral to send the message
    [centralManager connectPeripheral:peripheral options:nil];
}

- (void)sendsKarmaToPeripheral: (CBPeripheral*) peripheral withCharacteristic: (CBCharacteristic *) characteristic
{
    if (peripheral.state == CBPeripheralStateConnected) {
        int i = 1;
        NSData* value = [NSData dataWithBytes:&i length:sizeof(i)];

        //send one karma to the peripheral
        [peripheral writeValue:value
             forCharacteristic:characteristic
                          type:CBCharacteristicWriteWithResponse];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral
didWriteValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    
    if (error) {
        NSLog(@"Error writing characteristic value: %@", [error debugDescription]);
    }
    else {
        NSLog(@"value wrote with success");
        
        //cancelling connection as soon as possible
        [centralManager cancelPeripheralConnection:peripheral];
    }
}



@end
