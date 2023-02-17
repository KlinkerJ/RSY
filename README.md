# Robot Systems

![Westfälische Hochschule](https://www.w-hs.de/typo3conf/ext/whs/Resources/Public/Images/Pagelayout/w-hs_pagelogo.png)

## Description
This is a repository for the Robot Systems course in the master's program in mechanical engineering with a focus on robotics at the Westfälische Hochschule, Germany.

## Task
In the course, a program will be developed that (1) recognizes an object with Intel D415 cameras (in this specific case a squared timber, which is marked with circles at both ends) and then (2) is gripped and lifted by a Universal Robot UR3e. The squared timber should be recognized and gripped at both ends by seperate robots. The process of the other robot runs independently on a different computer and is developed by a different group of students. The robot operating system ensures communication so that both robots only start moving after they have successfully gripped.

![Universal Robot UR3e](https://uploads.unchainedrobotics.de/media/products/Product_images2FUR3e_1_d0fd2e60.jpg)

## Content

Our project can be started by running the camera script at `/src/Camera/CameraScript.mlx`. The Intel D415 must be connected to the PC. In addition, the robot script must be started. For this, `/src/Robot Control/ros_node.m` must be executed. The communication between the camera script and the robot control script also runs via ROS, which is why the scripts can be run on different computers.

> :warning: However, please note that the IP addresses of the ROS master and the robot must be adjusted.

## Contributors

- Lennart Fuhrig, B. Eng. [@lennart2810](https://github.com/lennart2810)
- Marcel Heinen, B. Sc. [@MH98](https://github.com/MH98)
- Jonas Klinker, B. Sc. [@KlinkerJ](https://github.com/KlinkerJ)
- Dominik Küsters, B. Eng. [@DominikKuesters](https://github.com/DominikKuesters)
- Jens Ludwig, B. Eng. [@jenslu](https://github.com/jenslu)
- Matthias Uesbeck, B. Eng. [@MatthiasUesbeck](https://github.com/MatthiasUesbeck)

## Contact

You can contact us students via the respective Github accounts. If you have further questions about the module or course, please contact [Prof. Dr. Martin Mass](https://www.w-hs.de/service/informationen-zur-person/person/mass/).
