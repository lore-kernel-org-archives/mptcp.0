Content-Type: multipart/mixed; boundary="===============6292471890790690459=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 7/9] mptcp: add netlink based PM
Date: Sat, 22 Feb 2020 17:38:44 +0100
Message-ID: <bd907bec-f7ff-0ee2-82ea-ee4acfc386f4@tessares.net>
In-Reply-To: c472b6a576458fea5769544e51fe4ddc57a8e2d8.1582303591.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3745

--===============6292471890790690459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

As always, it is very good! Sorry for the delay but here are various =

questions and comments.

Note that I didn't really pay attention at how the locks were used, I =

would be glad if someone could look at this specific point. I focused my =

review more on the exposed API, general behaviour, Netlink stuff and typos.

On 21/02/2020 17:48, Paolo Abeni wrote:
> Expose to U/S a netlink family to control the PM, setting:
> =

>   - list of local addresses to be signaled.
>   - list of local addresses used to created subflows.
>   - maximum number of add_addr option to react

It looks a bit strange to me to limit in term of ADD_ADDR. I see that =

all commands are linked to addresses which seem to make sense but I =

don't know if it is good for a generic PM.

Depending on the strategy, you might create and accept more or less =

subflows using the same list of local and remote addresses:

  - a client with a fullmesh strategy will create a subflow from each =

local address to each remote ones having the same IP family. So if the =

client and the server have each 2 (reachable) IPv4 A and B, there will =

be 4 subflows: A-A, A-B, B-A, B-B.

  - another strategy could be like the fullmesh one but using each IP =

only once: A-A, B-B

  - slightly different: create one subflow per network interface (from =

the client, it is hard to know what the server has): both client and =

server can have 2 NIC with one IPv4 and one v6 per NIC. The server will =

announce the v4 and v6 of the other NIC and the client will use one IP =

per interface: A4-A4, B4/6-B4/6 but not A4-A4, A6-A/B6, B4-B4, B6-B/A6 =

like we would have with the previous strategy.

  - there are plenty of strategies for the client, e.g. ndiffport (more =

subflows using the same IPs but different ports), etc. Many strategies =

will be dedicated to one specific use-case, then requiring a more =

advanced Netlink PM like the one in mptcp.org with mptcpd.

  - on the server side, I think there are less strategies. Of course, =

some might require a more advanced Netlink

 > +}
 > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
 > index 5111b191a726..ea916aa22ae4 100644
 > --- a/net/mptcp/protocol.h
 > +++ b/net/mptcp/protocol.h
 > @@ -391,6 +391,13 @@ bool mptcp_pm_addr_signal(struct mptcp_sock =

*msk, unsigned int remaining,
 >   			  struct mptcp_addr_info *saddr);
 >   int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct =

sock_common *skc);
 >
 > +void mptcp_pm_nl_init(void);
 > +void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 > +void mptcp_pm_nl_fully_established(struct mptcp_sock *msk);
 > +void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk);
 > +void mptcp_pm_nl_add_addr(struct mptcp_sock *msk);
 > +int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct =

sock_common *skc);
 > +
 >   static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 >   {
 >   	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
 > PM but most of the time, the server's job is to announce addresses =

and accept (or reject) subflows.

Also, another point: the client doesn't really have to send ADD_ADDR to =

the server. The server could then receive MP_JOIN from IPs that are new =

to the server, i.e. not announced by the client with ADD_ADDR.


Now, after having mentioned all these points, I think it can be =

interesting to:

  - continue to manage addresses that can be announced / used to create =

subflows.

  - continue to pick a single strategy for the moment. Maybe best to =

start with fullmesh and if needed, the userspace can block some =

combinations using NFTables (I almost wrote IPTables :-o). This can be =

extended later by adding more strategies but I think we can already do =

many things if the userspace selects which additional addresses to use.

  - instead of having a maximum number of received ADD_ADDR that can =

use, it might be more generic to limit the number of created/accepted =

subflows per MPTCP connection. If needed, this can be extended later =

with other limits: number of subflow per interface or IP and per MPTCP =

connection.

In other words, compared to this patch, only modifying how the limits =

are managed to be more generic (I think).

What do you think about that?


Maybe you still want to keep a limit for the received ADD_ADDR? I don't =

think we store them for the moment? I guess MPTCP_PM_ADDR_MAX is enough =

for now for the limit.

> When the msk is fully established, the PM netlink attempts to
> create subflow for each addr in 'local' list, waiting for each
> connection to be completed before attempting the next one.

I guess it does that only for the client (connect, not listen).

> After exausting the 'local' list, the PM tries to announce the
> 'signal' list via the ADD_ADDR option. Since we currenlty lack

(detail, we can fix that later but: s/exausting/exhausting/ and =

s/currenlty/currently/ and s/signaled/signalled/ (or announced))

> the ADD_ADDR echo (and related event) only the first addr is sent.

It is not clear for me why the client has to announce addresses. But if =

it does that, it might be better to do it before creating additional =

subflows? The info in the ADD_ADDR sent by the clients could maybe be =

used in firewalls. Better to send them before then.

I guess we can change that later, it's not fixed with the API.

> > Idea is to add an additional PM hook for ADD_ADDR echo, to allow
> the PM netlink announcing multiple addresses, in sequence.

And later in parallel to avoid delays :-)

