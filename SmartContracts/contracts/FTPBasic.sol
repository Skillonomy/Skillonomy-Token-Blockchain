pragma solidity ^0.4.4;

import "./token/MintableToken.sol";
import "./payment/PullPayment.sol";
import "./AddxUintMapping.sol";

contract FTPBasic is MintableToken, PullPayment
{
    function strConcat(string _a, string _b, string _c, string _d, string _e) internal returns (string){
	bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
	bytes memory _bd = bytes(_d);
        bytes memory _be = bytes(_e);
	string memory abcde = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length);
	bytes memory babcde = bytes(abcde);
        uint k = 0;
    
        for (uint i = 0; i < _ba.length; i++) babcde[k++] = _ba[i];
    
        for (i = 0; i < _bb.length; i++) babcde[k++] = _bb[i];

	for (i = 0; i < _bc.length; i++) babcde[k++] = _bc[i];

        for (i = 0; i < _bd.length; i++) babcde[k++] = _bd[i];

	for (i = 0; i < _be.length; i++) babcde[k++] = _be[i];

        return string(babcde);
    }
    
    function bytes32ToString (bytes32 data) returns (string) {
    bytes memory bytesString = new bytes(32);
    for (uint j=0; j<32; j++) {
      byte char = byte(bytes32(uint(data) * 2 ** (8 * j)));
      if (char != 0) {
        bytesString[j] = char;
      }
    }

    return string(bytesString);
  }
    
    function uintToBytes32(uint256 x) returns (bytes32 b) {
	assembly { mstore(add(b, 32), x) }
    }

    function uintToString(uint number) returns (string)
    {
	bytes32 bx32 = uintToBytes32(number);
	return bytes32ToString(bx32);
    }


    function strConcat(string _a, string _b, string _c, string _d) internal returns (string) {
	return strConcat(_a, _b, _c, _d, "");
    }

    function strConcat(string _a, string _b, string _c) internal returns (string) {
	return strConcat(_a, _b, _c, "", "");
    }

    function strConcat(string _a, string _b) internal returns (string) {
	return strConcat(_a, _b, "", "", "");
    }
    
    struct ModuleInfo {
	uint size;
	mapping (uint => uint) opId;
	mapping (uint => uint) coef;
	mapping (uint => address) module;
	mapping (uint => uint) opIdIndex;
    }

    ModuleInfo FTPModules;

    bool canAddAddresses = false;

    event AddressAdded(address addx, uint operationId, uint coeficient);
    event CanNotAddAddress(address addx, string message, string dummy);
    event AddingAddressesActivated(address addx, string message, string dummy);
    event AddingAddressesDeactivated(address addx, string source, string message);
    event AddressList(address addx, uint operationId, uint coeficient);

    function FTPBasic()
    {
	ResetFTPModules();
    }

    function ResetFTPModules()
    {
	FTPModules = ModuleInfo({size: 0});
    }
    
    function emit() onlyOwner public
    {

    }

    function AddAddress(address addx, uint coef, uint opID) onlyOwner public returns (bool)
    {
	if (canAddAddresses)
	{
	    uint i = FTPModules.size;
	    FTPmodules.module[i] = addx;
	    FTPmodules.coef[i] = coef;
	    FTPmodules.opId[i] = opID;
	    FTPmodules.opIdIndex[opID] = i;
	    ++FTPModules.size;
	    AddressAdded(addx, opID, coef);
	    return true;
	}
	else
	{
	    CanNotAddAddress(msg.sender, "Can not add new module address", "");
	    return false;
	}
    }
    
    function ListAddresses()
    {
	for (uint i = 0; i < FTPmodules.size; ++i)
	{
	    AddressList(FTPmodules.module[i], FTPmodules.opId[i], FTPmodules.coef[i]);
	}
    }

    function EraseCoefs() onlyOwner public
    {

    }

    function StartAddingAdresses() onlyOwner public
    {
	canAddAddresses = true;
	AddingAddressesActivated(msg.sender, "Now FTP contract can add new Addresses", "");
    }

    function ResetEmissionAdresses() onlyOwner public
    {

    }

    function StopAddingAdresses() onlyOwner public
    {
	canAddAddresses = false;
	AddingAddressesDeactivated(msg.sender, "From now FTP contract can not add new addresses", "");
    }
}
