HA-OpenStack
============

High-availability implementation of Nova OpenStack based on Grizzly release.

At a high level, the following is a list of focus areas:

Stage 1 - Core Infrastructure
          Rabbit Active/Passive
          Database Redundancy (could be A/P or A/A)
          API Load Balanced (could be A/P or A/A)
Stage 2 - Keystone high-availability
Stage 3 - Glance high-availability
Stage 4 - Openstack Networking high-availability
Stage 5 – Compute (Nova)
Stage 6 – Dashboard (Horizon)
Stage 7 – Hardware

The architecture is designed to be modular and addresses the issues of high-availability and scale across the entire Nova platform using a combination of software, hardware and configuration. The scopes of the architectural requirements are narrow and enterprise focused. We do not attempt to deliver “Amazon-scale” architecture but focus primarily on an architecture that is in alignment with the requirements of small, medium and large enterprises. 

Primarily focused on the Grizzly release of OpenStack, but also takes into account the direction of the community’s long-term roadmap as it moves towards the Havana release and beyond. 

Many of the architectural designs presented in this project are in alignment with suggested architecture designs contained in the OpenStack High-Availability Guide and also best practices with in the IT industry today.
