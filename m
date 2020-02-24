Content-Type: multipart/mixed; boundary="===============2460224517422131150=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 7/9] mptcp: add netlink based PM
Date: Mon, 24 Feb 2020 13:07:28 +0100
Message-ID: <d525b75e43e89734d16b5df006c78a845c8f10a0.camel@redhat.com>
In-Reply-To: bd907bec-f7ff-0ee2-82ea-ee4acfc386f4@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3746

--===============2460224517422131150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the very detailed review. I'll try to cover your feedback
asap. I have a little more details below, but I would prefer post-
poning more complext stuff like full-mash and retry policy.

On Sat, 2020-02-22 at 17:38 +0100, Matthieu Baerts wrote:
> As always, it is very good! Sorry for the delay but here are various =

> questions and comments.
> =

> Note that I didn't really pay attention at how the locks were used, I =

> would be glad if someone could look at this specific point. I focused my =

> review more on the exposed API, general behaviour, Netlink stuff and typo=
s.
> =

> On 21/02/2020 17:48, Paolo Abeni wrote:
> > Expose to U/S a netlink family to control the PM, setting:
> > =

> >   - list of local addresses to be signaled.
> >   - list of local addresses used to created subflows.
> >   - maximum number of add_addr option to react
> =

> It looks a bit strange to me to limit in term of ADD_ADDR. I see that =

> all commands are linked to addresses which seem to make sense but I =

> don't know if it is good for a generic PM.
> =

> Depending on the strategy, you might create and accept more or less =

> subflows using the same list of local and remote addresses:
> =

>   - a client with a fullmesh strategy will create a subflow from each =

> local address to each remote ones having the same IP family. So if the =

> client and the server have each 2 (reachable) IPv4 A and B, there will =

> be 4 subflows: A-A, A-B, B-A, B-B.
> =

>   - another strategy could be like the fullmesh one but using each IP =

> only once: A-A, B-B
> =

>   - slightly different: create one subflow per network interface (from =

> the client, it is hard to know what the server has): both client and =

> server can have 2 NIC with one IPv4 and one v6 per NIC. The server will =

> announce the v4 and v6 of the other NIC and the client will use one IP =

> per interface: A4-A4, B4/6-B4/6 but not A4-A4, A6-A/B6, B4-B4, B6-B/A6 =

> like we would have with the previous strategy.
> =

>   - there are plenty of strategies for the client, e.g. ndiffport (more =

> subflows using the same IPs but different ports), etc. Many strategies =

> will be dedicated to one specific use-case, then requiring a more =

> advanced Netlink PM like the one in mptcp.org with mptcpd.
> =

>   - on the server side, I think there are less strategies. Of course, =

> some might require a more advanced Netlink

One of the main goals here was keeping this PM impl. as simple as
possible. I would defer any non trivial strategy to later.

With this patch the peer will create a subflow for each local address
(towards the "main" remote address) and one subflow for each received
and accepted ADD_ADDR, up to the specified limit, using whatever local
address the routing will pick. No full-mash.

The limit on the number of accepted address is to avoid the a malicius
peer to consume a lot of resources.

> PM but most of the time, the server's job is to announce addresses =

> and accept (or reject) subflows.
> =

> Also, another point: the client doesn't really have to send ADD_ADDR to =

> the server. The server could then receive MP_JOIN from IPs that are new =

> to the server, i.e. not announced by the client with ADD_ADDR.

Yep, the above is configurable with the proposed interface.

> Now, after having mentioned all these points, I think it can be =

> interesting to:
> =

>   - continue to manage addresses that can be announced / used to create =

> subflows.
> =

>   - continue to pick a single strategy for the moment. Maybe best to =

> start with fullmesh and if needed, the userspace can block some =

> combinations using NFTables (I almost wrote IPTables :-o). This can be =

> extended later by adding more strategies but I think we can already do =

