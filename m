Content-Type: multipart/mixed; boundary="===============3810938479250804943=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v8 mptcp-next 1/8] mptcp: create the
 listening socket for new port
Date: Thu, 17 Dec 2020 16:14:18 -0800
Message-ID: <9ddfba39-10bb-e7d2-b1f0-9eafdf47932a@linux.intel.com>
In-Reply-To: 81bbbc826edf123d47abfa74dbaf9e0674689cf2.1607823272.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7210

--===============3810938479250804943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 13 Dec 2020, Geliang Tang wrote:

> This patch created a listening socket when an address with a port-number
> is added by PM netlink. Then binded the new port to the socket, and
> listened for the connection.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 64 ++++++++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.c   |  2 +-
> net/mptcp/protocol.h   |  3 ++
> net/mptcp/subflow.c    |  4 +--
> 4 files changed, 70 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 9b1f6298bbdb..1548efb22a1b 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -26,6 +26,7 @@ struct mptcp_pm_addr_entry {
> 	struct list_head	list;
> 	struct mptcp_addr_info	addr;
> 	struct rcu_head		rcu;
> +	struct socket		*lsk;
> };
>
> struct mptcp_pm_add_entry {
> @@ -613,6 +614,53 @@ static int mptcp_pm_nl_append_new_local_addr(struct =
pm_nl_pernet *pernet,
> 	return ret;
> }
>
> +static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> +					    struct mptcp_pm_addr_entry *entry)
> +{
> +	struct sockaddr_storage addr;
> +	struct mptcp_sock *msk;
> +	struct socket *ssock;
> +	int backlog =3D 1024;
> +	int err;
> +
> +	err =3D sock_create_kern(sock_net(sk), entry->addr.family,
> +			       SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
> +	if (err)
> +		return err;
> +
> +	msk =3D mptcp_sk(entry->lsk->sk);
> +	if (!msk) {
> +		err =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	ssock =3D __mptcp_nmpc_socket(msk);
> +	if (!ssock) {
> +		err =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	mptcp_info2sockaddr(&entry->addr, &addr);
> +	err =3D kernel_bind(ssock, (struct sockaddr *)&addr,
> +			  sizeof(struct sockaddr_in));
> +	if (err) {
> +		pr_warn("kernel_bind error, err=3D%d", err);
> +		goto out;
> +	}
> +
> +	err =3D kernel_listen(ssock, backlog);
> +	if (err) {
> +		pr_warn("kernel_listen error, err=3D%d", err);
> +		goto out;
> +	}
> +
> +	return 0;
> +
> +out:
> +	sock_release(entry->lsk);
> +	return err;
> +}
> +
> int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *=
skc)
> {
> 	struct mptcp_pm_addr_entry *entry;
> @@ -657,6 +705,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, =
struct sock_common *skc)
> 	entry->addr.ifindex =3D 0;
> 	entry->addr.flags =3D 0;
> 	entry->addr.id =3D 0;
> +	entry->addr.port =3D 0;
> +	entry->lsk =3D NULL;
> 	ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
> 	if (ret < 0)
> 		kfree(entry);
> @@ -808,9 +858,19 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb=
, struct genl_info *info)
> 	}
>
> 	*entry =3D addr;
> +	if (entry->addr.port) {
> +		ret =3D mptcp_pm_nl_create_listen_socket(skb->sk, entry);
> +		if (ret) {
> +			GENL_SET_ERR_MSG(info, "create listen socket error");
> +			kfree(entry);
> +			return ret;
> +		}
> +	}
> 	ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
> 	if (ret < 0) {
> 		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
> +		if (entry->lsk)
> +			sock_release(entry->lsk);
> 		kfree(entry);
> 		return ret;
> 	}
> @@ -921,6 +981,8 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb,=
 struct genl_info *info)
> 	spin_unlock_bh(&pernet->lock);
>
> 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
> +	if (entry->lsk)
> +		sock_release(entry->lsk);
> 	kfree_rcu(entry, rcu);

Releasing the socket here could be racy - since the list is rcu-protected, =

the entry could still be accessed (which is why it's freed with =

kfree_rcu()). Rather than calling kfree_rcu(), use a custom callback with =

call_rcu() that will both release lsk and kfree the list entry.

>
> 	return ret;
> @@ -934,6 +996,8 @@ static void __flush_addrs(struct net *net, struct lis=
t_head *list)
> 		cur =3D list_entry(list->next,
> 				 struct mptcp_pm_addr_entry, list);
> 		mptcp_nl_remove_subflow_and_signal_addr(net, &cur->addr);
> +		if (cur->lsk)
> +			sock_release(cur->lsk);
> 		list_del_rcu(&cur->list);
> 		kfree_rcu(cur, rcu);

Same issue as above with sock_release() and rcu.


Mat

> 	}
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8ec9e4582d18..79e1b34ecb53 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -49,7 +49,7 @@ static void __mptcp_check_send_data_fin(struct sock *sk=
);
>  * completed yet or has failed, return the subflow socket.
>  * Otherwise return NULL.
>  */
> -static struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
> +struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
> {
> 	if (!msk->subflow || READ_ONCE(msk->can_ack))
> 		return NULL;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d6400ad2d615..a2a031cca97a 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -473,11 +473,14 @@ void mptcp_subflow_shutdown(struct sock *sk, struct=
 sock *ssk, int how);
> void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		       struct mptcp_subflow_context *subflow);
> void mptcp_subflow_reset(struct sock *ssk);
> +struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
>
> /* called with sk socket lock held */
> int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info=
 *loc,
> 			    const struct mptcp_addr_info *remote);
> int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock=
);
> +void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> +			 struct sockaddr_storage *addr);
>
> static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
> 					      struct mptcp_subflow_context *ctx)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 73e66a406d99..c64a1c41a29b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1073,8 +1073,8 @@ void mptcpv6_handle_mapped(struct sock *sk, bool ma=
pped)
> }
> #endif
>
> -static void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> -				struct sockaddr_storage *addr)
> +void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> +			 struct sockaddr_storage *addr)
> {
> 	memset(addr, 0, sizeof(*addr));
> 	addr->ss_family =3D info->family;
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============3810938479250804943==--
