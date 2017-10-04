Content-Type: multipart/mixed; boundary="===============1725355878921455705=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 05/18] tcp6: Prepare for maximum TCP option-space
Date: Wed, 04 Oct 2017 15:33:35 -0700
Message-ID: <alpine.OSX.2.21.1710041523440.28273@syyang-mobl2.amr.corp.intel.com>
In-Reply-To: 20171003162204.17945-6-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 115

--===============1725355878921455705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 3 Oct 2017, Christoph Paasch wrote:

> With a generic TCP-option framework we don't know in advance how much
> space will be used. So, estimate the worst and allocate the maximum.
> Later on, we pull skb->tail back in again.

v2 of the option registration patch will conflict with this. The prepare =

callback does figure out the number of option bytes required before =

writing to the outgoing skb, so that can happen before the alloc_skb().


Mat


>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
> net/ipv6/tcp_ipv6.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 64d94afa427f..17f7e0cd8755 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -784,17 +784,11 @@ static void tcp_v6_send_response(const struct sock =
*sk, struct sk_buff *skb, u32
> 	struct flowi6 fl6;
> 	struct net *net =3D sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
> 	struct sock *ctl_sk =3D net->ipv6.tcp_sk;
> -	unsigned int tot_len =3D sizeof(struct tcphdr);
> +	unsigned int tot_len =3D sizeof(struct tcphdr) + MAX_TCP_OPTION_SPACE;
> +	unsigned int reduce =3D 0; /* By how much to pull skb->tail back in? */
> 	struct dst_entry *dst;
> 	__be32 *topt;
>
> -	if (tsecr)
> -		tot_len +=3D TCPOLEN_TSTAMP_ALIGNED;
> -#ifdef CONFIG_TCP_MD5SIG
> -	if (key)
> -		tot_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> -#endif
> -
> 	buff =3D alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
> 			 GFP_ATOMIC);
> 	if (!buff)
> @@ -823,6 +817,8 @@ static void tcp_v6_send_response(const struct sock *s=
k, struct sk_buff *skb, u32
> 				(TCPOPT_TIMESTAMP << 8) | TCPOLEN_TIMESTAMP);
> 		*topt++ =3D htonl(tsval);
> 		*topt++ =3D htonl(tsecr);
> +
> +		reduce +=3D TCPOLEN_TSTAMP_ALIGNED;
> 	}
>
> #ifdef CONFIG_TCP_MD5SIG
> @@ -832,9 +828,13 @@ static void tcp_v6_send_response(const struct sock *=
sk, struct sk_buff *skb, u32
> 		tcp_v6_md5_hash_hdr((__u8 *)topt, key,
> 				    &ipv6_hdr(skb)->saddr,
> 				    &ipv6_hdr(skb)->daddr, t1);
> +
> +		reduce +=3D TCPOLEN_MD5SIG_ALIGNED;
> 	}
> #endif
>
> +	buff->tail -=3D reduce;
> +
> 	memset(&fl6, 0, sizeof(fl6));
> 	fl6.daddr =3D ipv6_hdr(skb)->saddr;
> 	fl6.saddr =3D ipv6_hdr(skb)->daddr;
> -- =

> 2.14.1
>
>

--
Mat Martineau
Intel OTC

--===============1725355878921455705==--
