Content-Type: multipart/mixed; boundary="===============9196336872484465356=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 13/18] tcp_md5: Detect key inside
 tcp_v6_send_response instead of passing it as an argument
Date: Thu, 05 Oct 2017 13:24:14 -0700
Message-ID: <alpine.OSX.2.21.1710051310150.36366@smurali1-mobl.amr.corp.intel.com>
In-Reply-To: 20171003162204.17945-14-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 121

--===============9196336872484465356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 3 Oct 2017, Christoph Paasch wrote:

> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
> net/ipv6/tcp_ipv6.c | 106 ++++++++++++++++++++++++++---------------------=
-----
> 1 file changed, 53 insertions(+), 53 deletions(-)
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 17f7e0cd8755..f1afa3236c4a 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -775,8 +775,7 @@ static const struct tcp_request_sock_ops tcp_request_=
sock_ipv6_ops =3D {
>
> static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *s=
kb, u32 seq,
> 				 u32 ack, u32 win, u32 tsval, u32 tsecr,
> -				 int oif, struct tcp_md5sig_key *key, int rst,
> -				 u8 tclass, __be32 label)
> +				 int oif, int rst, u8 tclass, __be32 label)
> {
> 	const struct tcphdr *th =3D tcp_hdr(skb);
> 	struct tcphdr *t1;
> @@ -789,6 +788,12 @@ static void tcp_v6_send_response(const struct sock *=
sk, struct sk_buff *skb, u32
> 	struct dst_entry *dst;
> 	__be32 *topt;
>
> +#ifdef CONFIG_TCP_MD5SIG
> +	struct tcp_md5sig_key *key =3D NULL;
> +	const __u8 *hash_location =3D NULL;
> +	struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
> +#endif
> +
> 	buff =3D alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
> 			 GFP_ATOMIC);
> 	if (!buff)
> @@ -822,6 +827,48 @@ static void tcp_v6_send_response(const struct sock *=
sk, struct sk_buff *skb, u32
> 	}
>
> #ifdef CONFIG_TCP_MD5SIG
> +	rcu_read_lock();
> +	hash_location =3D tcp_parse_md5sig_option(th);
> +	if (sk && sk_fullsock(sk)) {
> +		key =3D tcp_v6_md5_do_lookup(sk, &ipv6h->saddr);
> +	} else if (sk && sk->sk_state =3D=3D TCP_TIME_WAIT) {
> +		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
> +
> +		key =3D tcp_twsk_md5_key(tcptw);
> +	} else if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
> +		key =3D tcp_v6_md5_do_lookup(sk, &ipv6h->daddr);
> +	} else if (hash_location) {
> +		unsigned char newhash[16];
> +		struct sock *sk1 =3D NULL;
> +		int genhash;
> +
> +		/* active side is lost. Try to find listening socket through
> +		 * source port, and then find md5 key through listening socket.
> +		 * we are not loose security here:
> +		 * Incoming packet is checked with md5 hash with finding key,
> +		 * no RST generated if md5 hash doesn't match.
> +		 */
> +		sk1 =3D inet6_lookup_listener(dev_net(skb_dst(skb)->dev),
> +					    &tcp_hashinfo, NULL, 0,
> +					    &ipv6h->saddr,
> +					    th->source, &ipv6h->daddr,
> +					    ntohs(th->source), tcp_v6_iif(skb),
> +					    tcp_v6_sdif(skb));
> +		if (!sk1)
> +			goto go_on;
> +
> +		key =3D tcp_v6_md5_do_lookup(sk1, &ipv6h->saddr);
> +		if (!key)
> +			goto go_on;
> +
> +		genhash =3D tcp_v6_md5_hash_skb(newhash, key, NULL, skb);
> +		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
> +			goto go_on;

I see where this came from in tcp_v6_send_reset(), but the pasted code =

doesn't preserve the same behavior (and the goto does nothing, so the =

conditional does nothing). I haven't looked ahead yet to see if it gets =

fixed up in a later patch, but it seems like the intent is for these =

patches to be bisectable.


Mat


