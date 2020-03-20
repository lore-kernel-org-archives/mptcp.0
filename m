Content-Type: multipart/mixed; boundary="===============8983483994796168624=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Preparing to send "part 3" - cover letter draft
Date: Fri, 20 Mar 2020 15:03:50 -0700
Message-ID: <alpine.OSX.2.22.394.2003201452520.22025@nkathuri-mobl1.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4037

--===============8983483994796168624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Here's my draft for the cover letter.

Paolo, is the path manager part correct? Anything I should add there?

Note that I proposed "netdev-v1-for-5.6" for the tag because there's an =

existing "netdev-v1-part3" tag, although that "part 3" patch set was never =

sent to netdev (it was combined with the part 2 posting) - we can use the =

v1-part3 tag if people prefer that.


"""
Multipath TCP: Multiple subflows and path management

This patch set allows more than one TCP subflow to be established and used =

for a multipath TCP connection. Subflows are added to an existing =

connection using the MP_JOIN option during the 3-way handshake. With =

multiple TCP subflows available, sent data is now stored in the MPTCP =

socket so it may be retransmitted on any TCP subflow if there is no =

DATA_ACK before a timeout. If an MPTCP-level timeout occurs, data is =

retransmitted using an available subflow. Storing this sent data requires =

the addition of memory accounting at the MPTCP level, which was previously =

delegated to the single subflow. Incoming DATA_ACKs now free data from the =

MPTCP-level retransmit buffer.

IP addresses available for new subflow connections can now be advertised =

and received with the ADD_ADDR option, and the corresponding REMOVE_ADDR =

option likewise advertises that an address is no longer available.

The MPTCP path manager netlink interface has commands to set in-kernel =

limits for the number of concurrent subflows and control the advertisement =

of IP addresses between peers.

To track and debug MPTCP connections there are new MPTCP MIB counters, and =

subflow context can be requested using inet_diag. The MPTCP self-tests now =

validate multiple-subflow operation and the netlink path manager =

interface.

Clone/fetch:
https://github.com/multipath-tcp/mptcp_net-next.git (tag: =

netdev-v1-for-5.6)

Browse:
https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v1-for-5.6

Thank you for your review. You can find us at mptcp(a)lists.01.org and
https://is.gd/mptcp_upstream
"""

--
Mat Martineau
Intel
--===============8983483994796168624==--
