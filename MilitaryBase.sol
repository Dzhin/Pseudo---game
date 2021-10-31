
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "GameObject.sol";
import "MilitaryUnit.sol";


contract MilitaryBase is GameObject{
    
    mapping(uint=>MilitaryUnit) baseWarriors;

    constructor() public {
        // Check that contract's public key is set
        require(tvm.pubkey() != 0, 101);
        // Check that message has signature (msg.pubkey() is not zero) and
        // message is signed with the owner's private key
        require(msg.pubkey() == tvm.pubkey(), 102);
        // The current smart contract agrees to buy some gas to finish the
        // current transaction. This actions required to process external
        // messages, which bring no value (henceno gas) with themselves.
        tvm.accept();

        setClass("База");
        setDefense(4);
        setDescription("Твоя база, которую нужно защитить любой ценой. Не может атаковать, но может создавать юнитов");
        setHp(5);
        setCurHp(5);
        setAttack(0);
    }
    function addMilitaryUnit(MilitaryUnit militaryUnit) external {
        tvm.accept();
        uint i=0;
        while(baseWarriors.exists(i)){
            i++;
        }
        baseWarriors[i]=militaryUnit;
    }
    function deleteMilitaryUnit(address militaryUnit) external {
        require(baseWarriors.exists(0),105);
        tvm.accept();
        uint key=0;
        address tmp;
        optional (uint, MilitaryUnit) NextUnit=baseWarriors.next(key);
        while (NextUnit.hasValue()){
            (key, tmp) = NextUnit.get();
            if(tmp==militaryUnit)
            {
                delete baseWarriors[key];
                break;
            }
            key++;
            NextUnit=baseWarriors.next(key);
    }
}
    
    function hurtYourself(uint v) external override{
        tvm.accept();
        if (v<=getDefense()) return;
        
        if (getCurHp()<=v-getDefense()){
            uint i=0;
            if(baseWarriors.exists(i)) baseWarriors[i].dieTogether(msg.sender, 666, true);
            optional(uint, address) nextUnit;
            while(baseWarriors.exists(i)){
            baseWarriors[i].dieTogether(msg.sender, 666, true);    
            i++;
            }
            toDie(msg.sender, 666, true);
            return;
        }
        setCurHp(getCurHp()-v+getDefense());
    }

}
