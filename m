Content-Type: multipart/mixed; boundary="===============8687105575948110894=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] Squash-to: "mptcp: remove
 addr and subflow in PM netlink v9" Part 2
Date: Thu, 17 Sep 2020 12:12:28 +0200
Message-ID: <80b94c083e968672f79142d4be98d4b9f50ae636.camel@redhat.com>
In-Reply-To: 57ece514d409fce62437ab651c91e48565376746.1600334143.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5912

--===============8687105575948110894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-09-17 at 17:19 +0800, Geliang Tang wrote:
> This patch fixed BUG in mptcp_pm_free_anno_list(). mptcp_pm_free_anno_list
> may be called when PM has not been inited, then we'll get the "NULL point=
er
> dereference" BUG.
> =

> This patch moved __mptcp_init_sock call before the !mptcp_is_enabled()
> check in mptcp_init_sock(). No matter mptcp is enabled or not, we all
> called __mptcp_init_sock to init the mptcp socket.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/90
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/protocol.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5fe9bfc3c76f..5f9a073f3813 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1833,16 +1833,16 @@ static int mptcp_init_sock(struct sock *sk)
>  	struct net *net =3D sock_net(sk);
>  	int ret;
>  =

> +	ret =3D __mptcp_init_sock(sk);
> +	if (ret)
> +		return ret;
> +
>  	if (!mptcp_is_enabled(net))
>  		return -ENOPROTOOPT;
>  =

>  	if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
>  		return -ENOMEM;
>  =

> -	ret =3D __mptcp_init_sock(sk);
> -	if (ret)
> -		return ret;
> -
>  	ret =3D __mptcp_socket_create(mptcp_sk(sk));
>  	if (ret)
>  		return ret;

LGTM, thanks!

/P

--===============8687105575948110894==--
