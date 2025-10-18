// modules/dashbord.js
/*
const Sequelize = require('sequelize');
const sequelize = require('../util/db.js');

const Dashboard = sequelize.define('Dashboard', {
  Code: {
    type:Sequelize.INTEGER,
    allowNull:false,
    autoIncrement:true,
    primaryKey:true
  }
  
});

module.exports = Dashboard;
*/

/*
const Sequelize = require('sequelize');
const sequelize = require('../util/db.js');

const Dashboard = sequelize.define('Dashboard', {
  Code: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  createdAt: {
    type: Sequelize.DATE,
    defaultValue: Sequelize.NOW,
  },
  updatedAt: {
    type: Sequelize.DATE,
    defaultValue: Sequelize.NOW,
  },
  MaintenanceId: {
    type: Sequelize.INTEGER,
    unique:true,
    references: {
      model: 'maintenances', // Nom de la table des maintenances
      key: 'Id'
    }
  },
  DepartmentCode: {
    type: Sequelize.INTEGER,
    unique:true,
    references: {
      model: 'departments', // Nom de la table des départements
      key: 'Code'
    }
  },
  WorkOrderCode: {
    type: Sequelize.INTEGER,
    unique:true,
    references: {
      model: 'work_orders', // Nom de la table des ordres de travail
      key: 'Code'
    }
  },
  BreakdownCode: {
    type: Sequelize.INTEGER,
    unique:true,
    references: {
      model: 'break_downs', // Nom de la table des pannes
      key: 'Code'
    }
  }
}, {
  tableName: 'dashbords' // Nom exact de la table
});

module.exports = Dashboard;
*/

const Sequelize = require('sequelize');
const sequelize = require('../util/db.js');

const Dashboard = sequelize.define('Dashboard', {
  Code: {
      type: Sequelize.INTEGER,
      autoIncrement: true,
      primaryKey: true
  },
  DepartmentCode: {
      type: Sequelize.STRING,
      allowNull: false
  },
  WorkOrderCode: {
      type: Sequelize.STRING,
      allowNull: true // Permet les valeurs NULL
  },
  BreakdownCode: {
      type: Sequelize.STRING,
      allowNull: true // Permet les valeurs NULL
  },
  MaintenanceId: {
      type: Sequelize.INTEGER,
      allowNull: true // Permet les valeurs NULL
  }
}, {
  timestamps: true,
  tableName: 'dashbords'
});

module.exports = Dashboard;