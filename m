Content-Type: multipart/mixed; boundary="===============8604933919259501516=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 2/9] mptcp: set the listening
 socket's subflow
Date: Wed, 25 Nov 2020 10:24:56 +0100
Message-ID: <f011270ffb2897b12632af508b6d0db6c3be28f4.camel@redhat.com>
In-Reply-To: a9094a27297f9782b7bf8063e9f41a0eb3a81871.1606272852.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6921

--===============8604933919259501516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-25 at 11:01 +0800, Geliang Tang wrote:
> This patch set the subflow context of the listening socket.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/pm_netlink.c |  5 +++++
>  net/mptcp/protocol.h   |  1 +
>  net/mptcp/subflow.c    | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 0d9a3c77fdf1..39a91fcac403 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -330,6 +330,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(s=
truct mptcp_sock *msk)
>  			if (mptcp_pm_alloc_anno_list(msk, local)) {
>  				msk->pm.add_addr_signaled++;
>  				mptcp_pm_announce_addr(msk, &local->addr, false, local->addr.port);
> +				if (local->addr.port) {
> +					spin_unlock_bh(&msk->pm.lock);
> +					mptcp_pm_set_listen_socket_subflow(sk, local->lsk);

Why it's needed to this at announce time? Why not at lsk creation time?
Probably more related to the previous patch, why lsk is TCP socket
instead of an MPTCP one? (I feel the latter would be a more natural
choice, but it's just a feeling).

> +					spin_lock_bh(&msk->pm.lock);
> +				}
>  				mptcp_pm_nl_add_addr_send_ack(msk);
>  			}
>  		} else {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f202e22058b5..38001b7b0bf6 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -469,6 +469,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
>  int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_soc=
k);
>  void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
>  			 struct sockaddr_storage *addr);
> +int mptcp_pm_set_listen_socket_subflow(struct sock *sk, struct socket *s=
f);
>  =

>  static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
>  					      struct mptcp_subflow_context *ctx)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d4c136f1e754..6053a88c176f 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1208,6 +1208,43 @@ int mptcp_subflow_create_socket(struct sock *sk, s=
truct socket **new_sock)
>  	return 0;
>  }
>  =

> +int mptcp_pm_set_listen_socket_subflow(struct sock *sk, struct socket *s=
f)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct net *net =3D sock_net(sk);
> +	int err;
> +
> +	if (!sf)
> +		return -EINVAL;
> +
> +	lock_sock(sf->sk);
> +
> +	mptcp_attach_cgroup(sk, sf->sk);

This will likely not work if there are multiple MPTCP sockets using
this endpoint.

Possibly the cgroup attaching should be done at subflow_syn_recv_sock()
time, for the child socket, with some custom code - because it must
override the existing cgroup inherited from the listener.

/P

--===============8604933919259501516==--
