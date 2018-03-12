Content-Type: multipart/mixed; boundary="===============7291471988226065391=="
MIME-Version: 1.0
From: Othman, Ossama <ossama.othman at intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC] MPTCP Path Management Generic Netlink API
Date: Mon, 12 Mar 2018 10:27:29 -0700
Message-ID: <CAPyD+=AKor9ZD9W=OQxir=8LT-boHtduNSCi=4JPRUDNK9+vJQ@mail.gmail.com>
In-Reply-To: 20180308234629.GA31562@greed.cult
X-Status: 
X-Keywords:                  
X-UID: 366

--===============7291471988226065391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Thu, Mar 8, 2018 at 3:46 PM, Stephen Brennan <stephen(a)brennan.io> wrot=
e:
> I'm very interested in the idea of a MPTCP path manager Netlink API, since
> I actually posted a patch on mptcp-dev recently containing a path manager
> which did send and receive some commands over a Netlink API. My API was n=
ot
> nearly as complete as this one, but it's nice to see that path management
> policy could move further into user-space. That certainly makes the sort =
of
> research I was working on a lot easier.

Thanks for pointing this out!  I'm interested in seeing your approach,
so I'll take a look, too.

> I do have some inline comments drawn from my experience, but first one
> question. Is the implementation strategy for the Netlink PM to simply be
> another path manager (selectable among the other path managers), or would
> it replace the other path managers in some way?

Our approach is to move all path management related operations to a
user space daemon since they aren't in the critical path (assuming
connection setup/teardown doesn't occur often), with the goal of
minimizing the amount of work done in the kernel.  That daemon
provides path manager plugin infrastructure.  Path manager plugins
would implement the plugin interface (callback functions)
corresponding to the generic netlink events described below.
Selection of a path manager would be done at daemon start (the
default) or at run-time through a socket option, similar to the socket
option based selection in the multipath-tcp.org implementation.  To
start, and to simplify the initial implementation, we'll only support
selecting a path manager at run-time before the MPTCP connection has
been established.  However, the below generic netlink proposal lacks a
payload field, such as the path manager name, necessary to support
run-time selection.  Adding a path manager name payload field to the
new_connection event should suffice, as far as I can tell.

More comments inline below ...

> On Thu, Mar 08, 2018 at 12:48:40PM -0800, Othman, Ossama wrote:
>> * join_attempt
>>    * Called when a MP_JOIN has been ACKed.  The path manager is
>>      expected to respond with an allow_join event containing its
>>      decision based on the configured policy.
>
> How would this be implemented? I'm not sure of the specifics, but many pa=
th
> manager functions are called from contexts in which sleeping is not
> possible. It seems like waiting on a user-space decision for join_attempt
> would require a decent amount of re-implementation. Plus, there is the
> possibility that userspace may never respond.

You certainly bring up good point.  I'm not far enough in the
implementation, particularly for this join_attempt event, to be able
to give you a meaningful answer regarding the inability to sleep.
Regarding the issue of user space potentially not responding, wouldn't
leveraging a timeout prevent the kernel space from waiting
indefinitely?  It may not be the best solution but at least we could
bound the wait time.

> It seems like a more pragmatic approach could be to have some strategies
> implemented in the kernel. EG: default decline, default accept, accept on
> certain interface, etc. A global (per net namespace?) default could be se=
t,
> and userspace could modify the global policy, or set the policy on a
> particular connection. This would allow the kernel implementation to
> respond immediately, while still giving userspace some flexibility.

Yes, that sounds reasonable.  I'll take this into account as our
implementation progresses.  Thanks!

> Is there any event for "new network interface added"? Or would the
> user-space daemon need to subscribe to that information elsewhere?

The daemon subscribes to rtnetlink events to determine when network
interfaces have been added or removed, and propagates those events to
the path manager plugins.  I'm not sure if this is the best approach
since we could also propagate such network interface related events
from the kernel MPTCP implementation, similar to how the
multipath-tcp.org implementation propagates such events to its
in-kernel path managers.  Ultimately I opted to listen for network
interface changes in the user space to avoid adding more code in the
kernel.

>> Path Manager Initiated Events (Commands)
>> ----------------------------------------
...
> It seems like a command to list the available remote address IDs would be=
 a
> useful addition to this, so a user-space daemon could learn of remote
> address IDs that are currently in use for a connection that was already
> established when the daemon started.

I was under the assumption that MPTCP connections would not be
established without the daemon up and running, meaning it would know
about all remote address IDs.  Perhaps that isn't a reasonable
assumption, especially if we implement the default path management
strategies in the kernel you mentioned above.

> Similarly, a list_subflows command could be useful to allow an application
> to query the existing subflows of a connection.

That sounds reasonable.

>> Security
>> --------
>> For security reasons, path management operations may only be performed
>> by privileged processes due to the GENL_ADMIN_PERM generic netlink
>> flag being set.  In particular, access to the MPTCP generic netlink
>> interface will require CAP_NET_ADMIN privileges.
>
> It seems important to require additionally that a process can only act on=
 a
> MPTCP connection if they are within the same network namespace. This might
> be implicit in your security model but I wanted to confirm it.

It is now. :)

Thanks for the excellent feedback!

-Ossama

--===============7291471988226065391==--
