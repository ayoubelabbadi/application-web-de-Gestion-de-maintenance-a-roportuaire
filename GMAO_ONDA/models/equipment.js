const Sequelize=require('sequelize');
const sequelize=require('../util/db.js');


const Equipment=sequelize.define('Equipment',{
Code:{
    type:Sequelize.INTEGER,
    allowNull:false,
    primaryKey:true
},
Name:{
    type:Sequelize.STRING,
    allowNull:false
},
Image:{
    type:Sequelize.STRING,
    allowNull:true
},
Cost:{
    type:Sequelize.BIGINT(12),
    allowNull:false
},
Model:{
    type:Sequelize.STRING,
    allowNull:true
},
SerialNumber:{
    type:Sequelize.STRING,
    allowNull:false
},
InstallationDate:{
    type:Sequelize.TEXT,
    allowNull:false
},
ArrivalDate:{
    type:Sequelize.TEXT,
    allowNull:false
},
WarrantyDate:{
    type:Sequelize.TEXT,
    allowNull:true
},
Manufacturer:{
    type:Sequelize.TEXT,
    allowNull:true
},
Location:{
    type:Sequelize.STRING,
    allowNull:false
},
PM:{
    type:Sequelize.STRING,
    allowNull:false
},
Eqcontrat: {
    type:Sequelize.STRING,
    allowNull:true
  },
  Observation: {
    type:Sequelize.STRING,
    allowNull:true
  },
Notes:{
    type:Sequelize.TEXT,
    allowNull:true
}


})
module.exports=Equipment