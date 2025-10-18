const Sequelize=require('sequelize');
const sequelize=require('../util/db.js');


const Maintenance=sequelize.define('Maintenance',{
Id:{
    type:Sequelize.INTEGER,
    allowNull:false,
    autoIncrement:true,
    primaryKey:true
},
StartDateNoTime:{
    type:Sequelize.TEXT,
    allowNull:false
},
EndDateNoTime:{
    type:Sequelize.TEXT,
    allowNull:false
},
StartDate:{
    type:Sequelize.STRING,
    allowNull:false
},
EndDate:{
    type:Sequelize.STRING,
    allowNull:false
},
Duration: {
    type: Sequelize.INTEGER,
    allowNull: true 
},
Description:{
    type:Sequelize.TEXT,
    allowNull:false
}


})
module.exports=Maintenance