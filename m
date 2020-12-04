Content-Type: multipart/mixed; boundary="===============1698762148123047042=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v7 mptcp-next 1/7] mptcp: create the
 listening socket for new port
Date: Thu, 03 Dec 2020 17:36:08 -0800
Message-ID: <373b7226-6933-47a3-73c2-938b755189a@linux.intel.com>
In-Reply-To: 9bfd982aa08d39d84846b7fa655230dc11e91f1c.1606716547.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7032

--===============1698762148123047042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Nov 2020, Geliang Tang wrote:

> This patch created a listening socket when an address with a port-number
> is added by PM netlink. Then binded the new port to the socket, and
> listened for the connection.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 58 ++++++++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.c   |  2 +-
> net/mptcp/protocol.h   |  3 +++
> net/mptcp/subflow.c    |  4 +--
> 4 files changed, 64 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 5151cfcd6962..c296927bf167 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -26,6 +26,7 @@ struct mptcp_pm_addr_entry {
> 	struct list_head	list;
> 	struct mptcp_addr_info	addr;
> 	struct rcu_head		rcu;
> +	struct socket		*lsk;

Two things to fix up:

Non-zero lsk is not released everywhere mptcp_pm_addr_entry structs are =

freed.

lsk is not initialized in mptcp_pm_nl_get_local_id()

> };
>
> struct mptcp_pm_add_entry {
> @@ -732,6 +733,53 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct g=
enl_info *info)
> 	return net_generic(genl_info_net(info), pm_nl_pernet_id);
> }
>
> +static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> +					    struct mptcp_pm_addr_entry *entry)
> +{
> +	struct sockaddr_storage addr;
> +	struct mptcp_sock *msk;
> +	struct socket *ssock;
> +	int backlog =3D 20;

Any comment on the choice of '20' here? Could it be too small for a high =

connection rate, or worth a sysctl?

Thanks,

Mat

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
> static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *i=
nfo)
> {
> 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> @@ -750,9 +798,19 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb=
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
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4c36969873b9..5e464dfc0f6f 100644
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
> index 9d8f01aac91c..ec179f3a6b4b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -466,11 +466,14 @@ void mptcp_subflow_shutdown(struct sock *sk, struct=
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
> index 96c585f003f8..43cc5e2c3234 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1035,8 +1035,8 @@ void mptcpv6_handle_mapped(struct sock *sk, bool ma=
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

> 2.26.2

--
Mat Martineau
Intel
--===============1698762148123047042==--