> v1  -> v2:
>   - explicitly reset pm status to idle after processing a command
>   - fix msk pm initialization
>   - fix mptcp_pm_nl_add_addr bugs
>   - added ifindex support
>   - hopefully clearer local function names
>   - always use  IS_ENABLED(CONFIG_MPTCP_IPV6) instead of
>      IS_ENABLED(CONFIG_IPV6)
> =

> RFC -> v1:
>   - simplified NL API
>   - reduced {WRITE,READ}_ONCE boilerplate due to PM changes
>   - add check for duplicate addresses
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>   include/uapi/linux/mptcp.h |  53 +++
>   net/mptcp/Makefile         |   3 +-
>   net/mptcp/pm.c             |  18 +-
>   net/mptcp/pm_netlink.c     | 828 +++++++++++++++++++++++++++++++++++++
>   net/mptcp/protocol.h       |   7 +
>   5 files changed, 907 insertions(+), 2 deletions(-)
>   create mode 100644 net/mptcp/pm_netlink.c
> =

> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 3912a9808fa2..8990c564680d 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -31,4 +31,57 @@ enum {
>   };
>   =

>   #define MPTCP_SUBFLOW_MAX (__MPTCP_SUBFLOW_MAX - 1)

Sorry, it's not linked to this patch but we should probably add "_ATTR" =

here (MPTCP_SUBFLOW_ATTR_MAX) and for all entries in the enum, because =

we could think here it is the maximum number of subflows we can have.

I can do the modification if it is not too late.

*Davide* : I guess no upstreamed version of ss are already using this, =

right? Anyway because this kernel code is not upstreamed, it's not too =

late to change, right? :)

> +
> +/* netlink interface */
> +#define MPTCP_PM_NAME		"mptcp_pm"
> +#define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
> +#define MPTCP_PM_VER		0x1

Should we add "_NETLINK" or "_NL" here above, just in case we have =

additional PMs later?

   MPTCP_PM_NL_NAME "mptcp_pm_netlink"

And maybe we should do the same below? e.g. "mptcp_pm_nl_attrs"

> +
> +/*
> + * ATTR types defined for MPTCP
> + */
> +enum mptcp_pm_attrs {
> +	MPTCP_PM_ATTR_UNSPEC,

Because this enum will be exposed to userspace, should we force the =

first item to be 0? (same below)
I guess most compiler will set it to 0 by default but I think the specs =

don't force them to do that.

(if yes, we should also do it for "MPTCP_SUBFLOW(_ATTR)_UNSPEC")

> +
> +	MPTCP_PM_ATTR_ADDR,				/* nested address */
> +	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
> +
> +	__MPTCP_PM_ATTR_MAX
> +};
> +
> +#define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
> +
> +enum mptcp_pm_addr_addrs {
> +	MPTCP_PM_ADDR_ATTR_UNSPEC,
> +
> +	MPTCP_PM_ADDR_ATTR_FAMILY,			/* u16 */
> +	MPTCP_PM_ADDR_ATTR_ID,				/* u8 */
> +	MPTCP_PM_ADDR_ATTR_ADDR4,			/* struct in_addr */
> +	MPTCP_PM_ADDR_ATTR_ADDR6,			/* struct in6_addr */
> +	MPTCP_PM_ADDR_ATTR_PORT,			/* u16 */

(It seems you are not using it)

> +	MPTCP_PM_ADDR_ATTR_FLAGS,			/* u32 */
> +	MPTCP_PM_ADDR_ATTR_IF_IDX,			/* s32 */
> +
> +	__MPTCP_PM_ADDR_ATTR_MAX
> +};
> +
> +#define MPTCP_PM_ADDR_ATTR_MAX (__MPTCP_PM_ADDR_ATTR_MAX - 1)
> +
> +#define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
> +#define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
> +#define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)

detail and we can fix it later if needed: I guess checkpatch will ask us =

to use BIT(0), etc.

> +
> +enum {
> +	MPTCP_CMD_UNSPEC,
> +
> +	MPTCP_CMD_ADD_ADDR,
> +	MPTCP_CMD_DEL_ADDR,
> +	MPTCP_CMD_GET_ADDR,
> +	MPTCP_CMD_FLUSH_ADDRS,
> +	MPTCP_CMD_SET_RCV_ADD_ADDRS,
> +	MPTCP_CMD_GET_RCV_ADD_ADDRS,
> +
> +	__MPTCP_CMD_AFTER_LAST
> +};

A detail but maybe important before it's too late: should we add "_PM" =

or "_PM_NL" in the list of commands?

Also it could be nice to add (later?) comments about the API: what does =

each command do, which (optional) parameters to use and what reply you =

will get (if any).

> +
>   #endif /* _UAPI_MPTCP_H */
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index faebe8ec9f73..baa0640527c7 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_MPTCP) +=3D mptcp.o
>   =

> -mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o=
 diag.o mib.o
> +mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o=
 diag.o \
> +	   mib.o pm_netlink.o

(detail: because we might want to do other modifications in mib.c, see =

above, should we also modify this commit to go to the new line in this =

commit?)

