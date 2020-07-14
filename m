Content-Type: multipart/mixed; boundary="===============6290525372406102920=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC 02/11] tcp: remove cookie_ts bit from
 request_sock
Date: Tue, 14 Jul 2020 12:29:24 -0700
Message-ID: <20200714192924.GF73500@MacBook-Pro-64.local>
In-Reply-To: 20200714182514.25250-3-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5009

--===============6290525372406102920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 07/14/20 - 20:25, Florian Westphal wrote:
> No need for this anymore; nowadays output function
> has a 'synack_type' that tells us when the syn/ack is emitted
> via syncookies.  The request already tells us when timestamps
> are supported, so we can check both to detect when we need the
> special timestamp for tcp option encoding.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  include/net/request_sock.h | 3 +--
>  net/ipv4/tcp_input.c       | 2 --
>  net/ipv4/tcp_output.c      | 2 +-
>  3 files changed, 2 insertions(+), 5 deletions(-)
> =

> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index cf8b33213bbc..2f717d4dafc5 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
> @@ -54,8 +54,7 @@ struct request_sock {
>  	struct request_sock		*dl_next;
>  	u16				mss;
>  	u8				num_retrans; /* number of retransmits */
> -	u8				cookie_ts:1; /* syncookie: encode tcpopts in timestamp */

just a minor nit:

drivers/crypto/chelsio/chtls/chtls_cm.c is writing to that field as well - =
so
you need to remove that there as well.


Christoph

> -	u8				num_timeout:7; /* number of timeouts */
> +	u8				num_timeout; /* number of timeouts */
>  	u32				ts_recent;
>  	struct timer_list		rsk_timer;
>  	const struct request_sock_ops	*rsk_ops;
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 61c808864f6b..d8b9d09eb472 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6510,7 +6510,6 @@ static void tcp_openreq_init(struct request_sock *r=
eq,
>  	struct inet_request_sock *ireq =3D inet_rsk(req);
>  =

>  	req->rsk_rcv_wnd =3D 0;		/* So that tcp_send_synack() knows! */
> -	req->cookie_ts =3D 0;
>  	tcp_rsk(req)->rcv_isn =3D TCP_SKB_CB(skb)->seq;
>  	tcp_rsk(req)->rcv_nxt =3D TCP_SKB_CB(skb)->seq + 1;
>  	tcp_rsk(req)->snt_synack =3D 0;
> @@ -6730,7 +6729,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_o=
ps,
>  =

>  	if (want_cookie) {
>  		isn =3D cookie_init_sequence(af_ops, sk, skb, &req->mss);
> -		req->cookie_ts =3D tmp_opt.tstamp_ok;
>  		if (!tmp_opt.tstamp_ok)
>  			inet_rsk(req)->ecn_ok =3D 0;
>  	}
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 2d563efcee0d..2ab9c9c4ce85 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3388,7 +3388,7 @@ struct sk_buff *tcp_make_synack(const struct sock *=
sk, struct dst_entry *dst,
>  	memset(&opts, 0, sizeof(opts));
>  	now =3D tcp_clock_ns();
>  #ifdef CONFIG_SYN_COOKIES
> -	if (unlikely(req->cookie_ts))
> +	if (unlikely(synack_type =3D=3D TCP_SYNACK_COOKIE && inet_rsk(req)->tst=
amp_ok))
>  		skb->skb_mstamp_ns =3D cookie_init_timestamp(req, now);
>  	else
>  #endif
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============6290525372406102920==--
