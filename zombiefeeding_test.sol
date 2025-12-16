pragma solidity >=0.5.0 <0.6.0;

import "./zombie_test.sol";

contract KittyInterface {
    function getKitty(uint256 _id) external view returns (
        bool isGestating, 
        bool isReady, 
        uint256 cooldownIndex, 
        uint256 nextActionAt, 
        uint256 siringWithId, 
        uint256 birthTime, 
        uint256 matronId, 
        uint256 sireId, 
        uint256 generation, 
        uint256 genes, 
    );
}

contract ZombieFeeding is ZombieFactory {

    address ckAddress = //write a made up address key ;
    KittyInterface kittyContract = KittyInterface(ckAddress); 

    function feedAndMultiply() public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus; 
        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna); 
    }

} 