[...]

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> new file mode 100644
> index 000000000000..56847e16d206
> --- /dev/null
> +++ b/net/mptcp/pm_netlink.c
> @@ -0,0 +1,828 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Multipath TCP
> + *
> + * Copyright (c) 2020, Red Hat, Inc.
> + */
> +
> +#include <linux/inet.h>
> +#include <linux/kernel.h>
> +#include <net/tcp.h>
> +#include <net/netns/generic.h>
> +#include <net/mptcp.h>
> +#include <net/genetlink.h>
> +#include <uapi/linux/mptcp.h>
> +
> +#include "protocol.h"
> +
> +/* forward declaration */
> +static struct genl_family mptcp_genl_family;
> +
> +static int pm_nl_pernet_id;
> +
> +struct mptcp_pm_addr_entry {
> +	struct list_head	list;
> +	unsigned int		flags;
> +	int			ifindex;
> +	struct mptcp_addr_info	addr;
> +	struct rcu_head		rcu;
> +};
> +
> +struct pm_nl_pernet {
> +	/* protects pernet updates */
> +	spinlock_t		lock;
> +	struct list_head	addr_list;

detail: maybe clearer with local_addr_list?

Should we not maintain a list of remote_add_addr?

> +	unsigned int		addrs;
> +	unsigned int		add_addr_signal_max;
> +	unsigned int		add_addr_accept_max;
> +	unsigned int		local_addr_max;
> +	unsigned int		next_id;
> +};
> +
> +#define MPTCP_PM_ADDR_MAX	8
> +
> +static bool addresses_equal(const struct mptcp_addr_info *a,
> +			    struct mptcp_addr_info *b, bool use_port)
> +{
> +	bool addr_equals;
> +
> +	if (a->family !=3D b->family)
> +		return false;
> +
> +	if (a->family =3D=3D AF_INET)
> +		addr_equals =3D !memcmp(&a->addr, &b->addr, sizeof(b->addr));
> +	else

You need to surround this block with:

   #if IS_ENABLED(CONFIG_MPTCP_IPV6)

Out of curriosity, what's the recommended way to deal with IPv4 and =

IPv6: should we always have "else if (a->family =3D=3D AF_INET6)" (or a =

switch/case) or can we assume that if it is not v4, it is v6?

> +		addr_equals =3D !memcmp(&a->addr6, &b->addr6, sizeof(b->addr6));

detail: you can also use ipv6_addr_cmp(). (and not memcmp for v4?)

> +
> +	if (!addr_equals)
> +		return false;
> +	if (!use_port)
> +		return true;
> +
> +	return a->port =3D=3D b->port;
> +}
> +
> +static void local_address(const struct sock_common *skc,
> +			  struct mptcp_addr_info *addr)
> +{
> +	addr->family =3D skc->skc_family;

Should we copy the source port, just in case?

> +	if (addr->family =3D=3D AF_INET)
> +		addr->addr.s_addr =3D skc->skc_rcv_saddr;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	else if (addr->family =3D=3D AF_INET6)
> +		addr->addr6 =3D skc->skc_v6_rcv_saddr;
> +#endif
> +}
> +
> +static void remote_address(const struct sock_common *skc,
> +			   struct mptcp_addr_info *addr)
> +{
> +	addr->family =3D skc->skc_family;
> +	addr->port =3D skc->skc_dport;
> +	if (addr->family =3D=3D AF_INET)
> +		addr->addr.s_addr =3D skc->skc_daddr;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	else if (addr->family =3D=3D AF_INET6)
> +		addr->addr6 =3D skc->skc_v6_daddr;
> +#endif
> +}
> +
> +static bool lookup_subflow_by_saddr(const struct mptcp_sock *msk,
> +				    struct mptcp_addr_info *saddr)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_addr_info cur;
> +	struct sock_common *skc;
> +
> +	list_for_each_entry(subflow, &msk->conn_list, node) {
> +		skc =3D (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
> +
> +		local_address(skc, &cur);

I guess it's OK to do the copy to ease the comparison here below, right?
(we are going to do that only when creating subflows so it seems fine. =

Maybe should we add a comment if we reuse this function later?)

> +		if (addresses_equal(&cur, saddr, false))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static struct mptcp_pm_addr_entry *
> +select_local_address(const struct pm_nl_pernet *pernet,
> +		     const struct mptcp_sock *msk)
> +{
> +	struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(entry, &pernet->addr_list, list) {
> +		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
> +			continue;
> +		if (entry->addr.family =3D=3D ((struct sock *)msk)->sk_family &&
> +		    !lookup_subflow_by_saddr(msk, &entry->addr)) {
> +			ret =3D entry;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static struct mptcp_pm_addr_entry *
> +select_signal_address(struct pm_nl_pernet *pernet, unsigned int pos)
> +{
> +	struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
> +	int i =3D 0;
> +
> +	rcu_read_lock();
> +	/* do not keep any additional per socket state, just signal
> +	 * the address list in order.
> +	 * Note: removal from the local address list during the msk life-cycle
> +	 * can lead to additional addresses not being announced.
> +	 */
> +	list_for_each_entry_rcu(entry, &pernet->addr_list, list) {
> +		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> +			continue;
> +		if (i++ =3D=3D pos) {
> +			ret =3D entry;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static void check_work_pending(struct mptcp_sock *msk)
> +{
> +	if (msk->pm.add_addr_signaled =3D=3D msk->pm.add_addr_signal_max &&
> +	    msk->pm.local_addr_used =3D=3D msk->pm.local_addr_max)
> +		WRITE_ONCE(msk->pm.work_pending, false);
> +}
> +
> +static void mptcp_pm_create_subflow_or_signal(struct mptcp_sock *msk)

detail: I think we should avoid using signal alone because MP_FAIL, =

REM_ADD, MP_BACKUP, etc. are signals as well, no?
It's maybe just me but I find it clearer, when it is linked to ADD_ADDR, =

to use "announce" instead of the generic term "signal". But that's a =

detail. As long as it is clear for everybody :-)

> +{
> +	struct sock *sk =3D (struct sock *)msk;
> +	struct mptcp_pm_addr_entry *local;
> +	struct mptcp_addr_info remote;
> +	struct pm_nl_pernet *pernet;
> +
> +	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
> +
> +	lock_sock(sk);
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	msk->pm.status =3D MPTCP_PM_IDLE;
> +	pr_debug("local %d:%d signal %d:%d\n",
> +		 msk->pm.local_addr_used, msk->pm.local_addr_max,
> +		 msk->pm.add_addr_signaled, msk->pm.add_addr_signal_max);
> +
> +	/* check first if should create a new subflow */
> +	if (msk->pm.local_addr_used < msk->pm.local_addr_max) {
> +		remote_address((struct sock_common *)sk, &remote);
> +
> +		local =3D select_local_address(pernet, msk);
> +		if (local) {
> +			msk->pm.local_addr_used++;
> +			check_work_pending(msk);
> +			spin_unlock_bh(&msk->pm.lock);
> +			__mptcp_subflow_connect(sk, local->ifindex,
> +						&local->addr, &remote);

Should we do anything special if this fail?
(decrement local_addr_used? retry later?)

> +			release_sock(sk);
> +			return;
> +		}
> +
> +		/* lookup failed, avoid fourther attempts later */
> +		msk->pm.local_addr_used =3D msk->pm.local_addr_max;
> +		check_work_pending(msk);
> +	}
> +
> +	/* check for announce */
> +	if (msk->pm.add_addr_signaled < msk->pm.add_addr_signal_max) {
> +		local =3D select_signal_address(pernet,
> +					      msk->pm.add_addr_signaled);
> +
> +		if (local) {
> +			msk->pm.local_addr_used++;
> +			mptcp_pm_announce_addr(msk, &local->addr);
> +		} else {
> +			/* pick failed, avoid fourther attempts later */
> +			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
> +		}
> +
> +		check_work_pending(msk);
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +	release_sock(sk);
> +}
> +
> +void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
> +{
> +	mptcp_pm_create_subflow_or_signal(msk);
> +}
> +
> +void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
> +{
> +	mptcp_pm_create_subflow_or_signal(msk);
> +}
> +
> +void mptcp_pm_nl_add_addr(struct mptcp_sock *msk)

(it's maybe just me but should we rename this by adding "_recv"? Same =

for the caller and related functions because it was not clear we are =

doing some actions not add an address or produce an add_addr but because =

we just received one)

> +{
> +	struct sock *sk =3D (struct sock *)msk;
> +	struct mptcp_addr_info remote;
> +	struct mptcp_addr_info local;
> +	struct pm_nl_pernet *pernet;
> +
> +	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	msk->pm.status =3D MPTCP_PM_IDLE;
> +	pr_debug("accepted %d:%d remote family %d",
> +		 msk->pm.add_addr_accepted, msk->pm.add_addr_accept_max,
> +		 msk->pm.remote.family);
> +	if (++msk->pm.add_addr_accepted >=3D msk->pm.add_addr_accept_max)
> +		WRITE_ONCE(msk->pm.accept_addr, false);
> +
> +	/* connect to the specified remote address, using whatever
> +	 * local address the routing configuration will pick.
> +	 */

Should we try with all local IP the userspace added (+ the original =

one)? =E2=86=92 to have a fullmesh

> +	remote =3D msk->pm.remote;
> +	if (!remote.port)
> +		remote.port =3D sk->sk_dport;
> +	memset(&local, 0, sizeof(local));
> +	local.family =3D remote.family;
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	lock_sock(sk);
> +	__mptcp_subflow_connect((struct sock *)msk, 0, &local, &remote);

Should we do anything special if this fail?

> +	release_sock(sk);

Do we need to clear "pm.remote" somewhere? How do we deal with multiple =

received ADD_ADDR? Even if with the "echo", I guess we might receive a =

new one before the workqueue has finished dealing with the previous one, no?

> +}
> +
> +static bool address_use_port(struct mptcp_pm_addr_entry *entry)
> +{
> +	return (entry->flags &
> +		(MPTCP_PM_ADDR_FLAG_SIGNAL | MPTCP_PM_ADDR_FLAG_SUBFLOW)) =3D=3D
> +		MPTCP_PM_ADDR_FLAG_SIGNAL;
> +}
> +
> +static int mptcp_pm_nl_append_new_addr(struct pm_nl_pernet *pernet,

detail: Here as well, should we add _local =E2=86=92 new_local_addr?

> +				       struct mptcp_pm_addr_entry *entry)
> +{
> +	struct mptcp_pm_addr_entry *cur;
> +	int ret =3D -EINVAL;
> +
> +	spin_lock_bh(&pernet->lock);
> +	/* to keep the code simple, don't do IDR-like allocation for address ID,
> +	 * just bail when we exceed limits
> +	 */

And we also need to support REM_ADDR here I guess.

> +	if (pernet->next_id > 255)
> +		goto out;
> +	if (pernet->addrs >=3D MPTCP_PM_ADDR_MAX)
> +		goto out;
> +
> +	/* do not insert duplicate address, differentiate on port only
> +	 * singled addresses
> +	 */
> +	list_for_each_entry(cur, &pernet->addr_list, list) {
> +		if (addresses_equal(&cur->addr, &entry->addr,
> +				    address_use_port(entry) &&
> +				    address_use_port(cur)))
> +			goto out;
> +	}
> +
> +	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
> +		pernet->add_addr_signal_max++;
> +	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
> +		pernet->local_addr_max++;
> +
> +	entry->addr.id =3D pernet->next_id++;
> +	pernet->addrs++;
> +	list_add_tail_rcu(&entry->list, &pernet->addr_list);
> +	ret =3D entry->addr.id;
> +
> +out:
> +	spin_unlock_bh(&pernet->lock);
> +	return ret;
> +}
> +
> +int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common =
*skc)
> +{
> +	struct mptcp_pm_addr_entry *entry;
> +	struct mptcp_addr_info skc_local;
> +	struct mptcp_addr_info msk_local;
> +	struct pm_nl_pernet *pernet;
> +	int ret =3D -1;
> +
> +	if (WARN_ON_ONCE(!msk))
> +		return -1;
> +
> +	/* The 0 ID mapping is defined by the first subflow, copied into the msk
> +	 * addr
> +	 */

Is it still OK to do that if the first subflow is down (but other =

subflows exist)? I mean, no need to have additional check to see if the =

subflow 0 is still alive? (I didn't check what we do with the msk for =

this specific case)

> +	local_address((struct sock_common *)msk, &msk_local);
> +	local_address((struct sock_common *)msk, &skc_local);
> +	if (addresses_equal(&msk_local, &skc_local, false))
> +		return 0;
> +
> +	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(entry, &pernet->addr_list, list) {
> +		if (addresses_equal(&entry->addr, &skc_local, false)) {
> +			ret =3D entry->addr.id;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	if (ret >=3D 0)
> +		return ret;
> +
> +	/* address not found, add to local list */
> +	entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->flags =3D 0;
> +	entry->addr =3D skc_local;
> +	ret =3D mptcp_pm_nl_append_new_addr(pernet, entry);
> +	if (ret < 0)
> +		kfree(entry);
> +
> +	return ret;
> +}
> +
> +void mptcp_pm_nl_data_init(struct mptcp_sock *msk)
> +{
> +	struct pm_nl_pernet *pernet;
> +
> +	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
> +
> +	msk->pm.add_addr_signal_max =3D READ_ONCE(pernet->add_addr_signal_max);
> +	msk->pm.add_addr_accept_max =3D READ_ONCE(pernet->add_addr_accept_max);
> +	msk->pm.local_addr_max =3D READ_ONCE(pernet->local_addr_max);
> +	WRITE_ONCE(msk->pm.work_pending,
> +		   !!msk->pm.local_addr_max || !!msk->pm.add_addr_signal_max);
> +	WRITE_ONCE(msk->pm.accept_addr, !!msk->pm.add_addr_accept_max);
> +}
> +
> +#define MPTCP_PM_CMD_GRP_OFFSET	0
> +
> +static const struct genl_multicast_group mptcp_pm_mcgrps[] =3D {
> +	[MPTCP_PM_CMD_GRP_OFFSET]	=3D { .name =3D MPTCP_PM_CMD_GRP_NAME, },
> +};
> +
> +static const struct nla_policy
> +mptcp_pm_addr_policy[MPTCP_PM_ADDR_ATTR_MAX + 1] =3D {
> +	[MPTCP_PM_ADDR_ATTR_FAMILY]	=3D { .type	=3D NLA_U16,	},
> +	[MPTCP_PM_ADDR_ATTR_ID]		=3D { .type	=3D NLA_U8,	},
> +	[MPTCP_PM_ADDR_ATTR_ADDR4]	=3D { .type	=3D NLA_U32,	},
> +	[MPTCP_PM_ADDR_ATTR_ADDR6]	=3D { .type	=3D NLA_EXACT_LEN,
> +					    .len   =3D sizeof(struct in6_addr), },
> +	[MPTCP_PM_ADDR_ATTR_PORT]	=3D { .type	=3D NLA_U16	},
> +	[MPTCP_PM_ADDR_ATTR_FLAGS]	=3D { .type	=3D NLA_U32	},
> +	[MPTCP_PM_ADDR_ATTR_IF_IDX]     =3D { .type	=3D NLA_S32	},
> +};
> +
> +static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] =
=3D {
> +	[MPTCP_PM_ATTR_ADDR]		=3D
> +					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
> +	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	=3D { .type	=3D NLA_U32,	},
> +};
> +
> +static int mptcp_pm_family_to_addr(int family)
> +{
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (family =3D=3D AF_INET6)
> +		return MPTCP_PM_ADDR_ATTR_ADDR6;
> +#endif > +	return MPTCP_PM_ADDR_ATTR_ADDR4;
> +}
> +
> +static int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *in=
fo,
> +			       bool require_family,
> +			       struct mptcp_pm_addr_entry *entry)
> +{
> +	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
> +	int err, addr_addr;
> +
> +	if (!attr) {
> +		GENL_SET_ERR_MSG(info, "missing address info");
> +		return -EINVAL;
> +	}
> +
> +	/* no validation needed - was already done via nested policy */
> +	err =3D nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
> +					  mptcp_pm_addr_policy, info->extack);
> +	if (err)
> +		return err;
> +
> +	memset(entry, 0, sizeof(*entry));
> +	if (!tb[MPTCP_PM_ADDR_ATTR_FAMILY]) {
> +		if (!require_family)
> +			goto skip_family;
> +
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> +				    "missing family");
> +		return -EINVAL;
> +	}
> +
> +	entry->addr.family =3D nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_FAMILY]);
> +	if (entry->addr.family !=3D AF_INET
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	    && entry->addr.family !=3D AF_INET6
> +#endif
> +	    ) {
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> +				    "unknown address family");
> +		return -EINVAL;
> +	}
> +	addr_addr =3D mptcp_pm_family_to_addr(entry->addr.family);
> +	if (!tb[addr_addr]) {
> +		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> +				    "missing address data");
> +		return -EINVAL;
> +	}
> +
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (entry->addr.family =3D=3D AF_INET6)
> +		entry->addr.addr6 =3D nla_get_in6_addr(tb[addr_addr]);
> +	else
> +#endif
> +		entry->addr.addr.s_addr =3D nla_get_in_addr(tb[addr_addr]);
> +
> +skip_family:
> +	if (tb[MPTCP_PM_ADDR_ATTR_IF_IDX])
> +		entry->ifindex =3D nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
> +	else
> +		entry->ifindex =3D 0;

detail: "entry" is init to 0 at the beginning of this function. Same =

below for the ID. Or if you remove the memset, the flags are not set to 0

> +
> +	if (tb[MPTCP_PM_ADDR_ATTR_ID])
> +		entry->addr.id =3D nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_ID]);

