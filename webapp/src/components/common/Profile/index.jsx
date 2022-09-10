import React from 'react';
import { connect } from 'react-redux';
import { useHistory } from 'react-router';
import './styles.css';

const Profile = ({ cartCount }) => {
  const history = useHistory();
  return (
    <div className='profilebutton' onClick={() => history.push('/dashboard')}>
      <i class='fas fa-user'></i>
    </div>
  );
};


export default Profile;
