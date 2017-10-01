pragma solidity ^0.4.4;

import "./token/MintableToken.sol";
import "./payment/PullPayment.sol";
//import "./library/AddxUintMapping.sol";

library AddxUintMapping
{

  struct itmap
  {
    mapping(address => IndexValue) data;
    KeyFlag[] keys;
    uint size;
  }

  struct KeyFlag {
    address key;
    bool deleted;
  }
  struct IndexValue { uint keyIndex; uint value; }
 

  function insert(itmap storage self, address key, uint value) returns (bool replaced)
  {
    uint keyIndex = self.data[key].keyIndex;
    self.data[key].value = value;
    if (keyIndex > 0)
      return true;
    else
    {
      keyIndex = self.keys.length++;
      self.data[key].keyIndex = keyIndex + 1;
      self.keys[keyIndex].key = key;
      self.size++;
      return false;
    }
  }
  
  function remove(itmap storage self, address key) returns (bool success)
  {
    uint keyIndex = self.data[key].keyIndex;
    if (keyIndex == 0)
      return false;
    delete self.data[key];
    self.keys[keyIndex - 1].deleted = true;
    self.size --;
  }
  
  function contains(itmap storage self, address key) returns (bool)
  {
    return self.data[key].keyIndex > 0;
  }
  
  function iterate_start(itmap storage self) returns (uint keyIndex)
  {
    return iterate_next(self, uint(-1));
  }
  
  function iterate_valid(itmap storage self, uint keyIndex) returns (bool)
  {
    return keyIndex < self.keys.length;
  }
  
  function iterate_next(itmap storage self, uint keyIndex) returns (uint r_keyIndex)
  {
    keyIndex++;
    while (keyIndex < self.keys.length && self.keys[keyIndex].deleted)
      keyIndex++;
    return keyIndex;
  }
  
  function iterate_get(itmap storage self, uint keyIndex) returns (address key, uint value)
  {
    key = self.keys[keyIndex].key;
    value = self.data[key].value;
  }
}


contract FTPBasic is MintableToken, PullPayment
{

    AddxUintMapping.itmap internal addx_coefs;
    bool cadAddAddresses = false;

    function FTPBasic()
    {

    }

    function emit() onlyOwner public
    {

    }

    function AddAddress(address, uint) onlyOwner public 
    {

    }

    function EraseCoefs() onlyOwner public
    {

    }

    function StartAddingAdresses() onlyOwner public
    {

    }

    function ResetEmissionAdresses() onlyOwner public
    {

    }

    function StopAddingAdresses() onlyOwner public
    {

    }

}