Is it not a u8?

> +	else
> +		entry->addr.id =3D 0;
> +
> +	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
> +		entry->flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);

(detail if you have to modify this: please add a new line here because =

most of the time, there is an empty line after a if-statement block)

> +	return 0;
> +}
> +
> +static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
> +{
> +	return net_generic(genl_info_net(info), pm_nl_pernet_id);
> +}
> +
> +static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *=
info)
> +{
> +	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> +	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> +	struct mptcp_pm_addr_entry addr, *entry;
> +	int ret;
> +
> +	ret =3D mptcp_pm_parse_addr(attr, info, true, &addr);
> +	if (ret)

Out of curriosity, is there a recommendation on what to check with =

"ret"? I mean "ret" is vague and often we can see "if (ret < 0)", like =

below (also because it is needed in this case), which seems clearer to =

me. Sometimes, "err" is used and in this case, it is clear to read: "if =

(err)".
No need to change anything, it's just to know what's recommended but not =

mandatory I guess.

> +		return ret;
> +
> +	entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry) {
> +		GENL_SET_ERR_MSG(info, "can't allocate addr");
> +		return -ENOMEM;
> +	}
> +
> +	*entry =3D addr;
> +	ret =3D mptcp_pm_nl_append_new_addr(pernet, entry);
> +	if (ret < 0) {
> +		GENL_SET_ERR_MSG(info, "too many addresses");

detail: Or duplicated one.

> +		kfree(entry);
> +		return ret;
> +	}

