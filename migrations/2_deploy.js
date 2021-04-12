const firebase = require("firebase/app");
require("firebase/firestore");



const firebaseConfig = {
  apiKey: "AIzaSyDhNK0gk_s9JIbrQ1TP8wFyfb05iikPpV8",
  authDomain: "dapp-voting-bb064.firebaseapp.com",
  projectId: "dapp-voting-bb064",
  storageBucket: "dapp-voting-bb064.appspot.com",
  messagingSenderId: "613355769821",
  appId: "1:613355769821:web:16c9c920ba528279aef034"
};
// Initialize Firebase
firebase.initializeApp(firebaseConfig);


const db = firebase.firestore();

const candidatesRef = firebase.firestore().collection('candidates');




const VotingContract = artifacts.require("Voting");
  
module.exports = function async (deployer) {

  
  var yes = true


const getData = async () => {
    
  var can_ids = []; 
  var cand = await candidatesRef 
  .get()
  .then((snapshot) => {
    var data = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
    console.log("Your data1", data); 
     can_ids = data.map((x) => (
    x["id"] 
  ));
  console.log("Your data2", can_ids); 
    yes = false ;
    
    // [ { id: 'glMeZvPpTN1Ah31sKcnj', title: 'The Great Gatsby' } ]
  });
  return can_ids ;
}

var idss = getData() ;

  var i =0 ;
  // while(yes && i< 50) {
  //   console.log("Ahello", cand); 
  //   console.log("Yes" , yes) ;
  //   i++ ;
  // }
  console.log("Your data3" , idss) ;
  deployer.deploy(VotingContract,idss);
  
};

