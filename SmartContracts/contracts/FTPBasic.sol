pragma solidity ^0.4.4;

import "./math/SafeMath.sol";
import "./token/StandardToken.sol";
import "./ownership/Ownable.sol";
import "./token/MintableToken.sol";

contract FTPBasic is StandardToken, Ownable, MintableToken
{
	using SafeMath for uint256;

	function strConcat(string _a, string _b, string _c, string _d, string _e) internal returns (string)
	{
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
	
	function bytes32ToString (bytes32 data) returns (string)
	{
		bytes memory bytesString = new bytes(32);
		for (uint j=0; j<32; j++) {
			byte char = byte(bytes32(uint(data) * 2 ** (8 * j)));
			if (char != 0) {
				bytesString[j] = char;
			}
		}

		return string(bytesString);
  	}
	
	function uintToBytes32(uint256 x) returns (bytes32 b)
	{
		assembly { mstore(add(b, 32), x) }
	}

	function uintToString(uint number) returns (string)
	{
		bytes32 bx32 = uintToBytes32(number);
		return bytes32ToString(bx32);
	}

	function strConcat(string _a, string _b, string _c, string _d) internal returns (string)
	{
		return strConcat(_a, _b, _c, _d, "");
	}

	function strConcat(string _a, string _b, string _c) internal returns (string)
	{
		return strConcat(_a, _b, _c, "", "");
	}

	function strConcat(string _a, string _b) internal returns (string)
	{
		return strConcat(_a, _b, "", "", "");
	}
	
	struct ModuleInfo
	{
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
	event ErrorAddingAddress(address addx, string errorMessage, uint opId);
	event ModuleTokenEmmited(address addx, uint opId, uint amount);
	event ProductiveActionError(address addx, uint opId, string message);
	
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
		for (uint i = 0; i < FTPModules.size; ++i)
		{
			coef_sum += FTPModules.coef[i];
		}
		
		if (coef_sum > 0)
		{
			for (i = 0; i < FTPModules.size; ++i)
			{
				address mAddress = FTPModules.module[i];
				uint opID = FTPModules.opId[i];
				uint256 module_emission_amount = emission_amount.mul(FTPModules.coef[i]);
				module_emission_amount = module_emission_amount / coef_sum;
				mint(mAddress, module_emission_amount);
				//totalSupply = totalSupply.add(module_emission_amount);
				//balances[mAddress] += module_emission_amount;
				ModuleTokenEmmited(mAddress, opID, module_emission_amount);	
			}
		}

	}

	function __AddAddress(address addx, uint coef, uint opID) internal
	{
		uint i = FTPModules.size;
		FTPModules.module[i] = addx;
		FTPModules.coef[i] = coef;
		FTPModules.opId[i] = opID;
		FTPModules.opIdIndex[opID] = i;
		++FTPModules.size;
		AddressAdded(addx, opID, coef);
	}

	function AddAddress(address addx, uint coef, uint opID) onlyOwner public returns (bool)
	{
		if (canAddAddresses) {
			if (FTPModules.size == 0) {
				__AddAddress(addx, coef, opID);
				return true;
			} else if ((FTPModules.opId[FTPModules.opIdIndex[opID]] != opID)) {
				__AddAddress(addx, coef, opID);
				return true;
			}
			ErrorAddingAddress(msg.sender, "Operation already exist",opID);
			return false;
		} else {
			CanNotAddAddress(msg.sender, "Adding addresses is not allowed", "");
			return false;
		}
	}

	function ListAddresses() onlyOwner public
	{
		for (uint i = 0; i < FTPModules.size; ++i) {
			AddressList(FTPModules.module[i], FTPModules.opId[i], FTPModules.coef[i]);
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
	
	function ProductiveAction(address module_address, uint opId, address destination) public
	{
		if (msg.sender == module_address) {
			uint mIndex = FTPModules.opIdIndex[opId];
			address mModule = FTPModules.module[mIndex];

			if (mModule == module_address) {
				uint256 mBalance = balances[module_address];
					uint256 tAmount = mBalance/10000;
				transferFrom(module_address, destination, tAmount);
			} else {
				ProductiveActionError(module_address, opId, "Invalid address for current operation ID");
			}
		}
	}
}
