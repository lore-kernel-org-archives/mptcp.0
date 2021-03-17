Content-Type: multipart/mixed; boundary="===============2776359072183568473=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 1/7] mptcp: move ifindex and
 flags out of mptcp_addr_info
Date: Tue, 16 Mar 2021 17:41:17 -0700
Message-ID: <9da17f2-9317-1b16-d8a9-63f93c5558f3@linux.intel.com>
In-Reply-To: 99f18e22afb27fe97f0fc2cdfaeca8917b2a44b3.1615878331.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8176

--===============2776359072183568473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Mar 2021, Geliang Tang wrote:

> This patch moved the ifindex and flags fields from struct mptcp_addr_info
> to struct mptcp_pm_addr_entry.
>
> It __mptcp_subflow_connect, use container_of to get mptcp_pm_addr_entry
> from its parameter loc, then read out the entry's ifindex and flags value=
s.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 47 ++++++++++++++++++------------------------
> net/mptcp/protocol.h   | 11 ++++++++--
> net/mptcp/subflow.c    |  6 ++++--
> 3 files changed, 33 insertions(+), 31 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index a62f887c5198..181d8048cac1 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -22,13 +22,6 @@ static struct genl_family mptcp_genl_family;
>
> static int pm_nl_pernet_id;
>
> -struct mptcp_pm_addr_entry {
> -	struct list_head	list;
> -	struct mptcp_addr_info	addr;
> -	struct rcu_head		rcu;
> -	struct socket		*lsk;
> -};
> -
> struct mptcp_pm_add_entry {
> 	struct list_head	list;
> 	struct mptcp_addr_info	addr;
> @@ -168,7 +161,7 @@ select_local_address(const struct pm_nl_pernet *perne=
t,
> 	rcu_read_lock();
> 	__mptcp_flush_join_list(msk);
> 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> -		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
> +		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
> 			continue;
>
> 		if (entry->addr.family !=3D sk->sk_family) {
> @@ -206,7 +199,7 @@ select_signal_address(struct pm_nl_pernet *pernet, un=
signed int pos)
> 	 * can lead to additional addresses not being announced.
> 	 */
> 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> -		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> +		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> 			continue;
> 		if (i++ =3D=3D pos) {
> 			ret =3D entry;
> @@ -484,8 +477,8 @@ static void mptcp_pm_nl_add_addr_received(struct mptc=
p_sock *msk)
> {
> 	struct sock *sk =3D (struct sock *)msk;
> 	unsigned int add_addr_accept_max;
> +	struct mptcp_pm_addr_entry local;
> 	struct mptcp_addr_info remote;
> -	struct mptcp_addr_info local;
> 	unsigned int subflows_max;
>
> 	add_addr_accept_max =3D mptcp_pm_get_add_addr_accept_max(msk);
> @@ -511,10 +504,10 @@ static void mptcp_pm_nl_add_addr_received(struct mp=
tcp_sock *msk)
> 	if (!remote.port)
> 		remote.port =3D sk->sk_dport;
> 	memset(&local, 0, sizeof(local));
> -	local.family =3D remote.family;
> +	local.addr.family =3D remote.family;
>
> 	spin_unlock_bh(&msk->pm.lock);
> -	__mptcp_subflow_connect(sk, &local, &remote);
> +	__mptcp_subflow_connect(sk, &local.addr, &remote);
> 	spin_lock_bh(&msk->pm.lock);
>
> add_addr_echo:
> @@ -683,7 +676,7 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
>
> static bool address_use_port(struct mptcp_pm_addr_entry *entry)
> {
> -	return (entry->addr.flags &
> +	return (entry->flags &
> 		(MPTCP_PM_ADDR_FLAG_SIGNAL | MPTCP_PM_ADDR_FLAG_SUBFLOW)) =3D=3D
> 		MPTCP_PM_ADDR_FLAG_SIGNAL;
> }
> @@ -735,11 +728,11 @@ static int mptcp_pm_nl_append_new_local_addr(struct=
 pm_nl_pernet *pernet,
> 	if (entry->addr.id > pernet->next_id)
> 		pernet->next_id =3D entry->addr.id;
>
> -	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
> +	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
> 		addr_max =3D pernet->add_addr_signal_max;
> 		WRITE_ONCE(pernet->add_addr_signal_max, addr_max + 1);
> 	}
> -	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
> +	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
> 		addr_max =3D pernet->local_addr_max;
> 		WRITE_ONCE(pernet->local_addr_max, addr_max + 1);
> 	}
> @@ -841,10 +834,10 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk=
, struct sock_common *skc)
> 		return -ENOMEM;
>
> 	entry->addr =3D skc_local;
> -	entry->addr.ifindex =3D 0;
> -	entry->addr.flags =3D 0;
> 	entry->addr.id =3D 0;
> 	entry->addr.port =3D 0;
> +	entry->ifindex =3D 0;
> +	entry->flags =3D 0;
> 	entry->lsk =3D NULL;
> 	ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
> 	if (ret < 0)
> @@ -959,14 +952,14 @@ static int mptcp_pm_parse_addr(struct nlattr *attr,=
 struct genl_info *info,
> 	if (tb[MPTCP_PM_ADDR_ATTR_IF_IDX]) {
> 		u32 val =3D nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
>
> -		entry->addr.ifindex =3D val;
> +		entry->ifindex =3D val;
> 	}
>
> 	if (tb[MPTCP_PM_ADDR_ATTR_ID])
> 		entry->addr.id =3D nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
>
> 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
> -		entry->addr.flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
> +		entry->flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
>
> 	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
> 		entry->addr.port =3D htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
> @@ -1218,11 +1211,11 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *=
skb, struct genl_info *info)
> 		spin_unlock_bh(&pernet->lock);
> 		return -EINVAL;
> 	}
> -	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
> +	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
> 		addr_max =3D pernet->add_addr_signal_max;
> 		WRITE_ONCE(pernet->add_addr_signal_max, addr_max - 1);
> 	}
> -	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
> +	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
> 		addr_max =3D pernet->local_addr_max;
> 		WRITE_ONCE(pernet->local_addr_max, addr_max - 1);
> 	}
> @@ -1338,10 +1331,10 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
> 		goto nla_put_failure;
> 	if (nla_put_u8(skb, MPTCP_PM_ADDR_ATTR_ID, addr->id))
> 		goto nla_put_failure;
> -	if (nla_put_u32(skb, MPTCP_PM_ADDR_ATTR_FLAGS, entry->addr.flags))
> +	if (nla_put_u32(skb, MPTCP_PM_ADDR_ATTR_FLAGS, entry->flags))
> 		goto nla_put_failure;
> -	if (entry->addr.ifindex &&
> -	    nla_put_s32(skb, MPTCP_PM_ADDR_ATTR_IF_IDX, entry->addr.ifindex))
> +	if (entry->ifindex &&
> +	    nla_put_s32(skb, MPTCP_PM_ADDR_ATTR_IF_IDX, entry->ifindex))
> 		goto nla_put_failure;
>
> 	if (addr->family =3D=3D AF_INET &&
> @@ -1569,7 +1562,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *s=
kb, struct genl_info *info)
> 	if (ret < 0)
> 		return ret;
>
> -	if (addr.addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> +	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> 		bkup =3D 1;
>
> 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> @@ -1579,9 +1572,9 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *s=
kb, struct genl_info *info)
> 				return ret;
>
> 			if (bkup)
> -				entry->addr.flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
> +				entry->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
> 			else
> -				entry->addr.flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
> +				entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
> 		}
> 	}
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index e53a9568d587..af7624419fb0 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -173,8 +173,6 @@ struct mptcp_addr_info {
> 	sa_family_t		family;
> 	__be16			port;
> 	u8			id;
> -	u8			flags;
> -	int			ifindex;
> 	union {
> 		struct in_addr addr;
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> @@ -183,6 +181,15 @@ struct mptcp_addr_info {
> 	};
> };
>
> +struct mptcp_pm_addr_entry {
> +	struct list_head	list;
> +	struct mptcp_addr_info	addr;
> +	u8			flags;
> +	int			ifindex;
> +	struct rcu_head		rcu;
> +	struct socket		*lsk;
> +};
> +
> enum mptcp_pm_status {
> 	MPTCP_PM_ADD_ADDR_RECEIVED,
> 	MPTCP_PM_ADD_ADDR_SEND_ACK,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6af443a18bac..f4d754546c2a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1255,6 +1255,7 @@ int __mptcp_subflow_connect(struct sock *sk, const =
struct mptcp_addr_info *loc,
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> 	struct mptcp_subflow_context *subflow;
> +	struct mptcp_pm_addr_entry *entry;
> 	struct sockaddr_storage addr;
> 	int remote_id =3D remote->id;
> 	int local_id =3D loc->id;
> @@ -1295,7 +1296,8 @@ int __mptcp_subflow_connect(struct sock *sk, const =
struct mptcp_addr_info *loc,
> 	if (addr.ss_family =3D=3D AF_INET6)
> 		addrlen =3D sizeof(struct sockaddr_in6);
> #endif
> -	ssk->sk_bound_dev_if =3D loc->ifindex;
> +	entry =3D container_of(loc, struct mptcp_pm_addr_entry, addr);

I prefer the v1 approach of changing the function parameter. If you'd like =

to avoid moving the mptcp_pm_addr_entry struct to protocol.h, maybe add =

parameters to this function for flags and ifindex instead?

> +	ssk->sk_bound_dev_if =3D entry->ifindex;
> 	err =3D kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
> 	if (err)
> 		goto failed;
> @@ -1307,7 +1309,7 @@ int __mptcp_subflow_connect(struct sock *sk, const =
struct mptcp_addr_info *loc,
> 	subflow->local_id =3D local_id;
> 	subflow->remote_id =3D remote_id;
> 	subflow->request_join =3D 1;
> -	subflow->request_bkup =3D !!(loc->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> +	subflow->request_bkup =3D !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
>
> 	mptcp_add_pending_subflow(msk, subflow);
> -- =

> 2.30.2

--
Mat Martineau
Intel
--===============2776359072183568473==--
