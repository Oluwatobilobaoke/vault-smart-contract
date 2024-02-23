// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;


error INSUFFICIENT_FUNDS();
error AMOUNT_CANT_BE_ZERO();
error GRANT_AMOUNT_MUST_EQUAL_DEPOSIT();
error CLAIM_TIME_NOT_REACHED();
error CLAIM_TIME_MUST_BE_IN_FUTURE();
error GRANT_CLAIMED();
error ADDRESS_CANT_BE_ZERO();


contract GrantVaultAdvance {

  address owner;

    struct Grant {
        uint256 id;
        address beneficiary;
        uint256 amount;
        uint256 claimTime;
        bool claimed;
    }

    Grant[] allGrants;

    mapping(uint256 => Grant) grants;

    uint256 nextId;

    event GrantCreated(address indexed donor, address indexed beneficiary, uint256 amount, uint256 claimTime);

    event GrantClaimed(address indexed beneficiary, uint256 amount);

    // Function to create a grant
    function createGrant(address beneficiary, uint256 amount, uint256 claimTime) external payable {
         nextId++;

        if(msg.sender == address(0))
          revert ADDRESS_CANT_BE_ZERO();

        if (amount<= 0 )
          revert AMOUNT_CANT_BE_ZERO();
        
        if (msg.value != amount) 
          revert GRANT_AMOUNT_MUST_EQUAL_DEPOSIT();

        if (claimTime < block.timestamp) 
            revert CLAIM_TIME_MUST_BE_IN_FUTURE();

        Grant storage grant = grants[nextId];

        allGrants.push(grant);
      
          
        grants[nextId] = Grant(nextId, beneficiary, amount, claimTime, false);

        emit GrantCreated(msg.sender, beneficiary, amount, claimTime);
    }

    // Function for beneficiary to claim their grant
    function claimGrant(uint256 grantId) external {
        Grant storage grant = grants[grantId];

        if (grant.claimed)
            revert GRANT_CLAIMED();

        if(block.timestamp <= grant.claimTime)
          revert CLAIM_TIME_NOT_REACHED();

        payable(msg.sender).transfer(grant.amount);
        grant.claimed = true;

        emit GrantClaimed(msg.sender, grant.amount);
    }

    function getBeneficiaryGrant(uint256 grantId) external view returns (uint256 id, address beneficiary, uint256 amount, uint256 claimTime, bool claimed){
        Grant storage grant = grants[grantId];
        return (grant.id, grant.beneficiary, grant.amount, grant.claimTime, grant.claimed);
    }

    function ownerWithdraw() external onlyOwner payable {
      
      uint balance = address(this).balance;

      if (balance <= 0) 
        revert INSUFFICIENT_FUNDS();

      payable(owner).transfer(balance);
    }

    function checkContractBal() external view returns (uint256) {
      return address(this).balance;
    }


    function getAllGrants() external view returns (Grant[] memory) {
        return allGrants;
    }


    modifier onlyOwner() {
      require(msg.sender == owner);
      _;
    }
}
