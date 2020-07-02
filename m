Content-Type: multipart/mixed; boundary="===============6030910266420491893=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 1/4] inet_diag: support for wider protocol
 numbers
Date: Thu, 02 Jul 2020 14:23:29 -0700
Message-ID: <20200702212329.GJ97871@MacBook-Pro-64.local>
In-Reply-To: f19a6baeacbbcdef48e673c7dade96a023f41f45.1593192703.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4904

--===============6030910266420491893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06/26/20 - 19:33, Paolo Abeni wrote:
> After commit bf9765145b85 ("sock: Make sk_protocol a 16-bit value")
> the current size of 'sdiag_protocol' is not sufficient to represent
> the possible protocol values.
> =

> This change introduces a new inet diag request attribute to let
> user space specify the relevant protocol number using u32 values.
> =

> The attribute is parsed by inet diag core on get/dump command
> and the extended protocol value, if available, is preferred to
> 'sdiag_protocol' to lookup the diag handler.
> =

> The parse attributed are exposed to all the diag handlers via
> the cb->data.
> =

> Note that inet_diag_dump_one_icsk() is left unmodified, as it
> will not be used by protocol using the extended attribute.
> =

> Suggested-by: David S. Miller <davem(a)davemloft.net>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  include/uapi/linux/inet_diag.h |  1 +
>  net/core/sock.c                |  1 +
>  net/ipv4/inet_diag.c           | 63 +++++++++++++++++++++++++---------
>  3 files changed, 48 insertions(+), 17 deletions(-)
> =

> diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_dia=
g.h
> index e6f183ee8417..5ba122c1949a 100644
> --- a/include/uapi/linux/inet_diag.h
> +++ b/include/uapi/linux/inet_diag.h
> @@ -65,6 +65,7 @@ enum {
>  	INET_DIAG_REQ_NONE,
>  	INET_DIAG_REQ_BYTECODE,
>  	INET_DIAG_REQ_SK_BPF_STORAGES,
> +	INET_DIAG_REQ_PROTOCOL,
>  	__INET_DIAG_REQ_MAX,
>  };
>  =

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 6c4acf1f0220..b359e29bb737 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3573,6 +3573,7 @@ int sock_load_diag_module(int family, int protocol)
>  #ifdef CONFIG_INET
>  	if (family =3D=3D AF_INET &&
>  	    protocol !=3D IPPROTO_RAW &&
> +	    protocol < MAX_INET_PROTOS &&
>  	    !rcu_access_pointer(inet_protos[protocol]))
>  		return -ENOENT;
>  #endif
> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index 125f4f8a36b4..a3a7ef3fada6 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -52,6 +52,9 @@ static DEFINE_MUTEX(inet_diag_table_mutex);
>  =

>  static const struct inet_diag_handler *inet_diag_lock_handler(int proto)
>  {
> +	if (proto >=3D IPPROTO_MAX)
> +		return ERR_PTR(-ENOENT);

Just here by email so that it's not lost in IRC,... and so that it is picked
up in patchwork:


Cfr. https://github.com/multipath-tcp/mptcp_net-next/issues/44

This needs to be if (proto < 0 || proto >=3D IPPROTO_MAX).

I tried that out and my syzkaller reproducers are no more panicking the
system.


Christoph

--===============6030910266420491893==--
