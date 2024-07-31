// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Faucet {

    function withdraw(uint amount) public {
        require(amount<=100000000000000000);
        msg.sender.transfer(amount);
    }

   fallback() external payable { }
   receive() external payable { }
}
