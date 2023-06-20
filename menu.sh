#!/bin/bash
#this is menu script to choose an option using
#sudo ./menu.sh


#####################DINA####################

AddUser(){

   echo  "Enter the user name: "
   read  username
   if [ $? -ne 0 ]
   then
   echo "User already exist..."
   
   else
   useradd $username
   echo "Enter the password for the user:"
   read password
   echo $password  | passwd $username --stdin  &>/dev/null
   fi
}

#####################DINA############################

ChangePassword(){
    echo "Enter the username:"
    read  name
    if [ $? -eq 0 ]
    then
    echo "Enter the new password:"
    read pass
    echo $pass | passwd $name  --stdin &>/dev/null
    fi
}

##########################DINA#########################

RemoveUser(){
    echo "Enter the username to remove:"
    if [ $? -eq 0 ]
    then
    read user

   read -p "Remove with home directory or not? please enter yes or no to answer:  " answer
while true; do
case $answer in 
"yes")
userdel -r $user
break 
;;
"no")
userdel $user
break 
;;
*)   echo "please enter a valid choice...";;
esac
done
fi 

}

####################DINA####################################

SuspendUser(){
echo "Enter the username to disable: "
read disable
if [ $? -ne 0 ]
then
echo "User does not exist"
else
usermod -L $disable
fi

}

####################DINA####################################

ReEnableUser(){
echo "Enter the username to enable: "
read enable
if [ $? -ne 0 ]
then
echo "User does not exist"
else
passwd -u $enable
fi

}

########################DINA###############################

ExpireDate(){
echo "Enter the username you want to set a date expiration to: "
read username

if [ $? -ne 0 ]
then
echo "User does not exist"
else

echo "Enter the time you want the user account expire in:  "
read expire
chage -E $expire $username

fi

}

#########################DINA#############################

Shell(){

echo "Enter the username you want to change shell for:  "
read user
if [ $? -ne 0 ]
then
echo "User does not exist"
else
echo "Enter the full path for the shell name"
read shell
chsh -s $shell $user ## change bash to ksh ##

fi


}

##########################DINA###########################

CreateGroup(){

echo "Enter the new group: "
read groupname
if [ $(grep -q $groupname /etc/group) -eq 0 ] &>/dev/null
then
echo "The group is already exist"
else
groupadd $groupname
fi
}

############################DINA###########################

RemoveGroup(){

echo "Enter the group name to delete: "
read delete
if [ $(grep -q $delete /etc/group) -ne 0 ] &>/dev/null
then
echo "The group does not exist"
else
groupdel $delete
fi

}

#############################DINA##########################

AddUserToGroup(){

echo "Add username to group: "
read username
if [ $(grep -q $username /etc/passwd) -ne 0 ] &>/dev/null
then
echo "The username dose not exist"

else
echo "enter the groupname:"
read groupname
if [ $(grep -q $groupname /etc/group) -ne 0 ] &>/dev/null
then
echo "group does not exist"
else 
usermod -a -G $groupname $username

fi

fi
}

###############################DINA########################

Exit(){

exit

}

####################DINA####################################

if [ $UID  -ne 0 ];
then 
echo "Please run this script as a root"
exit
else
read -p "start the program? yes or no  :  " ans
while true; do
case $ans in 
"yes")
echo "***choose an option***"
echo "*********************************"
echo "1) Add user:        add a new user"
echo "2) Change password: change password for a user a count" 
echo "3) Remove user:     remove a user account" 
echo "4) Suspend user:    disable a user account" 
echo "5) Enable user:     enable suspended user account"
echo "6) Expire Date:     set expire date for a user account"  
echo "7) Shell:           set the default shell" 
echo "8) Create group:    create a new groyp" 
echo "9) Remove group:    remove an existing group" 
echo "10)UserToGroup:     add user to a group"
echo "11)Exit"
echo "*********************************"
break
;; 

"no")
exit
break
;;
*)
echo "try again"
esac
done

fi

####################DINA#######################################

while true; do
read -p "insert an appropriate number:  "  number
case $number in
   "1")
        AddUser
        break
        ;;
   "2")
        ChangePassword
        break
        ;;
   "3")
        RemoveUser
        break
        ;;
   "4") 
        SuspendUser
        break
        ;;
   "5")
        ReEnableUser
        break
        ;;
   "6") 
        ExpireDate
        break
        ;;
   "7") 
        Shell
        break
        ;;
   "8")
        CreateGroup
        break
        ;;
   "9") 
        RemoveGroup
        break
        ;;
  "10")
        AddUserToGroup
        break
        ;;
  "11") 
        Exit
        break
        ;;

     *)  echo "invaild" ;;

esac

done

