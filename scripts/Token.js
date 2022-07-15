const { ethers } = require("hardhat");

async function main(){
    const[delployer] =await ethers.getSigner();

    const Token =await ethers.getContractFactory("Token");
    const token =await Token.deploy();
    console.log("Token address : ", token.owner);
}

main().
then(()=>process.exit(0)).
catch((error)=>{
    console.error(error);
    process.exit(1);
});