> many things if the userspace selects which additional addresses to use.

I think a full-mash strategy would require a litte more state-tracking, =

but I'm unsure before starting coding it.

>   - instead of having a maximum number of received ADD_ADDR that can =

> use, it might be more generic to limit the number of created/accepted =

> subflows per MPTCP connection. If needed, this can be extended later =

> with other limits: number of subflow per interface or IP and per MPTCP =

> connection.

The maximum number of received ADD_ADDR limit allows to easily model
the 'server' behaviour (max accepted =3D=3D 0). We could add an additional
max_subflows limit, but I think it's only relevant if we do the full-
mash strategy.

> In other words, compared to this patch, only modifying how the limits =

> are managed to be more generic (I think).
> =

> What do you think about that?
> =

> =

> Maybe you still want to keep a limit for the received ADD_ADDR? I don't =

> think we store them for the moment? I guess MPTCP_PM_ADDR_MAX is enough =

> for now for the limit.

Yep, we don't store the remote addresses, and I would avoid that till
is possible - potentially we could have a lot of remote addresses per
namespace.

> > When the msk is fully established, the PM netlink attempts to
> > create subflow for each addr in 'local' list, waiting for each
> > connection to be completed before attempting the next one.
> =

> I guess it does that only for the client (connect, not listen).

The PM netlink currently does that for every peer with a configured not
empty local address list. Yep, for a server each subflow connection is
going to fail.

> > After exausting the 'local' list, the PM tries to announce the
> > 'signal' list via the ADD_ADDR option. Since we currenlty lack
> =

> (detail, we can fix that later but: s/exausting/exhausting/ and =

> s/currenlty/currently/ and s/signaled/signalled/ (or announced))
> =

> > the ADD_ADDR echo (and related event) only the first addr is sent.
> =

> It is not clear for me why the client has to announce addresses. =


Just because the RFC allows that and it's very easy to implement
-forbitting that would need some additional check. Also fits the unix
philosopy ;)

> But if =

> it does th	at, it might be better to do it before creating additional =

> subflows? The info in the ADD_ADDR sent by the clients could maybe be =

> used in firewalls. Better to send them before then.

Ok. Will do in the next iteration. Can you please explain the
'firewall' thing? who is used the ADD_ADDR opt?

> +/* netlink interface */
> > +#define MPTCP_PM_NAME		"mptcp_pm"
> > +#define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
> > +#define MPTCP_PM_VER		0x1
> =

> Should we add "_NETLINK" or "_NL" here above, just in case we have =

> additional PMs later?
> =

>    MPTCP_PM_NL_NAME "mptcp_pm_netlink"

The netlink name is limited to GENL_NAMSIZ(16) - comprising the
trailing '\0' so it will not fit. The 'nl' part sounds rendundant (this
is a nl interface), so I explicitly avoided that in the API

> And maybe we should do the same below? e.g. "mptcp_pm_nl_attrs"
> =