Should we trigger here the establishement of new subflows and/or the =

send of ADD_ADDR for all existing MPTCP connections?

> +	return 0;
> +}
> +
> +static struct mptcp_pm_addr_entry *
> +__lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
> +{
> +	struct mptcp_pm_addr_entry *entry;
> +
> +	list_for_each_entry(entry, &pernet->addr_list, list) {
> +		if (entry->addr.id =3D=3D id)
> +			return entry;
> +	}
> +	return NULL;
> +}
> +
> +static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *=
info)
> +{
> +	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> +	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> +	struct mptcp_pm_addr_entry addr, *entry;
> +	int ret;
> +
> +	ret =3D mptcp_pm_parse_addr(attr, info, false, &addr);
> +	if (ret)
> +		return ret;
> +
> +	spin_lock_bh(&pernet->lock);
> +	entry =3D __lookup_addr_by_id(pernet, addr.addr.id);
> +	if (!entry) {
> +		GENL_SET_ERR_MSG(info, "address not found");
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
> +		pernet->add_addr_signal_max--;
> +	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
> +		pernet->local_addr_max--;
> +
> +	pernet->addrs--;
> +	list_del_rcu(&entry->list);
> +	kfree_rcu(entry, rcu);
> +out:
> +	spin_unlock_bh(&pernet->lock);
> +	return ret;
> +}
> +
> +static void __flush_addrs(struct pm_nl_pernet *pernet)
> +{
> +	while (!list_empty(&pernet->addr_list)) {
> +		struct mptcp_pm_addr_entry *cur;
> +
> +		cur =3D list_entry(pernet->addr_list.next,
> +				 struct mptcp_pm_addr_entry, list);
> +		list_del_rcu(&cur->list);
> +		kfree_rcu(cur, rcu);
> +	}
> +}
> +
> +static void __reset_counters(struct pm_nl_pernet *pernet)
> +{
> +	pernet->add_addr_signal_max =3D 0;
> +	pernet->add_addr_accept_max =3D 0;
> +	pernet->local_addr_max =3D 0;
> +	pernet->addrs =3D 0;
> +}
> +
> +static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_inf=
o *info)
> +{
> +	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> +
> +	spin_lock_bh(&pernet->lock);
> +	__flush_addrs(pernet);
> +	__reset_counters(pernet);
> +	spin_unlock_bh(&pernet->lock);
> +	return 0;
> +}
> +
> +static int mptcp_nl_fill_addr(struct sk_buff *skb,
> +			      struct mptcp_pm_addr_entry *entry)
> +{
> +	struct mptcp_addr_info *addr =3D &entry->addr;
> +	struct nlattr *attr;
> +
> +	attr =3D nla_nest_start(skb, MPTCP_PM_ATTR_ADDR);
> +	if (!attr)
> +		return -EMSGSIZE;
> +
> +	if (nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_FAMILY, addr->family))
> +		goto nla_put_failure;
> +	if (nla_put_u8(skb, MPTCP_PM_ADDR_ATTR_ID, addr->id))
> +		goto nla_put_failure;
> +	if (nla_put_u32(skb, MPTCP_PM_ADDR_ATTR_FLAGS, entry->flags))
> +		goto nla_put_failure;
> +	if (entry->ifindex &&
> +	    nla_put_s32(skb, MPTCP_PM_ADDR_ATTR_IF_IDX, entry->ifindex))
> +		goto nla_put_failure;
> +
> +	if (addr->family =3D=3D AF_INET)
> +		nla_put_in_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR4,
> +				addr->addr.s_addr);
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	else if (addr->family =3D=3D AF_INET6)
> +		nla_put_in6_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR6, &addr->addr6);
> +#endif
> +	nla_nest_end(skb, attr);
> +	return 0;
> +
> +nla_put_failure:
> +	nla_nest_cancel(skb, attr);
> +	return -EMSGSIZE;
> +}
> +
> +static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *=
info)
> +{
> +	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> +	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> +	struct mptcp_pm_addr_entry addr, *entry;
> +	struct sk_buff *msg;
> +	void *reply;
> +	int ret;
> +
> +	ret =3D mptcp_pm_parse_addr(attr, info, false, &addr);
> +	if (ret)
> +		return ret;
> +
> +	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	reply =3D genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
> +				  MPTCP_CMD_ADD_ADDR);

