pragma solidity ^0.4.4;

import "./token/MintableToken.sol";
import "./payment/PullPayment.sol";

contract FTPBasic is MintableToken, PullPayment
{

    mapping (address => uint) internal addx_coefs;

    function FTPBasic()
    {

    }

    function emmit() onlyOwner public
    {

    }

    function AddAddress(address, uint) onlyOwner public 
    {
    
    }

}