pragma solidity ^0.4.15;

import "ds-note/note.sol";
import "ds-auth/auth.sol";

contract Faucet is DSAuth, DSNote {
	ERC20 token;	//this might need to be a ds-token
	mapping(address => bool) hasClaimed;

	function Faucet(ERC20 _token) {
		token = _token;
	}

	//modifier to check if account has already pulled from faucet 
	modifier isNewUser() {
		if (hasClaimed[msg.sender]) {
			throw;						//user has already drawn SAI from faucet 
		}
		_;
	}

	//function to deposit SAI into faucet
	function deposit() public {
		var ok = token.transferFrom(msg.sender, this);	//not sure if this is right syntax
		if (!ok) {
			revert();
		}
	}

	//function to pull SAI from faucet
	function drip() public note isNewUser {
		hasClaimed[msg.sender] = true;
		var ok = token.transfer(msg.sender, 25);			//how does 25 amount work with decimals of SAI
		if (!ok) {
			revert();
		}
	}

	//function to reset user permission to pull more sai 
	function resetUserAllocation(address user) public auth {
		hasClaimed[user] = false;
	}
}
