pragma solidity ^0.4.4;

import "./math/SafeMath.sol";
import "./token/StandardToken.sol";
import "./ownership/Ownable.sol";
import "./token/MintableToken.sol";

contract FTPBasic is StandardToken, Ownable, MintableToken
{
	using SafeMath for uint256;
	
	struct ModuleInfo
	{
		uint size;
		mapping (uint => uint) coef;
		mapping (uint => address) module;
	}

	ModuleInfo FTPModules;

	bool canAddAddresses = false;

	event AddressAdded(address addx, uint coeficient);
	event CanNotAddAddress(address addx, string message);
	event AddingAddressesActivated(address addx, string message);
	event AddingAddressesDeactivated(address addx, string source);
	event AddressList(address addx, uint coeficient);
	event ModuleTokenEmmited(address addx, uint amount);
	
	function FTPBasic()
	{
		ResetFTPModules();
		balances[msg.sender].add(10000000000000);
	}

	function ResetFTPModules()
	{
		FTPModules = ModuleInfo({size: 0});
	}
	
	function emit() onlyOwner public
	{
		uint256 coef_sum = 0;
		uint256 emission_amount = 1000000000000;

		for (uint i = 0; i < FTPModules.size; ++i) {
			coef_sum += FTPModules.coef[i];
		}
		
		if (coef_sum > 0) {
			for (i = 0; i < FTPModules.size; ++i) {
				address mAddress = FTPModules.module[i];
				uint256 module_emission_amount = emission_amount.mul(FTPModules.coef[i]);
				module_emission_amount = module_emission_amount / coef_sum;
				mint(mAddress, module_emission_amount);
				ModuleTokenEmmited(mAddress, module_emission_amount);
			}
		}
	}

	function __AddAddress(address addx, uint coef) internal
	{
		uint i = FTPModules.size;
		FTPModules.module[i] = addx;
		FTPModules.coef[i] = coef;
		++FTPModules.size;
		AddressAdded(addx, coef);
	}

	function AddAddress(address addx, uint coef) onlyOwner public returns (bool)
	{
		if (canAddAddresses) {
			__AddAddress(addx, coef);
			return true;
		} else {
			CanNotAddAddress(msg.sender, "Adding addresses is not allowed");
			return false;
		}
	}

	function ListAddresses() onlyOwner public
	{
		for (uint i = 0; i < FTPModules.size; ++i) {
			AddressList(FTPModules.module[i], FTPModules.coef[i]);
		}
	}

	function StartAddingAdresses() onlyOwner public
	{
		canAddAddresses = true;
		AddingAddressesActivated(msg.sender, "Now FTP contract can add new Addresses");
	}

	function StopAddingAdresses() onlyOwner public
	{
		canAddAddresses = false;
		AddingAddressesDeactivated(msg.sender, "From now FTP contract can not add new addresses");
	}
	
	function ProductiveAction(address _to) public
	{
		uint256 balance = balances[msg.sender];
		uint256 amount = balance/10000;

	    balances[msg.sender] = balances[msg.sender].sub(amount);
    	balances[_to] = balances[_to].add(amount);

		Transfer(msg.sender, _to, amount);
	}
}