Should it not be MPTCP_CMD_GET_ADDR?

Can you not use info->genlhdr->cmd? (Same for the other genlmsg_put_reply())

> +	if (!reply) {
> +		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
> +		ret =3D -EMSGSIZE;
> +		goto fail;
> +	}
> +
> +	spin_lock_bh(&pernet->lock);
> +	entry =3D __lookup_addr_by_id(pernet, addr.addr.id);
> +	if (!entry) {
> +		GENL_SET_ERR_MSG(info, "address not found");
> +		ret =3D -EINVAL;
> +		goto unlock_fail;
> +	}
> +
> +	ret =3D mptcp_nl_fill_addr(msg, entry);
> +	if (ret)
> +		goto unlock_fail;
> +
> +	genlmsg_end(msg, reply);
> +	ret =3D genlmsg_reply(msg, info);
> +	spin_unlock_bh(&pernet->lock);
> +	return ret;
> +
> +unlock_fail:
> +	spin_unlock_bh(&pernet->lock);
> +
> +fail:
> +	nlmsg_free(msg);
> +	return ret;
> +}
> +
> +static int mptcp_nl_cmd_dump_addrs(struct sk_buff *msg,
> +				   struct netlink_callback *cb)
> +{
> +	struct net *net =3D sock_net(msg->sk);
> +	struct mptcp_pm_addr_entry *entry;
> +	struct pm_nl_pernet *pernet;
> +	int id =3D cb->args[0];
> +	void *hdr;
> +
> +	pernet =3D net_generic(net, pm_nl_pernet_id);
> +
> +	spin_lock_bh(&pernet->lock);
> +	list_for_each_entry(entry, &pernet->addr_list, list) {
> +		if (entry->addr.id <=3D id)
> +			continue;
> +
> +		hdr =3D genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
> +				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
> +				  NLM_F_MULTI, MPTCP_CMD_ADD_ADDR);

same here: should it be MPTCP_CMD_GET_ADDR?

> +		if (!hdr)
> +			break;
> +
> +		if (mptcp_nl_fill_addr(msg, entry) < 0) {
> +			genlmsg_cancel(msg, hdr);
> +			break;
> +		}
> +
> +		id =3D entry->addr.id;
> +		genlmsg_end(msg, hdr);
> +	}
> +	spin_unlock_bh(&pernet->lock);
> +
> +	cb->args[0] =3D id;
> +	return msg->len;
> +}
> +
> +static int
> +mptcp_nl_cmd_set_rcv_add_addrs(struct sk_buff *skb, struct genl_info *in=
fo)
> +{
> +	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_RCV_ADD_ADDRS];
> +	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> +	int limit;
> +
> +	if (!attr) {
> +		GENL_SET_ERR_MSG(info, "missing announce accept limit");
> +		return -EINVAL;
> +	}
> +
> +	limit =3D nla_get_u16(attr);

