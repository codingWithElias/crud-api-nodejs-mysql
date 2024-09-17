const User = require("../models/user");

exports.getAllUsers = (req, res) => {
    User.findAll()
    .then(users=> res.json(users))
    .catch(error => res.status(500).json({message: 'Internal server error', error: error}));
}

exports.getUser = async (req, res) => {
   const id = parseInt(req.params.id);
   
   try{
    const user = await User.findByPk(id);

        if(!user){
        return res.status(404).send({
            message: "User not found!"
        }); }

        res.status(201).json({
            user
        });

    } catch(error){
        res.status(500).json({
            message: 'Internal server error',
            error
        });
    }
}
exports.updateUser = async (req, res) => {
    const id = parseInt(req.params.id);
    const {first_name, last_name, email} = req.body;
    if(!first_name || !last_name || !email){
        return res.status(400).send({
            message: "First name, last name, and email cannot be empty!"
        });
       }
    try{
     const user = await User.findByPk(id);
 
         if(!user){
         return res.status(404).send({
             message: "User not found!"
         }); 
        }else {
            user.first_name = first_name;
            user.last_name = last_name;
            user.email = email;
            await user.save();

            res.status(201).json({
                message: 'User updated successfully',
                UpdatedUser: user
            });
        }
     } catch(error){
         res.status(500).json({
             message: 'Internal server error',
             error
         });
     }
 }
exports.createUser = async (req, res) => {
   const {first_name, last_name, email} = req.body;
   
   if(!first_name || !last_name || !email){
    return res.status(400).send({
        message: "First name, last name, and email cannot be empty!"
    });
   }
  try{
        const newUser = await User.create({
            first_name,
            last_name,
            email
        });

        res.status(201).json({
            message: 'User registered successfully',
            newUser: newUser
        });
    } catch(error){
        res.status(500).json({
            message: 'An error occurred while registering the user'
        });
    }

}


exports.deleteUser = async (req, res) => {
    const id = parseInt(req.params.id);
    
    try{
     const user = await User.findByPk(id);
 
         if(!user){
         return res.status(404).send({
             message: "User not found!"
         }); }
         
         await user.destroy();

         res.status(201).json({
             message: "User Deleted!"
         });
 
     } catch(error){
         res.status(500).json({
             message: 'Internal server error',
             error
         });
     }
 }