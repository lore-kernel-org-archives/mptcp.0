Content-Type: multipart/mixed; boundary="===============8555434687863331159=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC] MPTCP Path Management Generic Netlink API
Date: Sun, 11 Mar 2018 20:25:43 -0700
Message-ID: <20180312032543.GJ74937@MacBook-Pro-4.local>
In-Reply-To: CAPyD+=CnxCpvN+h7zeUx-LRcn-jFfziEqpW8KuJjBcDy59m+ow@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 364

--===============8555434687863331159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Ossama,

thanks for sharing this! Looks quite well thought-through.

Please find some comments inline:

On 08/03/18 - 12:48:40, Othman, Ossama wrote:
> Hi,
> =

> Following up on on a brief exchange between Matthieu and Mat regarding
> a MPTCP path manager netlink API, I'd like to share to our own
> proposed generic netlink API developed in parallel.
> =

> Please find the high level description below.  It'll be great to
> compare the two netlink based APIs to determine if either can be
> improved by leveraging different aspects from each one.
> =

> Thanks!
> =

> --
> Ossama Othman
> Intel OTC
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RFC: MPTCP Path Management Generic Netlink API
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> A generic netlink socket is used to facilitate communication between
> the kernel and a user space daemon that handles MPTCP path management
> related operations, from here on in called the path manager.  Several
> multicast groups, attributes and operations are exposed by the "mptcp"
> generic netlink family, e.g.:
> =

> $ genl ctrl list
> ...
> Name: mptcp
>        ID: 0x1d  Version: 0x1  header size: 0  max attribs: 7
>        commands supported:
>                #1:  ID-0x0
>                #2:  ID-0x1
>                #3:  ID-0x2
>                #4:  ID-0x3
>                #5:  ID-0x4
> =

> =

>        multicast groups:
>                #1:  ID-0xa  name: new_connection
>                #2:  ID-0xb  name: new_addr
>                #3:  ID-0xc  name: join_attempt
>                #4:  ID-0xd  name: new_subflow
>                #5:  ID-0xe  name: subflow_closed
>                #6:  ID-0xf  name: conn_closed
> =

> Each of the multicast groups corresponds to MPTCP path manager events
> supported by the kernel MPTCP stack.
> =

> Kernel Initiated Events
> -----------------------
> * new_connection
>    * Called upon completion of new MPTCP-capable connection.
>      Information for initial subflow is made available to the path
>      manager.
>    * Payload
>       * Connection ID (globally unique for host)
>       * Local address
>       * Local port
>       * Remote address
>       * Remote port
>       * Priority

What is the meaning of "Priority" here? Is this whether the interface is a
backup one, based on the 'ip link set dev ... multipath backup'
configuration?

If that's the case, I suggest that this is not needed. Ultimately, the
netlink path-manager should configure the backup-flag of an interface.


Additional info that could be useful would be the pid of the process (or
does Linux has a notion of UUID (?)) that owns the socket. That would allow=
 a
client-side path manager to apply policies based on the app. E.g., think of=
 an
Android implementation where some apps are allowed to use cell, while others
aren't.

> * new_addr
>    * Triggered when the host receives an ADD_ADDR MPTCP option, i.e. a
>      new address is advertised by the remote side.
>    * Payload
>       * Connection ID
>       * Remote address ID
>       * Remote address
>       * Remote port
> * join_attempt
>    * Called when a MP_JOIN has been ACKed.  The path manager is
>      expected to respond with an allow_join event containing its
>      decision based on the configured policy.

I'm not sure what you mean with "has been ACKed". Can you explain? Is this
here a server-side, where we are receiving a SYN+MP_JOIN?

>    * Payload
>       * Connection ID
>       * Local address ID
>       * Local address
>       * Local port
>       * Remote address ID
>       * Remote address
>       * Remote port
> * new_subflow
>    * Called when final MP_JOIN ACK has been ACKed.
>    * Payload
>       * Connection ID
>       * Subflow ID

Same here as above. Maybe it would help if you clarify if we are the active
or the passive opener in these cases.

> * subflow_closed
>    * Called when a subflow has been closed.  Allows path manager to
>      clean up subflow related resources.

For the payload, an optional "error" would be good. That allows to see if
the subflow got closed because of an incoming RST, timeout,...

As for "regular" closing, I'm not sure how this applies here, because when
subflows are managed by the path-manager, it should not go away unless the
path-manager does the remove_subflow command.

One subtlety is that the peer could decide to close a subflow (thus, sends a
FIN), while we still keep this subflow alive.
So, maybe we need another event that says "subflow_read_closed", upon which
the path-manager can do a remove_subflow command.

>    * Payload
>       * Connection ID
>       * Subflow ID
> * conn_closed
>    * Call when an MPTCP connection as a whole, as opposed to a single
>      subflow, has been closed.  This is the case when close(2) has
>      been called on an MPTCP connection.
>    * Payload
>       * Connection ID
> =

> Path Manager Initiated Events (Commands)
> ----------------------------------------
> * send_addr
>    * Notify the kernel of the availability of new address for use in
>      MPTCP connections.  Triggers an ADD_ADDR to be sent to the peer.
>    * Payload
>       * Connection ID
>       * Address ID
>       * Local address
>       * Local port (optional, use same port as initial subflow if not
>         specified)
> * add_subflow
>    * Add new subflow to the MPTCP connection.  This triggers an
>      MP_JOIN to be sent to the peer.
>    * Payload
>       * Connection ID
>       * Local address ID
>       * Local address (optional, required if send_addr not previously
>         sent to establish the local address ID)
>       * Local port (optional, use same port as initial subflow if not
>         specified)
>       * Remote address ID (e.g. from a previously received new_addr or
>         join_attempt event)
>       * Backup priority flag (optional, use default priority if not
>         specified)
>       * Subflow ID

We need the interface-index as well here. There are use-cases where one has
multiple interfaces with the same IP address. Think of a host with multiple
interfaces, each behind a NAT and the gateways each give 192.168.1.2.

> * allow_join
>    * Allow MP_JOIN attempt from peer.
>    * Payload
>       * Connection ID
>       * Remote address ID (e.g from a previously received join_attempt
>         event).
>       * Local address
>       * Local port
>       * Allow indication (optional, do not allow join if not
>         specified)
>       * Backup priority flag (optional, use default priority if not
>         specified)
>       * Subflow ID

This means we are delaying the sending of the SYN/ACK+MP_JOIN, right?

From an implementation point-of-view, how does this look like? It seems
quite tricky to me.

Would it be easier to restrict the path-manager to active-opener only?


Cheers,
Christoph

> * set_backup
>    * Set subflow priority to backup priority.
>    * Payload
>       * Connection ID
>       * Subflow ID
>       * Backup priority flag (optional, use default priority if not
>         specified)
> * remove_subflow
>    * Triggers a REMOVE_ADDR MPTCP option to be sent, ultimately
>      resulting in subflows routed through that invalidated address to
>      be closed.
>    * Payload
>       * Connection ID
>       * Subflow ID
> =

> Security
> --------
> For security reasons, path management operations may only be performed
> by privileged processes due to the GENL_ADMIN_PERM generic netlink
> flag being set.  In particular, access to the MPTCP generic netlink
> interface will require CAP_NET_ADMIN privileges.
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============8555434687863331159==--
