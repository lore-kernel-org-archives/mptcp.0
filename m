Content-Type: multipart/mixed; boundary="===============5986458995103379795=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 1/2] mptcp: Export low-level routines for IPv6
Date: Thu, 17 Oct 2019 11:12:08 +0200
Message-ID: <6d88a1f22660614c3b22f2cb892386af6244e76f.camel@redhat.com>
In-Reply-To: 20191017000206.10559-2-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2204

--===============5986458995103379795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2019-10-16 at 17:02 -0700, Peter Krystad wrote:
> All routines exported already have their IPv4 counterparts exported.
> tcp_request_sock_ipv6_ops will be referenced during TCP subflow
> creation.
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>

I guess this could be squashed into "tcp: Export TCP functions and ops
struct", right?

[...]

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e3d9f4559c99..1f3a87f4867e 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -75,7 +75,7 @@ static void	tcp_v6_reqsk_send_ack(const struct sock *sk=
, struct sk_buff *skb,
>  static int	tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb);
>  =

>  static const struct inet_connection_sock_af_ops ipv6_mapped;
> -static const struct inet_connection_sock_af_ops ipv6_specific;
> +const struct inet_connection_sock_af_ops ipv6_specific;
>  #ifdef CONFIG_TCP_MD5SIG
>  static const struct tcp_sock_af_ops tcp_sock_ipv6_specific;
>  static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
> @@ -99,7 +99,7 @@ static struct ipv6_pinfo *tcp_inet6_sk(const struct soc=
k *sk)
>  	return (struct ipv6_pinfo *)(((u8 *)sk) + offset);
>  }
>  =

> -static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *s=
kb)
> +void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
>  {
>  	struct dst_entry *dst =3D skb_dst(skb);
>  =

> @@ -111,6 +111,7 @@ static void inet6_sk_rx_dst_set(struct sock *sk, cons=
t struct sk_buff *skb)
>  		tcp_inet6_sk(sk)->rx_dst_cookie =3D rt6_get_cookie(rt);
>  	}
>  }
> +EXPORT_SYMBOL(inet6_sk_rx_dst_set);

I think this is not needed, as we don't build mptcp as a module.
Dropping the 'static' scope should suffice. This should apply also to
tcp_request_sock_ipv6_ops, tcp_v6_syn_recv_sock and ipv6_specific
below.

[...]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 791f2c19cfb8..6f09fdfdd523 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -268,6 +268,9 @@ int mptcp_subflow_connect(struct sock *sk, struct soc=
kaddr *local,
>  int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_soc=
k);
>  =

>  extern const struct inet_connection_sock_af_ops ipv4_specific;
> +#if IS_ENABLED(CONFIG_IPV6)
> +extern const struct inet_connection_sock_af_ops ipv6_specific;
> +#endif
>  =

>  void mptcp_proto_init(void);
> =

uhmm.. _if_ we want to squash these patches, this chunk should likely
go to a different patch than all the above - possibly "mptcp: Handle
MP_CAPABLE options for outgoing connections". Perhaps squashing is not
a good idea in this case.

Cheers,

Paolo

--===============5986458995103379795==--
