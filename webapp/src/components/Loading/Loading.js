import React from "react";
import { GooSpinner } from "react-spinners-kit";

const Loading = () =>{
    return (
        <div className="loading-screen">
            <GooSpinner className="spinner-loader" size={125} color="#000000"  loading={true} />
        </div>
        
    )
}
 export default Loading