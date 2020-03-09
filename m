Content-Type: multipart/mixed; boundary="===============0987242655963485425=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: BUG: KASAN: slab-out-of-bounds in
 subflow_ulp_init+0xa6/0x190
Date: Mon, 09 Mar 2020 08:12:23 +0100
Message-ID: <d37203699e71a91fbab688b416ecad7c683d4808.camel@redhat.com>
In-Reply-To: 20200306230850.GQ33310@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 3895

--===============0987242655963485425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-06 at 15:08 -0800, Christoph Paasch wrote:
> Hello,
> =

> I wanted to do some testing on netnext so I did a little hack to
> force-enable MPTCP without the need for the app to use IPPROTO_MPTCP:
> =

> diff --git a/net/socket.c b/net/socket.c
> index b79a05de7c6e..56c656b4f867 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1374,6 +1374,9 @@ int __sock_create(struct net *net, int family, int =
type, int protocol,
>  	if (type < 0 || type >=3D SOCK_MAX)
>  		return -EINVAL;
> =

> +	if (protocol =3D=3D IPPROTO_TCP && type =3D=3D SOCK_STREAM && (family =
=3D=3D AF_INET || family =3D=3D AF_INET6))
> +		protocol =3D IPPROTO_MPTCP;
> +
>  	/* Compatibility.
> =

>  	   This uglymoron is moved from INET layer to here to avoid

Or you can use this:

https://github.com/pabeni/mptcp-tools

cd mptcp-tools

./use_mptcp.sh <app> ...

(will force mptcp usage via syscall hijaking)

/P

--===============0987242655963485425==--
