// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;






contract HowieToken is Ownable, ERC20 {
    
    
    // Mapping of addresses to locked status
    mapping(address => bool) private _locked;
    
    /**
     * @dev Emitted when locked status of `account` is set to true.
     */
    event Locked(address account_);
    
    /**
     * @dev Emitted when locked status of `account` is set to false.
     */
    event Unlocked(address account_);
    
    constructor() ERC20("HowieToken", "HT") {
        
        // Mint initial supply of 1,000,000 tokens under contract address
        mint(1000000);
    }
    
    /**
     * @dev See {IERC20-decimals}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 0;
    }
    
    /** @dev See {ERC20-_mint}.
     *
     * Sets locked status of 'account' to false, in case of new account
     */
    function _mint(address account_, uint256 amount_) internal virtual override {
        
        super._mint(account_, amount_);
        
        _locked[account_] = false;
    }
    
    /** @dev Creates `amount` tokens and assigns them to the contract, increasing the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     */
    function mint(uint256 amount_) public virtual {
        _mint(address(this), amount_);
    }
    
    /** @dev See {ERC20-_transfer}.
     *
     * Sets locked status of 'recipient' to false, in case of new account
     */
    function _transfer(address sender_, address recipient_, uint256 amount_) internal virtual override {
    
        super._transfer(sender_, recipient_, amount_);
        
        _locked[recipient_] = false;
    }
    
    
    /**
     * @dev Moves tokens `amount` from contract to `recipient`.
     */
    function transferTo(address recipient_, uint256 amount) public virtual returns (bool) {
        
        _transfer(address(this), recipient_, amount);

        return true;
    }
    
    /**
     * @dev See {ERC20-_burn}.
     */
    
    function burn(address account_, uint256 amount_) public virtual {
        
        _burn(account_, amount_);
    }
    
    
    /**
     * @dev Sets the locked status of 'account' to true.
     *
     * Emits a {Locked} event with the 'account' address.
     */
    function lock(address account_) public virtual {
        
        _locked[account_] = true;
        
        emit Locked(account_);
    }
    
    /**
     * @dev Returns the locked status of 'account'.
     */
    function isLocked(address account_) public view virtual returns (bool) {
        
        return _locked[account_];
    }
    
    /**
     * @dev Sets the locked status of 'account' to false.
     *
     * Emits a {Unlocked} event with the 'account' address.
     */
    function unlock(address account_) public virtual {
        
        _locked[account_] = false;
        
        emit Unlocked(account_);
    }
    
    
    /**
     * @dev See {ERC20-_beforeTokenTransfer}.
     *
     * Requirements:
     *
     * - The 'from' and 'to' accounts must not be locked.
     */
    function _beforeTokenTransfer(address from_, address to_, uint256 amount_) internal virtual override { 
        
        super._beforeTokenTransfer(from_, to_, amount_);
        
        require(!isLocked(from_), "HowieToken: token transfer while account locked");
        require(!isLocked(to_), "HowieToken: token transfer while account locked");
    }
    
}


