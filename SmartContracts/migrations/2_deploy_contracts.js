var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var AddxUintMapping = artifacts.require("./AddxUintMapping.sol");
var FTPBasic = artifacts.require("./FTPBasic.sol");
var Ownable = artifacts.require("./ownership/Ownable.sol");
var MintableToken = artifacts.require("./token/MintableToken.sol");
var PullPayment = artifacts.require("./payment/PullPayment.sol");
var admin = artifacts.require("./admin.sol");

module.exports = function(deployer) {
    deployer.deploy(ConvertLib);
    deployer.link(ConvertLib, MetaCoin);
    deployer.deploy(MetaCoin);
    deployer.deploy(AddxUintMapping);
    deployer.deploy(MintableToken);
    deployer.deploy(PullPayment);
    deployer.link(PullPayment, FTPBasic);
    deployer.link(AddxUintMapping, FTPBasic);
    deployer.link(MintableToken, FTPBasic);
    deployer.deploy(FTPBasic);
    deployer.deploy(admin);
};
