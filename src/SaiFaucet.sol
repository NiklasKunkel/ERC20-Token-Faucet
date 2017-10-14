pragma solidity ^0.4.15;

import "ds-note/note.sol";
import "ds-auth/auth.sol";
import "ds-token/token.sol";

contract Faucet is DSAuth, DSNote {
	DSToken token;
	mapping(address => bool) public hasClaimed;

	function Faucet(DSToken _token) public {
		token = _token;
	}

	modifier isNewUser() {
		if (hasClaimed[msg.sender]) {
			revert();
		}
		_;
	}

	function deposit(uint wad) public returns (bool) {
		bool ok = token.transferFrom(msg.sender, this, wad);
		if (!ok) {
			revert();
		}
		return true;
	}

	function drip() public note isNewUser {
		hasClaimed[msg.sender] = true;
		bool ok = token.transfer(msg.sender, 25);
		if (!ok) {
			revert();
		}
	}

	function resetUserAllocation(address user) note public auth {
		hasClaimed[user] = false;
	}
}
