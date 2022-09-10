import React, { useEffect, useState } from "react";
import { Link, useHistory } from "react-router-dom";
import { auth, logInWithEmailAndPassword, signInWithGoogle } from "../../fireabse";
import { useAuthState } from "react-firebase-hooks/auth";
import "./Login.css";
import Loading from "../Loading/Loading";
function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [user, loading, error] = useAuthState(auth);
  const navigate = useHistory();
  const [isLoading, setIsLoading] = useState(false)
  useEffect(() => {
    if (loading) {
      console.log("loading...")
      // maybe trigger a loading screen
      setIsLoading(true)
      return ;
    }
    if (user){ 
      setIsLoading(false)
      navigate.push("/");
    }
    if (!loading) {
      setIsLoading(false)
      return ;
    }
  }, [user, loading]);
  return (
  <div className="login">
    {   
        isLoading&&<div className="spinner-container"><Loading/></div>
    }
    {   
        !isLoading&&
        <div className="login">
          
      <div className="login__container">
        <h1>Login</h1>
        <br></br>
        <input
          type="text"
          className="login__textBox"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="E-mail Address"
        />
        <input
          type="password"
          className="login__textBox"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          placeholder="Password"
        />
        <button
          className="login__btn"
          onClick={() => logInWithEmailAndPassword(email, password)}
        >
          Login
        </button>
        <button className="login__btn login__google" onClick={signInWithGoogle}>
          Login with Google
        </button>
        <div>
          <Link to="/reset">Forgot Password</Link>
        </div>
        <div>
          Don't have an account? <Link to="/register">Register</Link> now.
        </div>
      </div>
    </div>
    }
    
  </div>
  );
}
export default Login;