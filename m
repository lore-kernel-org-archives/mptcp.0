Content-Type: multipart/mixed; boundary="===============6480658263187314287=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 1/3] mptcp: create listening
 socket for new port
Date: Mon, 16 Nov 2020 18:42:23 +0100
Message-ID: <2ad1f083006c5489798b19f233badac10b4cf914.camel@redhat.com>
In-Reply-To: e25c8761f3dcd0a262e0578bf97001c875ca59d2.1605500515.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6755

--===============6480658263187314287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-16 at 12:30 +0800, Geliang Tang wrote:
> This patch created the listening socket from the kernel side, binded the
> new port to the listening socket, then listened.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> mptcp_subflow_create_socket will fail here since the sk->sk_socket is
> null. I simply dropped this null checking which was been added by Paolo
> in the commit "adf7341064982 (mptcp: be careful on subflow creation)".
> ---
>  net/mptcp/pm_netlink.c |  3 +++
>  net/mptcp/protocol.h   |  1 +
>  net/mptcp/subflow.c    | 55 +++++++++++++++++++++++++++++++++++-------
>  3 files changed, 50 insertions(+), 9 deletions(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index b325d04e65e7..b3514e8c01d3 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -347,6 +347,9 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
>  			if (mptcp_pm_alloc_anno_list(msk, local)) {
>  				msk->pm.add_addr_signaled++;
>  				mptcp_pm_announce_addr(msk, &local->addr, false, local->addr.port);
> +				spin_unlock_bh(&msk->pm.lock);
> +				mptcp_subflow_listen_new_port(msk, local->addr.port);
> +				spin_lock_bh(&msk->pm.lock);
>  				mptcp_pm_nl_add_addr_send_ack(msk);
>  			}
>  		} else {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 37c7d77d4376..0ee63f6b54b4 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -445,6 +445,7 @@ void mptcp_subflow_reset(struct sock *ssk);
>  int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_inf=
o *loc,
>  			    const struct mptcp_addr_info *remote);
>  int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_soc=
k);
> +void mptcp_subflow_listen_new_port(struct mptcp_sock *msk, __be16 port);
>  =

>  static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
>  					      struct mptcp_subflow_context *ctx)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e83f93d10612..38a77cc98d2b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1172,6 +1172,46 @@ int __mptcp_subflow_connect(struct sock *sk, const=
 struct mptcp_addr_info *loc,
>  	return err;
>  }
>  =

> +void mptcp_subflow_listen_new_port(struct mptcp_sock *msk, __be16 port)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk =3D (struct sock *)msk;
> +	struct mptcp_addr_info local;
> +	struct sockaddr_storage addr;
> +	struct socket *sf;
> +	int backlog =3D 20;
> +	int addrlen;
> +	int err;
> +
> +	if (!port)
> +		return;
> +
> +	if (!mptcp_is_fully_established(sk))
> +		return;
> +
> +	err =3D mptcp_subflow_create_socket(sk, &sf);
> +	if (err)
> +		return;
> +
> +	subflow =3D mptcp_subflow_ctx(sf->sk);
> +	subflow->request_mptcp =3D 1;
> +
> +	memset(&local, 0, sizeof(local));
> +	local.family =3D AF_INET;
> +	local.port =3D port;
> +	mptcp_info2sockaddr(&local, &addr);
> +	addrlen =3D sizeof(struct sockaddr_in);
> +	err =3D kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
> +	if (err)
> +		return;

I think there are some problems with this approach:

1) if we have multiple MPTCP sockets, only the first one per netns will
use the endpoint with the additional ports - the following will try to,
and bind() will fail.

2) what if the msk socket does fallback to TCP after that the
additional listening socket is created? =


3) ownership for the listening socket could be wrong, see below...

> +
> +	err =3D sf->ops->listen(sf, backlog);
> +	if (err)
> +		return;
> +
> +	pr_debug("listen_new_port done");
> +}
> +
>  static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
>  {
>  #ifdef CONFIG_SOCK_CGROUP_DATA
> @@ -1203,12 +1243,6 @@ int mptcp_subflow_create_socket(struct sock *sk, s=
truct socket **new_sock)
>  	struct socket *sf;
>  	int err;
>  =

> -	/* un-accepted server sockets can reach here - on bad configuration
> -	 * bail early to avoid greater trouble later
> -	 */
> -	if (unlikely(!sk->sk_socket))
> -		return -EINVAL;
> -
>  	err =3D sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
>  			       &sf);
>  	if (err)
> @@ -1241,9 +1275,12 @@ int mptcp_subflow_create_socket(struct sock *sk, s=
truct socket **new_sock)
>  	 * procfs/diag interaces really show this one belonging to the correct
>  	 * user.
>  	 */
> -	SOCK_INODE(sf)->i_ino =3D SOCK_INODE(sk->sk_socket)->i_ino;
> -	SOCK_INODE(sf)->i_uid =3D SOCK_INODE(sk->sk_socket)->i_uid;
> -	SOCK_INODE(sf)->i_gid =3D SOCK_INODE(sk->sk_socket)->i_gid;
> +
> +	if (sk->sk_socket) {
> +		SOCK_INODE(sf)->i_ino =3D SOCK_INODE(sk->sk_socket)->i_ino;
> +		SOCK_INODE(sf)->i_uid =3D SOCK_INODE(sk->sk_socket)->i_uid;
> +		SOCK_INODE(sf)->i_gid =3D SOCK_INODE(sk->sk_socket)->i_gid;
> +	}

When we hit the !sk->sk_socket scenario, ownership for the newly
created socket will be uncorrect.

Possibly a more important point: does the above ensure proper isolation
between processes and sockets ?

If I follow the code correctly, once that additional listening socket
is created, any join request landing there will be able to attach to
any msk - even outside the current netns with the current token infra.

I'm wondering if we could instead create a single listening socket per
netns - when the first msk socket is created. That should avoid bind
and fallback issues. Ownership should probably set explicitly to root,
and the isolation issue will be still there.

Cheers,

Paolo

--===============6480658263187314287==--