> > +
> > +/*
> > + * ATTR types defined for MPTCP
> > + */
> > +enum mptcp_pm_attrs {
> > +	MPTCP_PM_ATTR_UNSPEC,
> =

> Because this enum will be exposed to userspace, should we force the =

> first item to be 0? (same below)
> I guess most compiler will set it to 0 by default but I think the specs =

> don't force them to do that.

According to http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
the C99 specs require the first enum value being 0  - section 6.7.2.2
Enumeration specifiers, p: 105-106.

> > +
> > +	MPTCP_PM_ATTR_ADDR,				/* nested address */
> > +	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
> > +
> > +	__MPTCP_PM_ATTR_MAX
> > +};
> > +
> > +#define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
> > +
> > +enum mptcp_pm_addr_addrs {
> > +	MPTCP_PM_ADDR_ATTR_UNSPEC,
> > +
> > +	MPTCP_PM_ADDR_ATTR_FAMILY,			/* u16 */
> > +	MPTCP_PM_ADDR_ATTR_ID,				/* u8 */
> > +	MPTCP_PM_ADDR_ATTR_ADDR4,			/* struct in_addr */
> > +	MPTCP_PM_ADDR_ATTR_ADDR6,			/* struct in6_addr */
> > +	MPTCP_PM_ADDR_ATTR_PORT,			/* u16 */
> =

> (It seems you are not using it)

Currently not used, it's there to cope with the RFC allowing a MPTCP
peer to announce a local address on a specific port.

> > +	MPTCP_PM_ADDR_ATTR_FLAGS,			/* u32 */
> > +	MPTCP_PM_ADDR_ATTR_IF_IDX,			/* s32 */
> > +
> > +	__MPTCP_PM_ADDR_ATTR_MAX
> > +};
> > +
> > +#define MPTCP_PM_ADDR_ATTR_MAX (__MPTCP_PM_ADDR_ATTR_MAX - 1)
> > +
> > +#define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
> > +#define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
> > +#define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
> =

> detail and we can fix it later if needed: I guess checkpatch will ask us =

> to use BIT(0), etc.

Will do in next iteration.

> > +
> > +enum {
> > +	MPTCP_CMD_UNSPEC,
> > +
> > +	MPTCP_CMD_ADD_ADDR,
> > +	MPTCP_CMD_DEL_ADDR,
> > +	MPTCP_CMD_GET_ADDR,
> > +	MPTCP_CMD_FLUSH_ADDRS,
> > +	MPTCP_CMD_SET_RCV_ADD_ADDRS,
> > +	MPTCP_CMD_GET_RCV_ADD_ADDRS,
> > +
> > +	__MPTCP_CMD_AFTER_LAST
> > +};
> =

> A detail but maybe important before it's too late: should we add "_PM" =

> or "_PM_NL" in the list of commands?

Yep, will do in the next iteration.

> Also it could be nice to add (later?) comments about the API: what does =

> each command do, which (optional) parameters to use and what reply you =

> will get (if any).

Uhm... locking at existing genl family, this kind of documentation is
outside the scope of the uapi header ? I guess because it will bloat
the header too much ?!?

