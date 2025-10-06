let web3;
let contract;
const contractAddress = "YOUR_DEPLOYED_CONTRACT_ADDRESS"; // Replace after deployment
const contractABI = [
  // Add ABI after deployment from Remix IDE
];

window.addEventListener('load', async () => {
  if (window.ethereum) {
    web3 = new Web3(window.ethereum);
  } else {
    alert("Please install MetaMask!");
  }

  document.getElementById("connectBtn").onclick = async () => {
    const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
    document.getElementById("account").innerText = "Connected: " + accounts[0];
    contract = new web3.eth.Contract(contractABI, contractAddress);
  };

  document.getElementById("executeBtn").onclick = async () => {
    const accounts = await web3.eth.getAccounts();
    await contract.methods.execute().send({ from: accounts[0] });
    alert("Contract executed successfully!");
  };

  document.getElementById("destroyBtn").onclick = async () => {
    const accounts = await web3.eth.getAccounts();
    await contract.methods.destroyContract().send({ from: accounts[0] });
    alert("Contract destroyed successfully!");
  };
});
