const Sequelize=require('sequelize');
const sequelize=require('../util/db.js');


const Department=sequelize.define('Department',{
Code:{
    type:Sequelize.INTEGER,
    allowNull:false,
    primaryKey:true,
    unique:true
},
Name:{
    type:Sequelize.STRING,
    allowNull:false,
    unique:true
},
Location:{
    type:Sequelize.STRING,
    allowNull:false
},
TotalHoursP:{
    type: Sequelize.DECIMAL(10, 2),
    allowNull:true
},

Ponderation:{
    type: Sequelize.DECIMAL(10, 2),
    allowNull:true
},

Trp: {
    type: Sequelize.INTEGER,
    allowNull: true 
},








})
module.exports=Department