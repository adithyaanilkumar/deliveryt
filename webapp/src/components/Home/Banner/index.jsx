import React from 'react';
import './styles.css';
import bannerImg from './banner.png';
import Logo from '../../common/Logo';

const Banner = ({ handleScrollMenu }) => (
  <header className='home-page'>
    <div className='header-content'>
      <Logo />
      <div className='content-main'>
        <h1>Delicious Homemade food for your cravings</h1>
        <p>Get Lipsmakcing Homemade Delicacies from the comfort of your home </p>
        <button onClick={handleScrollMenu}>
          View Menu <i className='fas fa-long-arrow-alt-right'></i>
        </button>
      </div>
    </div>
    <img className='header-img' src={bannerImg} alt='banner' />
  </header>
);

export default Banner;
