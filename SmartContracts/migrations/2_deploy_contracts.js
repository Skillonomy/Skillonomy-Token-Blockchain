var ConvertLib = artifacts.require("./ConvertLib.sol");
var Ownable = artifacts.require("./ownership/Ownable.sol");
var StandardToken = artifacts.require("./token/StandardToken.sol");
var ERC20 = artifacts.require("./token/ERC20.sol")
var ERC20Basic = artifacts.require("./token/ERC20Basic.sol")
var BasicToken = artifacts.require("./token/BasicToken");
var SafeMath = artifacts.require("./math/SafeMath.sol");
var FTPBasic = artifacts.require("./FTPBasic.sol");
var Ownable = artifacts.require("./ownership/Ownable.sol");

module.exports = function(deployer) {
//    deployer.deploy(ERC20Basic, {gas: 4712387});
//    deployer.deploy(ERC20, {gas: 4712387});
//    deployer.deploy(BasicToken, {gas: 4712387});
//    deployer.deploy(StandardToken, {gas: 4712387});
      deployer.deploy(SafeMath, {gas: 4712387});
      deployer.deploy(FTPBasic, {gas: 4712387});
      deployer.link(FTPBasic, SafeMath);
//    deployer.deploy(Ownable, {gas: 4712387});
//    deployer.link(BasicToken, ERC20Basic, SafeMath);
//    deployer.link(ERC20, ERC20Basic);
//    deployer.link(StandardToken, BasicToken, ERC20);
//    deployer.link(FTPBasic, Ownable, StandardToken, SafeMath);
};
