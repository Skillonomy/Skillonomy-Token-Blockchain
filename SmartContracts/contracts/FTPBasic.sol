pragma solidity ^0.4.4;

import "./token/MintableToken.sol";
import "./payment/PullPayment.sol";
import "./AddxUintMapping.sol";
import "./libs/StringLib.sol";

contract FTPBasic is MintableToken, PullPayment
{


    AddxUintMapping.itmap internal addx_coefs;
    AddxUintMapping.itmap internal addx_opID;

    bool canAddAddresses = false;

    event AddressAdded(address addx, string messsage, string dummy);
    event CanNotAddAddress(address addx, string message, string dummy);
    event AddingAddressesActivated(address addx, string message, string dummy);
    event AddingAddressesDeactivated(address addx, string source, string massage);

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
	    AddxUintMapping.insert(addx_coefs, addx, coef);
	    AddxUintMapping.insert(addx_opID, addx, opID);
	    AddressAdded(addx, "Added:" + StringUtils.uintToBytes(opID) + " + coeficient: " + StringUtils.uintToBytes(coef));
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
