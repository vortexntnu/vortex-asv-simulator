#!/usr/bin/env python

import rospy
from vortex_msgs.msg import ThrusterForces
from uuv_gazebo_ros_plugins_msgs.msg import FloatStamped

class ThrusterInterface:
    """
    Takes as input the desired actuator forces for the ASV, and outputs
    it in a format that the simulator can use.
    """

    def __init__(self):
        rospy.init_node("thruster_interface")
        rospy.Subscriber("/thrust/thruster_forces", ThrusterForces, self.thruster_allocator_cb, queue_size = 3)
        thr0_pub = rospy.Publisher("/heron/thrusters/0/input", FloatStamped, queue_size = 1)
        thr1_pub = rospy.Publisher("/heron/thrusters/1/input", FloatStamped, queue_size = 1)
        thr2_pub = rospy.Publisher("/heron/thrusters/2/input", FloatStamped, queue_size = 1)
        thr3_pub = rospy.Publisher("/heron/thrusters/3/input", FloatStamped, queue_size = 1)

        self.publishers = [thr0_pub, thr1_pub, thr2_pub, thr3_pub]

    def thruster_allocator_cb(self, msg):
        for i, force in enumerate(msg.thrust):
            thruster_msg = FloatStamped()
            thruster_msg.header.stamp = rospy.Time.now()
            thruster_msg.data = force
            self.publishers[i].publish(thruster_msg)

if __name__ == "__main__":

    try:
        thruster_interface = ThrusterInterface()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
