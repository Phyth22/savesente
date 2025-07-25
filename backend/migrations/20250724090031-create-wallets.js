'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('wallets', {
      id: {
        type: Sequelize.UUID,
        defaultValue: Sequelize.UUIDV4,
        primaryKey: true,
      },
      user_id: {
      type: Sequelize.UUID,
      allowNull: false,
      references: {
        model: 'user',
        key: 'id',
      }
    },
      name: {
        type: Sequelize.STRING,
        allowNull: false
      },
      bitnob_wallet_id: {
        type: Sequelize.STRING,
        allowNull: true,
      },
      bitnob_address: {
        type: Sequelize.STRING,
        allowNull: true,
      },
      withdrawal_date: {
        type: Sequelize.DATEONLY,
        allowNull: true
      },
      total_amount: {
        type: Sequelize.DECIMAL(18,8),
        defaultValue: 0.0,
      },
      balance: {
        type: Sequelize.DECIMAL(18,8),
        defaultValue: 0.0,
      },
      status: {
        type: Sequelize.ENUM('active', 'locked', 'withdrawn'),
        defaultValue: 'active',
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('wallets');
  }
};