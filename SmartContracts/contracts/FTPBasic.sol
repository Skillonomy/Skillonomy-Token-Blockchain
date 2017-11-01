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

    function strConcat(string _a, string _b, string _c, string _d) internal returns (string) {
	return strConcat(_a, _b, _c, _d, "");
    }

    function strConcat(string _a, string _b, string _c) internal returns (string) {
	return strConcat(_a, _b, _c, "", "");
    }

    function strConcat(string _a, string _b) internal returns (string) {
	return strConcat(_a, _b, "", "", "");
    }
    
    AddxUintMapping.itmap internal addx_coefs;
    AddxUintMapping.itmap internal addx_opID;
    
    using AddxUintMapping for AddxUintMapping.itmap;
    
    bool canAddAddresses = false;

    event AddressAdded(address addx, string message, string dummy);
    event CanNotAddAddress(address addx, string message, string dummy);
    event AddingAddressesActivated(address addx, string message, string dummy);
    event AddingAddressesDeactivated(address addx, string source, string message);

    function FTPBasic()
    {

    }

    function emit() onlyOwner public
    {

    }

    function AddAddress(address addx, uint coef, uint opID) onlyOwner public returns (bool)
    {
	if (canAddAddresses)
	{
	    AddressAdded(msg.sender, "Debug 1", "");
	    AddxUintMapping.insert(addx_coefs, addx, coef);
	    AddressAdded(msg.sender, "Debug 2", "");
//	    AddxUintMapping.insert(addx_opID, addx, opID);
    	    AddressAdded(msg.sender, "Debug 3", "");
//	    AddressAdded(addx, new string(opID), new string(coef));// strConcat ("Added:", new string(opID)), strConcat("  coeficient: ", new string(coef)));
	    AddressAdded(msg.sender, "Debug 4", "");
	    return true;
	}
	else
	{
	    CanNotAddAddress(msg.sender, "Can not add new module address", "");
	    return false;
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
