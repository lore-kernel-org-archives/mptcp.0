Content-Type: multipart/mixed; boundary="===============0881060641537622598=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 02/10] mptcp: add the pernet
 listening socket operations
Date: Fri, 20 Nov 2020 11:24:39 +0100
Message-ID: <d4301f95265166734fca79d9919f9f9c8c5faa2c.camel@redhat.com>
In-Reply-To: f16560fc78e2f308ac191511eb2d1b5478ef9f9a.1605780306.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6877

--===============0881060641537622598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-19 at 18:19 +0800, Geliang Tang wrote:
> This patch added three new pernet listening socket operations:
> =

> mptcp_pm_alloc_listen_socket, mptcp_pm_free_listen_socket and
> mptcp_pm_get_listen_socket to alloc, free and get the pernet
> listening socket.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/pm_netlink.c | 54 ++++++++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.c   |  5 ++++
>  net/mptcp/protocol.h   |  5 ++++
>  net/mptcp/subflow.c    |  2 +-
>  4 files changed, 65 insertions(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 2560c502356b..19d557df4684 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -45,6 +45,8 @@ struct pm_nl_pernet {
>  	unsigned int		add_addr_accept_max;
>  	unsigned int		local_addr_max;
>  	unsigned int		subflows_max;
> +	struct socket		*listen_socket;
> +	bool			sock_created;
>  	unsigned int		next_id;
>  };
>  =

> @@ -306,6 +308,56 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>  	}
>  }
>  =

> +int mptcp_pm_alloc_listen_socket(struct mptcp_sock *msk)
> +{
> +	struct sock *sk =3D (struct sock *)msk;
> +	struct pm_nl_pernet *pernet;
> +	bool need_create =3D false;
> +
> +	pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
> +
> +	spin_lock_bh(&pernet->lock);
> +	if (!pernet->sock_created) {
> +		pernet->sock_created =3D true;
> +		need_create =3D true;
> +	}
> +	spin_unlock_bh(&pernet->lock);
> +
> +	if (!need_create)
> +		return 0;
> +
> +	return mptcp_create_listen_socket(sk, &pernet->listen_socket);
> +}
> +
> +void mptcp_pm_free_listen_socket(struct mptcp_sock *msk)
> +{
> +	struct sock *sk =3D (struct sock *)msk;
> +	struct pm_nl_pernet *pernet;
> +
> +	pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
> +
> +	if (!pernet || !pernet->listen_socket || !pernet->listen_socket->sk)
> +		return;
> +
> +	subflow_drop_ctx(pernet->listen_socket->sk);
> +	sock_release(pernet->listen_socket);
> +	pernet->listen_socket =3D NULL;
> +	pernet->sock_created =3D false;
> +}
> +
> +struct socket *mptcp_pm_get_listen_socket(struct mptcp_sock *msk)
> +{
> +	struct pm_nl_pernet *pernet;
> +	struct sock *sk =3D (struct sock *)msk;
> +
> +	pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
> +
> +	if (!pernet)
> +		return NULL;
> +
> +	return pernet->listen_socket;
> +}
> +
>  static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *ms=
k)
>  {
>  	struct mptcp_addr_info remote =3D { 0 };
> @@ -885,6 +937,8 @@ static void __reset_counters(struct pm_nl_pernet *per=
net)
>  	pernet->add_addr_accept_max =3D 0;
>  	pernet->local_addr_max =3D 0;
>  	pernet->addrs =3D 0;
> +	pernet->listen_socket =3D NULL;
> +	pernet->sock_created =3D false;
>  }
>  =

>  static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_inf=
o *info)
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7a0364860feb..1a9e895e953e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2006,6 +2006,10 @@ static int mptcp_init_sock(struct sock *sk)
>  	if (ret)
>  		return ret;
>  =

> +	ret =3D mptcp_pm_alloc_listen_socket(mptcp_sk(sk));
> +	if (ret)
> +		return ret;
> +
>  	sk_sockets_allocated_inc(sk);
>  	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
>  	sk->sk_sndbuf =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[1];

I think the listening socket creation and bind should be done at
endpoint creation time, that is, while handling the
MPTCP_PM_CMD_ADD_ADDR netlink command.

The socket pointer itself could be stored inside the 'struct
mptcp_pm_addr_entr'.

That way we will have the socket created only when needed, and deleted
when unneeded. Additionally we could have several ports per netns, we
will not have to bind the socket at run-time, and the user space could
be notified in case of socket creation or bind failure.

Hopefully codying wise should not be a large change WRT the current
version.

WDYT?

Paolo

--===============0881060641537622598==--
