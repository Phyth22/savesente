import { DataTypes } from "sequelize";
import sequelize from "../config/database.js";
import transactions from "./transactions.js";


const wallets = sequelize.define('wallets', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  user_id: {
    type: DataTypes.UUID,
    allowNull: false,
    references: {
      model: 'user',
      key: 'id',
    }
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false
  },
  bitnob_wallet_id: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  bitnob_address: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  withdrawal_date: {
  type: DataTypes.DATEONLY,
  allowNull: true,
  set(value) {
    if (value === '' || value === null || value === undefined) {
      this.setDataValue('withdrawal_date', null);
    } else {
      this.setDataValue('withdrawal_date', value);
    }
  }
},
  total_amount: {
    type: DataTypes.DECIMAL(18, 8),
    defaultValue: 0.0,
  },
  balance: {
    type: DataTypes.DECIMAL(18, 8),
    defaultValue: 0.0,
  },
  status: {
    type: DataTypes.ENUM('active', 'locked', 'withdrawn'),
    defaultValue: 'active',
  },
   createdAt: {
    allowNull: false,
    type: DataTypes.DATE
  },
  updatedAt: {
    allowNull: false,
    type: DataTypes.DATE
  },
}, {
  modelName: 'wallets',
  tableName: 'wallets',
  timestamps: true,
  freezeTableName: true,
});

wallets.hasMany(transactions, { foreignKey: 'wallet_id' });
transactions.belongsTo(wallets, { foreignKey: 'wallet_id' });

export default wallets;