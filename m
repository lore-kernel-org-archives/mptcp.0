Content-Type: multipart/mixed; boundary="===============2554585178569405532=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 07/25] tcp_md5: Detect key inside
 tcp_v4_send_ack instead of passing it as an argument
Date: Wed, 29 Nov 2017 09:54:01 -0800
Message-ID: <20171129175401.GP94116@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1711281736350.17380@ddombrow-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 214

--===============2554585178569405532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 28/11/17 - 17:39:59, Mat Martineau wrote:
> On Mon, 27 Nov 2017, Christoph Paasch wrote:
> =

> > This will simplify to consolidate the TCP_MD5-code into a single place.
> > =

> > Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> > ---
> > net/ipv4/tcp_ipv4.c | 18 ++++++++++++++----
> > 1 file changed, 14 insertions(+), 4 deletions(-)
> > =

> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index c6bc0c4d19c6..6f14004bd36d 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -736,7 +736,6 @@ static void tcp_v4_send_reset(const struct sock *sk=
, struct sk_buff *skb)
> > static void tcp_v4_send_ack(const struct sock *sk,
> > 			    struct sk_buff *skb, u32 seq, u32 ack,
> > 			    u32 win, u32 tsval, u32 tsecr, int oif,
> > -			    struct tcp_md5sig_key *key,
> > 			    int reply_flags, u8 tos)
> > {
> > 	const struct tcphdr *th =3D tcp_hdr(skb);
> > @@ -748,6 +747,9 @@ static void tcp_v4_send_ack(const struct sock *sk,
> > #endif
> > 			];
> > 	} rep;
> > +#ifdef CONFIG_TCP_MD5SIG
> > +	struct tcp_md5sig_key *key;
> > +#endif
> > 	struct net *net =3D sock_net(sk);
> > 	struct ip_reply_arg arg;
> > =

> > @@ -775,6 +777,17 @@ static void tcp_v4_send_ack(const struct sock *sk,
> > 	rep.th.window  =3D htons(win);
> > =

> > #ifdef CONFIG_TCP_MD5SIG
> > +	if (sk->sk_state =3D=3D TCP_TIME_WAIT) {
> > +		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
> > +
> > +		key =3D tcp_twsk_md5_key(tcptw);
> =

> Minor nit, could call tcp_twsk_md5_key(tcp_twsk(sk)). But this gets
> refactored away anyhow.

Done, use tcp_twsk(sk) directly.


Christoph

> =

> > +	} else if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
> > +		key =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&ip_hdr(skb)->da=
ddr,
> > +					AF_INET);
> > +	} else {
> > +		BUG();
> > +	}
> > +
> > 	if (key) {
> > 		int offset =3D (tsecr) ? 3 : 0;
> > =

> > @@ -820,7 +833,6 @@ static void tcp_v4_timewait_ack(struct sock *sk, st=
ruct sk_buff *skb)
> > 			tcp_time_stamp_raw() + tcptw->tw_ts_offset,
> > 			tcptw->tw_ts_recent,
> > 			tw->tw_bound_dev_if,
> > -			tcp_twsk_md5_key(tcptw),
> > 			tw->tw_transparent ? IP_REPLY_ARG_NOSRCCHECK : 0,
> > 			tw->tw_tos
> > 			);
> > @@ -848,8 +860,6 @@ static void tcp_v4_reqsk_send_ack(const struct sock=
 *sk, struct sk_buff *skb,
> > 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
> > 			req->ts_recent,
> > 			0,
> > -			tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&ip_hdr(skb)->daddr,
> > -					  AF_INET),
> > 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
> > 			ip_hdr(skb)->tos);
> > }
> > -- =

> > 2.15.0
> > =

> > =

> =

> --
> Mat Martineau
> Intel OTC

--===============2554585178569405532==--