> +	}
> +
> +go_on:
> +	rcu_read_unlock();
> +
> 	if (key) {
> 		*topt++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
> 				(TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
> @@ -882,14 +929,6 @@ static void tcp_v6_send_reset(const struct sock *sk,=
 struct sk_buff *skb)
> {
> 	const struct tcphdr *th =3D tcp_hdr(skb);
> 	u32 seq =3D 0, ack_seq =3D 0;
> -	struct tcp_md5sig_key *key =3D NULL;
> -#ifdef CONFIG_TCP_MD5SIG
> -	const __u8 *hash_location =3D NULL;
> -	struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
> -	unsigned char newhash[16];
> -	int genhash;
> -	struct sock *sk1 =3D NULL;
> -#endif
> 	int oif;
>
> 	if (th->rst)
> @@ -901,38 +940,6 @@ static void tcp_v6_send_reset(const struct sock *sk,=
 struct sk_buff *skb)
> 	if (!sk && !ipv6_unicast_destination(skb))
> 		return;
>
> -#ifdef CONFIG_TCP_MD5SIG
> -	rcu_read_lock();
> -	hash_location =3D tcp_parse_md5sig_option(th);
> -	if (sk && sk_fullsock(sk)) {
> -		key =3D tcp_v6_md5_do_lookup(sk, &ipv6h->saddr);
> -	} else if (hash_location) {
> -		/*
> -		 * active side is lost. Try to find listening socket through
> -		 * source port, and then find md5 key through listening socket.
> -		 * we are not loose security here:
> -		 * Incoming packet is checked with md5 hash with finding key,
> -		 * no RST generated if md5 hash doesn't match.
> -		 */
> -		sk1 =3D inet6_lookup_listener(dev_net(skb_dst(skb)->dev),
> -					   &tcp_hashinfo, NULL, 0,
> -					   &ipv6h->saddr,
> -					   th->source, &ipv6h->daddr,
> -					   ntohs(th->source), tcp_v6_iif(skb),
> -					   tcp_v6_sdif(skb));
> -		if (!sk1)
> -			goto out;
> -
> -		key =3D tcp_v6_md5_do_lookup(sk1, &ipv6h->saddr);
> -		if (!key)
> -			goto out;
> -
> -		genhash =3D tcp_v6_md5_hash_skb(newhash, key, NULL, skb);
> -		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
> -			goto out;
> -	}
> -#endif
> -
> 	if (th->ack)
> 		seq =3D ntohl(th->ack_seq);
> 	else
> @@ -940,20 +947,14 @@ static void tcp_v6_send_reset(const struct sock *sk=
, struct sk_buff *skb)
> 			  (th->doff << 2);
>
> 	oif =3D sk ? sk->sk_bound_dev_if : 0;
> -	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, key, 1, 0, 0);
> -
> -#ifdef CONFIG_TCP_MD5SIG
> -out:
> -	rcu_read_unlock();
> -#endif
> +	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1, 0, 0);
> }
>
> static void tcp_v6_send_ack(const struct sock *sk, struct sk_buff *skb, u=
32 seq,
> 			    u32 ack, u32 win, u32 tsval, u32 tsecr, int oif,
> -			    struct tcp_md5sig_key *key, u8 tclass,
> -			    __be32 label)
> +			    u8 tclass, __be32 label)
> {
> -	tcp_v6_send_response(sk, skb, seq, ack, win, tsval, tsecr, oif, key, 0,
> +	tcp_v6_send_response(sk, skb, seq, ack, win, tsval, tsecr, oif, 0,
> 			     tclass, label);
> }
>
> @@ -965,7 +966,7 @@ static void tcp_v6_timewait_ack(struct sock *sk, stru=
ct sk_buff *skb)
> 	tcp_v6_send_ack(sk, skb, tcptw->tw_snd_nxt, tcptw->tw_rcv_nxt,
> 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
> 			tcp_time_stamp_raw() + tcptw->tw_ts_offset,
> -			tcptw->tw_ts_recent, tw->tw_bound_dev_if, tcp_twsk_md5_key(tcptw),
> +			tcptw->tw_ts_recent, tw->tw_bound_dev_if,
> 			tw->tw_tclass, cpu_to_be32(tw->tw_flowlabel));
>
> 	inet_twsk_put(tw);
> @@ -988,7 +989,6 @@ static void tcp_v6_reqsk_send_ack(const struct sock *=
sk, struct sk_buff *skb,
> 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
> 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
> 			req->ts_recent, sk->sk_bound_dev_if,
> -			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->daddr),
> 			0, 0);
> }
>
> -- =

> 2.14.1
>
>

--
Mat Martineau
Intel OTC

--===============9196336872484465356==--
