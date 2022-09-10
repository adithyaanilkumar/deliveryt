import React, { useEffect, useState } from "react";
import { useAuthState } from "react-firebase-hooks/auth";
import { useHistory } from "react-router-dom";
import "./Dashboard.css";
import { auth, db, logout } from  "../../fireabse";
import { query, collection, getDocs, where } from "firebase/firestore";
function Dashboard() {
  const [user, loading, error] = useAuthState(auth);
  const [name, setName] = useState("");
  const [idToken, setIdToken] = useState("Not yet fetched")
  const navigate = useHistory();
  const fetchUserName = async () => {
    try {
      const q = query(collection(db, "users"), where("uid", "==", user?.uid));
      const doc = await getDocs(q);
      const data = doc.docs[0].data();
      setName(data.name);
    } catch (err) {
      console.error(err);
      alert("An error occured while fetching user data");
    }
  };
  const getIdTokenFirebase =  async () => {
    const IdToken = await user.getIdToken()
    console.log(IdToken)
    setIdToken(IdToken)
  };
  useEffect(() => {
    if (loading) return;
    if (!user) return navigate.push("/");
    fetchUserName();
  }, [user, loading]);
  return (
    <div className="dashboard">
       <div className="dashboard__container">
        Logged in as
         <div>{name}</div>
         <div>{user?.email}</div>
         <div>{idToken}</div>
         <button className="dashboard__btn" onClick={getIdTokenFirebase}>
          Get Id Token 
         </button>
         <button className="dashboard__btn" onClick={logout}>
          Logout
         </button>
       </div>
     </div>
  );
}
export default Dashboard;