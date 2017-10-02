pragma solidity ^0.4.4;

import "./token/MintableToken.sol";
import "./payment/PullPayment.sol";
import "./AddxUintMapping.sol";

contract FTPBasic is MintableToken, PullPayment
{


    AddxUintMapping.itmap internal addx_coefs;
    AddxUintMapping.itmap internal addx_opID;

    bool canAddAddresses = false;

    event AddressAdded(address addx, uint opID);
    
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
	    AddressAdded(msg.sender, opID);
	    return true;
	
	}
	else return false;
    }

    function EraseCoefs() onlyOwner public
    {

    }

    function StartAddingAdresses() onlyOwner public
    {
	canAddAddresses = true;
    }

    function ResetEmissionAdresses() onlyOwner public
    {

    }

    function StopAddingAdresses() onlyOwner public
    {
	canAddAddresses = false;
    }

}