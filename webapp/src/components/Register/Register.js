import React, { useEffect, useState } from "react";
import { useAuthState } from "react-firebase-hooks/auth";
import { Link, useHistory } from "react-router-dom";
import {
  auth,
  registerWithEmailAndPassword,
  signInWithGoogle,
} from  "../../fireabse";
import "./Register.css";
function Register() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [name, setName] = useState("");
  const [user, loading, error] = useAuthState(auth);
  const [invalidEmail, setInvalidEmail] = useState(false)
  const [invalidPassword, setInvalidPassword] = useState(false)
  const history = useHistory();
  const register = () => {
    if (!name) alert("Please enter name");
    if(invalidEmail){
      alert("Please enter valid email");
      return
    }
    if(invalidPassword){
      alert("Please enter valid password");
      return
    }
    registerWithEmailAndPassword(name, email, password);
  };
  useEffect(() => {
    if (loading) return;
    if (user) history.push("/dashboard");
  }, [user, loading]);

  useEffect(() => {
    setInvalidEmail(false)
    if(email!="") 
      if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)))
        setInvalidEmail(true)
      else
        setInvalidEmail(false)
    
  }, [email]);

  useEffect(() => {
    setInvalidPassword(false)
    if (password!="") 
      if(!(/^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,16}$/.test(password)))
        setInvalidPassword(true)
      else
        setInvalidPassword(false)
    
  }, [password]);


  return (
    <div className="register">
      <div className="register__container">
        <h1>Register</h1>
        <br></br>
        <input
          type="text"
          className="register__textBox"
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="Full Name"
        />
        <input
          type="text"
          className="register__textBox"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="E-mail Address"
        />
        {
          invalidEmail&&
          <span className="error_span">Please Enter Valid Email </span>
        }
        <input
          type="password"
          className="register__textBox"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          placeholder="Password"
        />
        {
          invalidPassword&&
          <div>
            <span className="error_span">Password should contain Minimum 8 Characters,</span>
            <br></br>
            <span className="error_span">1 Lower Case,1 Upper Case,1 Symbol </span>
          </div>
        }
        
        <button className="register__btn" onClick={register}>
          Register
        </button>
        <button
          className="register__btn register__google"
          onClick={signInWithGoogle}
        >
          Register with Google
        </button>
        <div>
          Already have an account? <Link to="/">Login</Link> now.
        </div>
      </div>
    </div>
  );
}
export default Register;