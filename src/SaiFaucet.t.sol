pragma solidity ^0.4.15;

import "ds-test/test.sol";

import "./SaiFaucet.sol";

contract SaiFaucetTest is DSTest {
    SaiFaucet faucet;

    function setUp() {
        faucet = new SaiFaucet();
    }

    function testFail_basic_sanity() {
        assertTrue(false);
    }

    function test_basic_sanity() {
        assertTrue(true);
    }
}
