Content-Type: multipart/mixed; boundary="===============4107335208995000620=="
MIME-Version: 1.0
From: Stephen Brennan <stephen at brennan.io>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC] MPTCP Path Management Generic Netlink API
Date: Thu, 08 Mar 2018 15:46:29 -0800
Message-ID: <20180308234629.GA31562@greed.cult>
In-Reply-To: CAPyD+=CnxCpvN+h7zeUx-LRcn-jFfziEqpW8KuJjBcDy59m+ow@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 357

--===============4107335208995000620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ossama,

I'm very interested in the idea of a MPTCP path manager Netlink API, since
I actually posted a patch on mptcp-dev recently containing a path manager
which did send and receive some commands over a Netlink API. My API was not
nearly as complete as this one, but it's nice to see that path management
policy could move further into user-space. That certainly makes the sort of
research I was working on a lot easier.

I do have some inline comments drawn from my experience, but first one
question. Is the implementation strategy for the Netlink PM to simply be
another path manager (selectable among the other path managers), or would
it replace the other path managers in some way?

On Thu, Mar 08, 2018 at 12:48:40PM -0800, Othman, Ossama wrote:
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

How would this be implemented? I'm not sure of the specifics, but many path
manager functions are called from contexts in which sleeping is not
possible. It seems like waiting on a user-space decision for join_attempt
would require a decent amount of re-implementation. Plus, there is the
possibility that userspace may never respond.

It seems like a more pragmatic approach could be to have some strategies
implemented in the kernel. EG: default decline, default accept, accept on
certain interface, etc. A global (per net namespace?) default could be set,
and userspace could modify the global policy, or set the policy on a
particular connection. This would allow the kernel implementation to
respond immediately, while still giving userspace some flexibility.

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
> * subflow_closed
>    * Called when a subflow has been closed.  Allows path manager to
>      clean up subflow related resources.
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


Is there any event for "new network interface added"? Or would the
user-space daemon need to subscribe to that information elsewhere?

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

It seems like a command to list the available remote address IDs would be a
useful addition to this, so a user-space daemon could learn of remote
address IDs that are currently in use for a connection that was already
established when the daemon started.

Similarly, a list_subflows command could be useful to allow an application
to query the existing subflows of a connection.

>       * Backup priority flag (optional, use default priority if not
>         specified)
>       * Subflow ID
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

It seems important to require additionally that a process can only act on a
MPTCP connection if they are within the same network namespace. This might
be implicit in your security model but I wanted to confirm it.

Regards,
Stephen


--===============4107335208995000620==--
