const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Customer = sequelize.define('Customer', {
    CustomerID: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    FirstName: {
        type: DataTypes.STRING(255),
        allowNull: false
    },
    MiddleName: {
        type: DataTypes.STRING(255),
        allowNull: true
    },
    LastName: {
        type: DataTypes.STRING(255),
        allowNull: false
    },
    CustomerServiceCenterID: {
        type: DataTypes.INTEGER,
        allowNull: true,
        references: {
        model: 'CustomerServiceCenter',
        key: 'CustomerServiceCenterID'
        }
    },
    Address: {
        type: DataTypes.STRING(255),
        allowNull: true
    },
    Username: {
        type: DataTypes.STRING(50),
        allowNull: true
    },
    Password: {
        type: DataTypes.STRING(50),
        allowNull: true
    },
    Email: {
        type: DataTypes.STRING(255),
        allowNull: true
    },
    PhoneNumber: {
        type: DataTypes.STRING(20),
        allowNull: true
    },
    AlternatePhoneNumber: {
        type: DataTypes.STRING(20),
        allowNull: true
    },
    DateOfBirth: {
        type: DataTypes.DATE,
        allowNull: true
    },
    Gender: {
        type: DataTypes.STRING(10),
        allowNull: true
    },
    MaritalStatus: {
        type: DataTypes.STRING(20),
        allowNull: true
    },
    Occupation: {
        type: DataTypes.STRING(50),
        allowNull: true
    },
    IDNumber: {
        type: DataTypes.STRING(20),
        allowNull: true
    },
    IDPhoto: {
        type: DataTypes.STRING(255),
        allowNull: true
    },
    PassportSizePhoto: {
        type: DataTypes.STRING(255),
        allowNull: true
    },
    RegistrationDate: {
        type: DataTypes.DATE,
        allowNull: false,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
    },
    Status: {
        type: DataTypes.STRING(20),
        allowNull: true,
        defaultValue: 'Active'
    }
    }, {
    tableName: 'Customer',
    timestamps: false
});

module.exports = Customer;