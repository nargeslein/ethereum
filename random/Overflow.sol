// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0; 

contract Overflow {
    function overflow() public view returns (uint8) {
        uint8 big = 255; //uint8 can only hold 256=2^8 unsigned integer values thus the numbers [0,...,255]
        big +=1; 
        //uint8 big = 255 +1 //this would have returned a compiler error message adding 1 by big+=1 works
        return big; //this returns 0 as overflow happens
    }


}
