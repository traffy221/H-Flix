import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyAG0ptK5hRO75a8MTuTTeXQGHLIqn4ltwo",
  authDomain: "h-flix.firebaseapp.com",
  projectId: "h-flix",
  storageBucket: "h-flix.appspot.com",
  messagingSenderId: "16499338794",
  appId: "1:16499338794:web:11b2a3e673b1d8f7e6dd53"
};



// Initialize Firebase
const app = initializeApp(firebaseConfig);

export const db = getFirestore(app);
