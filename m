Content-Type: multipart/mixed; boundary="===============6785318655313715316=="
MIME-Version: 1.0
From: Othman, Ossama <ossama.othman at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC] MPTCP Path Management Generic Netlink API
Date: Thu, 08 Mar 2018 12:48:40 -0800
Message-ID: <CAPyD+=CnxCpvN+h7zeUx-LRcn-jFfziEqpW8KuJjBcDy59m+ow@mail.gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 355

--===============6785318655313715316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Following up on on a brief exchange between Matthieu and Mat regarding
a MPTCP path manager netlink API, I'd like to share to our own
proposed generic netlink API developed in parallel.

Please find the high level description below.  It'll be great to
compare the two netlink based APIs to determine if either can be
improved by leveraging different aspects from each one.

Thanks!

--
Ossama Othman
Intel OTC

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RFC: MPTCP Path Management Generic Netlink API
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A generic netlink socket is used to facilitate communication between
the kernel and a user space daemon that handles MPTCP path management
related operations, from here on in called the path manager.  Several
multicast groups, attributes and operations are exposed by the "mptcp"
generic netlink family, e.g.:

$ genl ctrl list
...
Name: mptcp
       ID: 0x1d  Version: 0x1  header size: 0  max attribs: 7
       commands supported:
               #1:  ID-0x0
               #2:  ID-0x1
               #3:  ID-0x2
               #4:  ID-0x3
               #5:  ID-0x4


       multicast groups:
               #1:  ID-0xa  name: new_connection
               #2:  ID-0xb  name: new_addr
               #3:  ID-0xc  name: join_attempt
               #4:  ID-0xd  name: new_subflow
               #5:  ID-0xe  name: subflow_closed
               #6:  ID-0xf  name: conn_closed

Each of the multicast groups corresponds to MPTCP path manager events
supported by the kernel MPTCP stack.

Kernel Initiated Events
-----------------------
* new_connection
   * Called upon completion of new MPTCP-capable connection.
     Information for initial subflow is made available to the path
     manager.
   * Payload
      * Connection ID (globally unique for host)
      * Local address
      * Local port
      * Remote address
      * Remote port
      * Priority
* new_addr
   * Triggered when the host receives an ADD_ADDR MPTCP option, i.e. a
     new address is advertised by the remote side.
   * Payload
      * Connection ID
      * Remote address ID
      * Remote address
      * Remote port
* join_attempt
   * Called when a MP_JOIN has been ACKed.  The path manager is
     expected to respond with an allow_join event containing its
     decision based on the configured policy.
   * Payload
      * Connection ID
      * Local address ID
      * Local address
      * Local port
      * Remote address ID
      * Remote address
      * Remote port
* new_subflow
   * Called when final MP_JOIN ACK has been ACKed.
   * Payload
      * Connection ID
      * Subflow ID
* subflow_closed
   * Called when a subflow has been closed.  Allows path manager to
     clean up subflow related resources.
   * Payload
      * Connection ID
      * Subflow ID
* conn_closed
   * Call when an MPTCP connection as a whole, as opposed to a single
     subflow, has been closed.  This is the case when close(2) has
     been called on an MPTCP connection.
   * Payload
      * Connection ID

Path Manager Initiated Events (Commands)
----------------------------------------
* send_addr
   * Notify the kernel of the availability of new address for use in
     MPTCP connections.  Triggers an ADD_ADDR to be sent to the peer.
   * Payload
      * Connection ID
      * Address ID
      * Local address
      * Local port (optional, use same port as initial subflow if not
        specified)
* add_subflow
   * Add new subflow to the MPTCP connection.  This triggers an
     MP_JOIN to be sent to the peer.
   * Payload
      * Connection ID
      * Local address ID
      * Local address (optional, required if send_addr not previously
        sent to establish the local address ID)
      * Local port (optional, use same port as initial subflow if not
        specified)
      * Remote address ID (e.g. from a previously received new_addr or
        join_attempt event)
      * Backup priority flag (optional, use default priority if not
        specified)
      * Subflow ID
* allow_join
   * Allow MP_JOIN attempt from peer.
   * Payload
      * Connection ID
      * Remote address ID (e.g from a previously received join_attempt
        event).
      * Local address
      * Local port
      * Allow indication (optional, do not allow join if not
        specified)
      * Backup priority flag (optional, use default priority if not
        specified)
      * Subflow ID
* set_backup
   * Set subflow priority to backup priority.
   * Payload
      * Connection ID
      * Subflow ID
      * Backup priority flag (optional, use default priority if not
        specified)
* remove_subflow
   * Triggers a REMOVE_ADDR MPTCP option to be sent, ultimately
     resulting in subflows routed through that invalidated address to
     be closed.
   * Payload
      * Connection ID
      * Subflow ID

Security
--------
For security reasons, path management operations may only be performed
by privileged processes due to the GENL_ADMIN_PERM generic netlink
flag being set.  In particular, access to the MPTCP generic netlink
interface will require CAP_NET_ADMIN privileges.

--===============6785318655313715316==--