it should be u32 I think.

> +	if (limit > MPTCP_PM_ADDR_MAX) {
> +		GENL_SET_ERR_MSG(info,
> +				 "announce accept limit greater than maximum");
> +		return -EINVAL;
> +	}
> +
> +	WRITE_ONCE(pernet->add_addr_accept_max, limit);
> +	return 0;
> +}
> +
> +static int
> +mptcp_nl_cmd_get_rcv_add_addrs(struct sk_buff *skb, struct genl_info *in=
fo)
> +{
> +	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> +	struct sk_buff *msg;
> +	void *reply;
> +
> +	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	reply =3D genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
> +				  MPTCP_CMD_GET_RCV_ADD_ADDRS);
> +	if (!reply)
> +		goto fail;
> +
> +	if (nla_put_u32(msg, MPTCP_PM_ATTR_RCV_ADD_ADDRS,
> +			READ_ONCE(pernet->add_addr_accept_max)))
> +		goto fail;
> +
> +	genlmsg_end(msg, reply);
> +	return genlmsg_reply(msg, info);
> +
> +fail:
> +	GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
> +	nlmsg_free(msg);
> +	return -EMSGSIZE;
> +}
> +
> +static struct genl_ops mptcp_pm_ops[] =3D {
> +	{
> +		.cmd    =3D MPTCP_CMD_ADD_ADDR,
> +		.doit   =3D mptcp_nl_cmd_add_addr,
> +		.flags  =3D GENL_ADMIN_PERM,
> +	},
> +	{
> +		.cmd    =3D MPTCP_CMD_DEL_ADDR,
> +		.doit   =3D mptcp_nl_cmd_del_addr,
> +		.flags  =3D GENL_ADMIN_PERM,
> +	},
> +	{
> +		.cmd    =3D MPTCP_CMD_FLUSH_ADDRS,
> +		.doit   =3D mptcp_nl_cmd_flush_addrs,
> +		.flags  =3D GENL_ADMIN_PERM,
> +	},
> +	{
> +		.cmd    =3D MPTCP_CMD_GET_ADDR,
> +		.doit   =3D mptcp_nl_cmd_get_addr,
> +		.dumpit   =3D mptcp_nl_cmd_dump_addrs,
> +		.flags  =3D GENL_ADMIN_PERM,
> +	},
> +	{
> +		.cmd    =3D MPTCP_CMD_SET_RCV_ADD_ADDRS,
> +		.doit   =3D mptcp_nl_cmd_set_rcv_add_addrs,
> +		.flags  =3D GENL_ADMIN_PERM,
> +	},
> +	{
> +		.cmd    =3D MPTCP_CMD_GET_RCV_ADD_ADDRS,
> +		.doit   =3D mptcp_nl_cmd_get_rcv_add_addrs,
> +		.flags  =3D GENL_ADMIN_PERM,
> +	},
> +};
> +
> +static struct genl_family mptcp_genl_family __ro_after_init =3D {
> +	.name		=3D MPTCP_PM_NAME,
> +	.version	=3D MPTCP_PM_VER,
> +	.maxattr	=3D MPTCP_PM_ATTR_MAX,
> +	.policy		=3D mptcp_pm_policy,
> +	.netnsok	=3D true,
> +	.module		=3D THIS_MODULE,
> +	.ops		=3D mptcp_pm_ops,
> +	.n_ops		=3D ARRAY_SIZE(mptcp_pm_ops),
> +	.mcgrps		=3D mptcp_pm_mcgrps,
> +	.n_mcgrps	=3D ARRAY_SIZE(mptcp_pm_mcgrps),
> +};
> +
> +static int __net_init pm_nl_init_net(struct net *net)
> +{
> +	struct pm_nl_pernet *pernet =3D net_generic(net, pm_nl_pernet_id);
> +
> +	INIT_LIST_HEAD_RCU(&pernet->addr_list);
> +	__reset_counters(pernet);

I guess it's not strictly needed but doesn't hurt.

> +	pernet->next_id =3D 1;
> +	spin_lock_init(&pernet->lock);
> +	return 0;
> +}
> +
> +static void __net_exit pm_nl_exit_net(struct list_head *net_list)
> +{
> +	struct net *net;
> +
> +	list_for_each_entry(net, net_list, exit_list) {
> +		/* net is removed from namespace list, can't race with
> +		 * other modifiers
> +		 */
> +		__flush_addrs(net_generic(net, pm_nl_pernet_id));
> +	}
> +}
> +
> +static struct pernet_operations mptcp_pm_pernet_ops =3D {
> +	.init =3D pm_nl_init_net,
> +	.exit_batch =3D pm_nl_exit_net,
> +	.id =3D &pm_nl_pernet_id,
> +	.size =3D sizeof(struct pm_nl_pernet),
> +};
> +
> +void mptcp_pm_nl_init(void)
> +{
> +	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
> +		panic("Failed to register MPTCP PM pernet subsystem.\n");
> +
> +	if (genl_register_family(&mptcp_genl_family))
> +		panic("Failed to register MPTCP PM netlink family");

(detail: I guess you need "\n")

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6292471890790690459==--