[...]
> > +struct pm_nl_pernet {
> > +	/* protects pernet updates */
> > +	spinlock_t		lock;
> > +	struct list_head	addr_list;
> =

> detail: maybe clearer with local_addr_list?

Ok, will change in next iteration

> Should we not maintain a list of remote_add_addr?

I explicitly tried to avoid that: a per netns list of remote addresses
could be quite long/expensive to maintain.

[...]
> > +static bool addresses_equal(const struct mptcp_addr_info *a,
> > +			    struct mptcp_addr_info *b, bool use_port)
> > +{
> > +	bool addr_equals;
> > +
> > +	if (a->family !=3D b->family)
> > +		return false;
> > +
> > +	if (a->family =3D=3D AF_INET)
> > +		addr_equals =3D !memcmp(&a->addr, &b->addr, sizeof(b->addr));
> > +	else
> =

> You need to surround this block with:
> =

>    #if IS_ENABLED(CONFIG_MPTCP_IPV6)

Will do in the next iteration.

> Out of curriosity, what's the recommended way to deal with IPv4 and =

> IPv6: should we always have "else if (a->family =3D=3D AF_INET6)" (or a =

> switch/case) or can we assume that if it is not v4, it is v6?

In this specific case, we can do this assumption, as the family has
been validated before (by the netlink callback and/or the socket code).

> =

> > +		addr_equals =3D !memcmp(&a->addr6, &b->addr6, sizeof(b->addr6));
> =

> detail: you can also use ipv6_addr_cmp(). (and not memcmp for v4?)

Will do in the next iteration.
> =

> > +
> > +	if (!addr_equals)
> > +		return false;
> > +	if (!use_port)
> > +		return true;
> > +
> > +	return a->port =3D=3D b->port;
> > +}
> > +
> > +static void local_address(const struct sock_common *skc,
> > +			  struct mptcp_addr_info *addr)
> > +{
> > +	addr->family =3D skc->skc_family;
> =

> Should we copy the source port, just in case?

The source port explicitly omitted for local addresses as it usually
changes across subflows and we want to ignore it. I'll add a comment in
the next iteration

> =

> > +	if (addr->family =3D=3D AF_INET)
> > +		addr->addr.s_addr =3D skc->skc_rcv_saddr;
> > +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > +	else if (addr->family =3D=3D AF_INET6)
> > +		addr->addr6 =3D skc->skc_v6_rcv_saddr;
> > +#endif
> > +}
> > +
> > +static void remote_address(const struct sock_common *skc,
> > +			   struct mptcp_addr_info *addr)
> > +{
> > +	addr->family =3D skc->skc_family;
> > +	addr->port =3D skc->skc_dport;
> > +	if (addr->family =3D=3D AF_INET)
> > +		addr->addr.s_addr =3D skc->skc_daddr;
> > +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > +	else if (addr->family =3D=3D AF_INET6)
> > +		addr->addr6 =3D skc->skc_v6_daddr;
> > +#endif
> > +}
> > +
> > +static bool lookup_subflow_by_saddr(const struct mptcp_sock *msk,
> > +				    struct mptcp_addr_info *saddr)
> > +{
> > +	struct mptcp_subflow_context *subflow;
> > +	struct mptcp_addr_info cur;
> > +	struct sock_common *skc;
> > +
> > +	list_for_each_entry(subflow, &msk->conn_list, node) {
> > +		skc =3D (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
> > +
> > +		local_address(skc, &cur);
> =

> I guess it's OK to do the copy to ease the comparison here below, right?
> (we are going to do that only when creating subflows so it seems fine. =

> Maybe should we add a comment if we reuse this function later?)

Are you concerned about performances? I think this is really
unnoticeable. The copied data will be in cache, possibly even in
registers, and the overhead to traverse the subflow list (with possibly
different cache misses per subflow) will be far greater.

> > +static void check_work_pending(struct mptcp_sock *msk)
> > +{
> > +	if (msk->pm.add_addr_signaled =3D=3D msk->pm.add_addr_signal_max &&
> > +	    msk->pm.local_addr_used =3D=3D msk->pm.local_addr_max)
> > +		WRITE_ONCE(msk->pm.work_pending, false);
> > +}
> > +
> > +static void mptcp_pm_create_subflow_or_signal(struct mptcp_sock *msk)
> =

> detail: I think we should avoid using signal alone because MP_FAIL, =

> REM_ADD, MP_BACKUP, etc. are signals as well, no?
> It's maybe just me but I find it clearer, when it is linked to ADD_ADDR, =

> to use "announce" instead of the generic term "signal". But that's a =

> detail. As long as it is clear for everybody :-)

I picked 'signal' because the term was already in use in the existing
code. I can change it to *'signal_addr' to be consistent with other
names.

> > +{
> > +	struct sock *sk =3D (struct sock *)msk;
> > +	struct mptcp_pm_addr_entry *local;
> > +	struct mptcp_addr_info remote;
> > +	struct pm_nl_pernet *pernet;
> > +
> > +	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
> > +
> > +	lock_sock(sk);
> > +
> > +	spin_lock_bh(&msk->pm.lock);
> > +	msk->pm.status =3D MPTCP_PM_IDLE;
> > +	pr_debug("local %d:%d signal %d:%d\n",
> > +		 msk->pm.local_addr_used, msk->pm.local_addr_max,
> > +		 msk->pm.add_addr_signaled, msk->pm.add_addr_signal_max);
> > +
> > +	/* check first if should create a new subflow */
> > +	if (msk->pm.local_addr_used < msk->pm.local_addr_max) {
> > +		remote_address((struct sock_common *)sk, &remote);
> > +
> > +		local =3D select_local_address(pernet, msk);
> > +		if (local) {
> > +			msk->pm.local_addr_used++;
> > +			check_work_pending(msk);
> > +			spin_unlock_bh(&msk->pm.lock);
> > +			__mptcp_subflow_connect(sk, local->ifindex,
> > +						&local->addr, &remote);
> =

> Should we do anything special if this fail?
> (decrement local_addr_used? retry later?)

IIRC, according to the RFC we must not retry if the address is
unreachable and/or the path is not MPTCP capable. So we should retry
only if failing e.g. due to an allocation error. Overall a correct
retry policy looks a bit too complex for this stage to me. I think we
can add that later, if needed.

[...]
> +void mptcp_pm_nl_add_addr(struct mptcp_sock *msk)
> =

> (it's maybe just me but should we rename this by adding "_recv"? Same =

> for the caller and related functions because it was not clear we are =

> doing some actions not add an address or produce an add_addr but because =

> we just received one)

Ok, will do in the next iteration.

> > +{
> > +	struct sock *sk =3D (struct sock *)msk;
> > +	struct mptcp_addr_info remote;
> > +	struct mptcp_addr_info local;
> > +	struct pm_nl_pernet *pernet;
> > +
> > +	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
> > +
> > +	spin_lock_bh(&msk->pm.lock);
> > +	msk->pm.status =3D MPTCP_PM_IDLE;
> > +	pr_debug("accepted %d:%d remote family %d",
> > +		 msk->pm.add_addr_accepted, msk->pm.add_addr_accept_max,
> > +		 msk->pm.remote.family);
> > +	if (++msk->pm.add_addr_accepted >=3D msk->pm.add_addr_accept_max)
> > +		WRITE_ONCE(msk->pm.accept_addr, false);
> > +
> > +	/* connect to the specified remote address, using whatever
> > +	 * local address the routing configuration will pick.
> > +	 */
> =

> Should we try with all local IP the userspace added (+ the original =

> one)? =E2=86=92 to have a fullmesh

I would postpone this one to later.
> =

> > +	remote =3D msk->pm.remote;
> > +	if (!remote.port)
> > +		remote.port =3D sk->sk_dport;
> > +	memset(&local, 0, sizeof(local));
> > +	local.family =3D remote.family;
> > +	spin_unlock_bh(&msk->pm.lock);
> > +
> > +	lock_sock(sk);
> > +	__mptcp_subflow_connect((struct sock *)msk, 0, &local, &remote);
> =

> Should we do anything special if this fail?

Same situation as the other __mptcp_subflow_connect()

> > +	release_sock(sk);
> =

> Do we need to clear "pm.remote" somewhere? How do we deal with multiple =

> received ADD_ADDR? Even if with the "echo", I guess we might receive a =

> new one before the workqueue has finished dealing with the previous one, =
no?

The idea is that the workqueue does sort of rate-limiting on subflow
creation. To cope with multiple 'concurrent' addresses we need to add
additiona/dynamic storage. IIRC the RFC allow us to ignore multiple
ADD_ADDR options as it fit us. =


> > +}
> > +
> > +static bool address_use_port(struct mptcp_pm_addr_entry *entry)
> > +{
> > +	return (entry->flags &
> > +		(MPTCP_PM_ADDR_FLAG_SIGNAL | MPTCP_PM_ADDR_FLAG_SUBFLOW)) =3D=3D
> > +		MPTCP_PM_ADDR_FLAG_SIGNAL;
> > +}
> > +
> > +static int mptcp_pm_nl_append_new_addr(struct pm_nl_pernet *pernet,
> =

> detail: Here as well, should we add _local =E2=86=92 new_local_addr?

Ok, will do in the next iteration.

> > +				       struct mptcp_pm_addr_entry *entry)
> > +{
> > +	struct mptcp_pm_addr_entry *cur;
> > +	int ret =3D -EINVAL;
> > +
> > +	spin_lock_bh(&pernet->lock);
> > +	/* to keep the code simple, don't do IDR-like allocation for address =
ID,
> > +	 * just bail when we exceed limits
> > +	 */
> =

> And we also need to support REM_ADDR here I guess.

Yes, we need to add REM_ADDR support. I think we don't need to add
anything specific with the current implementation: we don't store
locally remote addess, we don't have anything to delete and we will not
re-use them later anyway (due to lack of retry policy).

> > +	if (pernet->next_id > 255)
> > +		goto out;
> > +	if (pernet->addrs >=3D MPTCP_PM_ADDR_MAX)
> > +		goto out;
> > +
> > +	/* do not insert duplicate address, differentiate on port only
> > +	 * singled addresses
> > +	 */
> > +	list_for_each_entry(cur, &pernet->addr_list, list) {
> > +		if (addresses_equal(&cur->addr, &entry->addr,
> > +				    address_use_port(entry) &&
> > +				    address_use_port(cur)))
> > +			goto out;
> > +	}
> > +
> > +	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
> > +		pernet->add_addr_signal_max++;
> > +	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
> > +		pernet->local_addr_max++;
> > +
> > +	entry->addr.id =3D pernet->next_id++;
> > +	pernet->addrs++;
> > +	list_add_tail_rcu(&entry->list, &pernet->addr_list);
> > +	ret =3D entry->addr.id;
> > +
> > +out:
> > +	spin_unlock_bh(&pernet->lock);
> > +	return ret;
> > +}
> > +
> > +int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_commo=
n *skc)
> > +{
> > +	struct mptcp_pm_addr_entry *entry;
> > +	struct mptcp_addr_info skc_local;
> > +	struct mptcp_addr_info msk_local;
> > +	struct pm_nl_pernet *pernet;
> > +	int ret =3D -1;
> > +
> > +	if (WARN_ON_ONCE(!msk))
> > +		return -1;
> > +
> > +	/* The 0 ID mapping is defined by the first subflow, copied into the =
msk
> > +	 * addr
> > +	 */
> =

> Is it still OK to do that if the first subflow is down (but other =

> subflows exist)? I mean, no need to have additional check to see if the =

> subflow 0 is still alive? (I didn't check what we do with the msk for =

> this specific case)

We must always use the same ID for the same address inside an MTPCP
connection scope. Once we associate '0' to one local IP we should use
that association till the msk socket exists. With the current code, the
first subflow socket structure will exists till mptcp_close, even if
the related TCP connection is terminate well before. So this code
should be safe.

[...]
> > +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > +	if (entry->addr.family =3D=3D AF_INET6)
> > +		entry->addr.addr6 =3D nla_get_in6_addr(tb[addr_addr]);
> > +	else
> > +#endif
> > +		entry->addr.addr.s_addr =3D nla_get_in_addr(tb[addr_addr]);
> > +
> > +skip_family:
> > +	if (tb[MPTCP_PM_ADDR_ATTR_IF_IDX])
> > +		entry->ifindex =3D nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
> > +	else
> > +		entry->ifindex =3D 0;
> =

> detail: "entry" is init to 0 at the beginning of this function. Same =

> below for the ID. Or if you remove the memset, the flags are not set to 0

Will drop the 'else' branch in the next iteration.

> > +
> > +	if (tb[MPTCP_PM_ADDR_ATTR_ID])
> > +		entry->addr.id =3D nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_ID]);
> =

> Is it not a u8?

yep, funnily enough self-tests passes. Will fix in the next iteration.
> =

> > +	else
> > +		entry->addr.id =3D 0;
> > +
> > +	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
> > +		entry->flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
> =

> (detail if you have to modify this: please add a new line here because =

> most of the time, there is an empty line after a if-statement block)
> =

> > +	return 0;
> > +}
> > +
> > +static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
> > +{
> > +	return net_generic(genl_info_net(info), pm_nl_pernet_id);
> > +}
> > +
> > +static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info=
 *info)
> > +{
> > +	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> > +	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> > +	struct mptcp_pm_addr_entry addr, *entry;
> > +	int ret;
> > +
> > +	ret =3D mptcp_pm_parse_addr(attr, info, true, &addr);
> > +	if (ret)
> =

> Out of curriosity, is there a recommendation on what to check with =

> "ret"? I mean "ret" is vague and often we can see "if (ret < 0)", like =

> below (also because it is needed in this case), which seems clearer to =

> me. Sometimes, "err" is used and in this case, it is clear to read: "if =

> (err)".
> No need to change anything, it's just to know what's recommended but not =

> mandatory I guess.

I'll go with 'err' in the next iteration.

> > +		return ret;
> > +
> > +	entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
> > +	if (!entry) {
> > +		GENL_SET_ERR_MSG(info, "can't allocate addr");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	*entry =3D addr;
> > +	ret =3D mptcp_pm_nl_append_new_addr(pernet, entry);
> > +	if (ret < 0) {
> > +		GENL_SET_ERR_MSG(info, "too many addresses");
> =

> detail: Or duplicated one.
> =

> > +		kfree(entry);
> > +		return ret;
> > +	}
> =

> Should we trigger here the establishement of new subflows and/or the =

> send of ADD_ADDR for all existing MPTCP connections?

To keep the things simple, I would avoid that. For servers the number
of msk sockets to process could be high.

[...]
> > +static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info=
 *info)
> > +{
> > +	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> > +	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> > +	struct mptcp_pm_addr_entry addr, *entry;
> > +	struct sk_buff *msg;
> > +	void *reply;
> > +	int ret;
> > +
> > +	ret =3D mptcp_pm_parse_addr(attr, info, false, &addr);
> > +	if (ret)
> > +		return ret;
> > +
> > +	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> > +	reply =3D genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
> > +				  MPTCP_CMD_ADD_ADDR);
> =

> Should it not be MPTCP_CMD_GET_ADDR?
> =

> Can you not use info->genlhdr->cmd? (Same for the other genlmsg_put_reply=
())

I think you are right. I picked 'MPTCP_CMD_ADD_ADDR' because the reply
message is formatted exactly as a MPTCP_CMD_ADD_ADDR command, but it's
not the correct way to do this. Will fix in the next iteration.

> > =

> > +mptcp_nl_cmd_set_rcv_add_addrs(struct sk_buff *skb, struct genl_info *=
info)
> > +{
> > +	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_RCV_ADD_ADDRS];
> > +	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> > +	int limit;
> > +
> > +	if (!attr) {
> > +		GENL_SET_ERR_MSG(info, "missing announce accept limit");
> > +		return -EINVAL;
> > +	}
> > +
> > +	limit =3D nla_get_u16(attr);
> =

> it should be u32 I think.

Yep, will fix in the next iteration.

> > +static int __net_init pm_nl_init_net(struct net *net)
> > +{
> > +	struct pm_nl_pernet *pernet =3D net_generic(net, pm_nl_pernet_id);
> > +
> > +	INIT_LIST_HEAD_RCU(&pernet->addr_list);
> > +	__reset_counters(pernet);
> =

> I guess it's not strictly needed but doesn't hurt.

Needed on clone()

> > +void mptcp_pm_nl_init(void)
> > +{
> > +	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
> > +		panic("Failed to register MPTCP PM pernet subsystem.\n");
> > +
> > +	if (genl_register_family(&mptcp_genl_family))
> > +		panic("Failed to register MPTCP PM netlink family");
> =

> (detail: I guess you need "\n")
> =

will fix in the next iteration.

Thank you!

Paolo

--===============2460224517422131150==--
