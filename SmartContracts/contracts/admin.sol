[21~pragma solidity ^0.4.2;

contract admin {
     // VARIABLES
     struct user {
          address addr;
          string name;
          string desc;
     }

     user owner;
     mapping (address => user) adminInfo;
     mapping (address => bool) isAdmin;

     function admin (string _name, string _desc) {
          owner = user({
               addr : msg.sender,
               name : _name,
               desc : _desc
          });

          isAdmin[msg.sender] = true;
          adminInfo[msg.sender] = owner;
     }
     
     event adminAdded(address _address, string _name, string _desc);
     event adminRemoved(address _address, string _name, string _desc);
     event moneySend(address _address, uint _amount);

     function addAdmin (address _address, string _name, string _desc) {
          if (owner.addr != msg.sender || isAdmin[_address]) throw;   

          isAdmin[_address] = true;
          adminInfo[_address] = user({addr : _address, name : _name, desc : _desc});

          adminAdded(
              _address,
              _name,
              _desc
          );
     }

     function removeAdmin (address _address) {
          if (owner.addr != msg.sender || !isAdmin[_address]) throw;

          isAdmin[_address] = false;
          adminRemoved(
              _address,
              adminInfo[_address].name,
              adminInfo[_address].desc
          );
          delete adminInfo[_address];
     }

     function getMoneyOut(address _receiver, uint _amount) {
          if (owner.addr != msg.sender || _amount <= 0 || this.balance < _amount) throw;

          if (_receiver.send(_amount)) moneySend(_receiver, _amount); 
     }

     function killContract () {
          if (owner.addr != msg.sender) throw;
          selfdestruct(owner.addr);
     }
     
}