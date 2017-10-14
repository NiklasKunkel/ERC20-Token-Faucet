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
		if hasClaimed(msg.sender) {
			throw;						//user has already drawn SAI from faucet 
		}
		_;
	}

	//function to deposit SAI into faucet
	function deposit() {
		token.transferFrom(msg.sender, this);	//not sure if this is right syntax
	}

	//function to pull SAI from faucet
	function drip() note isNewUser returns () {
		token.transfer(msg.sender, 25)			//how does 25 amount work with decimals of SAI
	}

	//function to reset user permission to pull more sai 
	function resetUserAllocation(address user) auth {
		hasClaimed[user] = false;
		return true;
	}
}
