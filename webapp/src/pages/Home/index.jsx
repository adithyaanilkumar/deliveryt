import React, { useRef, useEffect } from 'react';
import ButtonCartCount from '../../components/common/ButtonCartCount';
import Profile from '../../components/common/Profile';
import Footer from '../../components/common/Footer';
import Banner from '../../components/Home/Banner';
import Menu from '../../components/common/Menu';
import { auth, db, logout } from  "../../fireabse";
import { useHistory } from "react-router-dom";
import { useAuthState } from "react-firebase-hooks/auth";
import { menuItemsData } from '../../components/common/Menu/data';

const Home = () => {
  const menuRef = useRef();
  const navigate = useHistory();
  const [user, loading, error] = useAuthState(auth);
  useEffect(() => {
    if (loading) return;
    if (!user) return navigate.push("/login");
    // fetchUserName();
  }, [user, loading]);
  const handleScrollMenu = () => {
    menuRef.current.scrollIntoView({ behavior: 'smooth' });
  };

  return (
    <div>
      <Banner handleScrollMenu={handleScrollMenu} />
      <Menu list={menuItemsData} ref={menuRef} />
      <Footer />
      <Profile/>
      <ButtonCartCount />
      
    </div>
  );
};

export default Home;
