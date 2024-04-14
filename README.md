# Underwater-ROV for inspection of Head Race Tunnels in Hydro-electric Power plants

**<ins>Disclaimer</ins>** : This repository contains the information and code for the underwater robot developed by Team Epsilon from IIT Roorkee for competing in the PS-Id PK365 by Ministry of Power, Govt. of India hosted in the Smart India Hackathon 2020 : Hardware Edition. The developement of the prototype was done under limited availability of resources due to COVID restrictions and hence all the features were not reproduced on the hardware.

### <ins>Introduction</ins> 
Large scale civil structures like dams require periodic inspections due to their safety-critical nature. In Hydro-electric Plants, monitoring and upkeep of Head Race Tunnels(HRTs) is such a critcial task for proper operation of the plant, especially in Himalayan rivers which carry huge silt. Head race tunnels connect the reservior(intake) to the power geneation unit (as shown in Fig1) and are susceptible to erosion and debris collection which can lead to even collapse of the whole structure <sup>[[1]](http://www.rockmass.net/files/Vinstra_collapse.pdf)</sup>. Traditionally, the process of inspecting headrace tunnels involves manual labour and requires the tunnel to be emptied, which is a cumbersome process with high inspection cost. Using a remotely operated vehicle (ROV) capable of inspecting the structure underwater would result in a considerable decrease in the inspection turn-around-time and cost, and therefore, a robot is designed to cater these requirements and a hardware prototype is built demonstrating the effectiveness of approach.
<p align="center">
  <img width="460" height="300" src="https://github.com/KSHITIJBITHEL/Underwater-ROV/assets/32517082/e84e40a0-2b96-4290-83aa-6ceaac68865c">
  </br>
  Fig 1 : The structure of a Hydro-electric plant
</p>

### <ins>Methodology</ins>
According to the problem statement<sup>[[2]](https://github.com/robinsdeepak/SIH-2020-PS)</sup>, the main concerns accessed during the inspection of HRTs include the deposition of silt/debris, cracking/deformation of tunnel walls and erosion of electronic and mechanical componects due to high acidity in water. To detect the silt/debris and cracking, we have proposed to use the visual feedback provided by the cameras mounted on the ROV supplemented by a crack detection algorithm. The presence of marine growth often poses an issue for underwater inspection, to mitigate that, we have designed a custom mechanism for removal of algae/small marine growth for proper inspection. Below is the final CAD model designed for the ROV 

<p align="center">
  <img width="460" height="300" src="https://github.com/KSHITIJBITHEL/Underwater-ROV/assets/32517082/94b6abe6-5a8d-4b5a-beb9-185565367bc9">
  </br>
  Fig 2 : Final CAD model of the ROV
</p>

### <ins>Mechanical Design</ins>
<ins>**Materials Used**</ins> : We have chosen PVC pipes for chasis and ABS plastic for the 3-D printed components as their densities are comparable to water (PVC: 1.38g/ml, ABS: 1.1g/ml), they've sufficient strength and are non-corrosive in nature.

<ins>**Thrusters**</ins> : The thruster assembly consists of a propeller, a duct and a motor housing, the cross section of the propellers is made in aerofoil shape considering the aerodynamics in mind. The overall system consists of 2 sets of thrusters, one facind in forward direction and the other in upward direction. Both the sets consist of 1 RHS and 1 LHS type propeller to balance the angular momentum. The following gif showcases a single thruster assembly in the design along with its components.
<p align="center">
  <img width="460" height="300" src="https://github.com/KSHITIJBITHEL/Underwater-ROV/assets/32517082/dbe5ed23-a5e8-47ba-bda7-2197254d7d2f">
  </br>
  Fig 3 : Thruster Assembly
</p>

<ins>**Marine growth removal mechanism**</ins> : We have designed a helix based mechanism with an abrasive outer covering for removing marine growth from the tunnel walls. The design of the mechanism and the placement of motor and bearing is shown in the following gif

<p align="center">
  <img width="460" height="300" src="https://github.com/KSHITIJBITHEL/Underwater-ROV/assets/32517082/8e867e11-f92b-4424-a4e2-a524b8d8ca91">
  </br>
  Fig 4 : The marine growth removal mechanism
</p>

The body is built to be streamlined in shape for easy maneuverability underwater as can be seen from the snippet of the below CFD simulation 
<p align="center">
  <img width="460" height="300" src="https://github.com/KSHITIJBITHEL/Underwater-ROV/assets/32517082/e91d1c0d-8a51-4107-bb7f-b21b2174de4f">
  </br>
  Fig 5 : CFD simulation of the full body of ROV 
</p>


### <ins>Electrical Subsystem</ins>
<ins>**Components Used**</ins> : 2 cameras (Arducomp 16MP IMX298 MIPI) - one mounted in front, with 1DoF actuation using servo motor, other mounted on side for visual observation and navigation,pressure sensor for depth measurement, Ping sonar echosounder for obstacle avoidance in turbid waters, pH sensor for pH measurement, 1 IMU (MPU9250) for pose estimation and control of ROV, Arduino Mega is used as the microcontroller, Raspberry Pi is used as the onboard computer and communication is performed via ethernet cable from ROV to the control centre.</br>
All the electronic equipments are housed inside a big PVC pipe sealed with 3D printed lids at the centre of ROV, as can be seen in design(Fig2) and the hardware prototype built(Fig?).

<ins>**Localization**</ins> : Underwater localization is a very challenging problem due to high attenuation of electro-magnetic waves, that too inside a tunnel. Considering that in mind, we propose a tracker based visual feedback localization algorithm which requires one time installation of trackers at known locations inside the tunnel using which a look-up table can be generated for referencing the location with the corresponding tracker. To detect the tracker, we've applied blob detection feature from OpenCV library, and the algorithm can be seen in action below.
<p align="center">
  <img width="460" height="300" src="https://github.com/KSHITIJBITHEL/Underwater-ROV/assets/32517082/4bc28e5f-d382-4cb3-ae9c-69a985ed6ee9">
  </br>
  Fig 6 : Tracker based localization technique 
</p>

<ins>**Contols**</ins> : We have implemented a PD based auto-depth and auto-heading controller using feedback from pressure sensor for depth and IMU for heading. An example demonstration of the controller simulated using Matlab can be seen below
<p align="center">
  <img width="460" height="300" src="https://github.com/KSHITIJBITHEL/Underwater-ROV/assets/32517082/4e104fae-02ce-49bb-b931-b0ad53d48149">
  </br>
  Fig 7 : P-D based depth control of ROV
</p>

<ins>**Crack Detection**</ins> : We have implemented a crack detection algorithm using OpenCV libraries in which we first remove noise from the image using gaussian blurring and compensate for the poor lighting using adaptive thresholding, then we calculate the length of contour to estimate if a crack is present or not. If a crack is present, we store the image of the crack with the location for future reference. The algorithm flow and its demonstration can be seen below.
<p align="center" width = "100%">
  <img width="40%" height="300" src="https://github.com/KSHITIJBITHEL/Underwater-ROV/assets/32517082/9c95cf24-9c0f-4617-bfa4-113a7ae303dd">
  <img width="40%" height="300" src="https://github.com/KSHITIJBITHEL/Underwater-ROV/assets/32517082/ccc60b32-9a55-4523-a986-dbe000a66e5b">
  
  </br>
  Fig 8 : a)Flow chart of crack detection algorithm b)Video demonstration on a wall crack  
</p>

### <ins>Hardware Protoype</ins>
Due to the limited availablility of resources amidst COVID regulations, we built a proof of concept hardware prototype without the cameras, pressure sensor, ph sensor and the marine growth removal mechanism. We tested the same in a small tank in our college and it can be seen in the gif below.
<p align="center">
  <img width="460" height="300" src="">
  </br>
  Fig 9 : Testing the prototype
</p>

### <ins>Results</ins>
We showcased our work in Smart India Hackathon 2020 : Hardware edition, held online due to COVID Regulations and were regarded as the winner<sup>[[3]](https://www.sih.gov.in/hardwareFinalResult2020)</sup> among the 30+ teams competing for the same problem statement.

**<ins>Team</ins>** - Tabish Madni(Team Leader, Design & Fabrication), Shubham Malviya(Design & Fabrication), Samarth Koolwal(Design & Fabrication), Ruchika Guntewar(Desgign & Presentation), Allu Vamsi Vishal(Electronics & Communication), Kshitij Bithel(Software & Controls)
