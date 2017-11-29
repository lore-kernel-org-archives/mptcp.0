Content-Type: multipart/mixed; boundary="===============4933041139436068722=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 04/25] tcp: Allow tcp_fast_parse_options to
 drop segments
Date: Wed, 29 Nov 2017 09:27:25 -0800
Message-ID: <20171129172725.GM94116@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1711281716080.17380@ddombrow-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 212

--===============4933041139436068722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 28/11/17 - 17:26:14, Mat Martineau wrote:
> On Mon, 27 Nov 2017, Christoph Paasch wrote:
> =

> > The TCP extra-options parser might decide to drop the segment based on
> > the present option. Especially, for TCP_MD5, we want to do this as soon
> > as possible (thus, right after the parsing).
> > =

> > This patch allows to do this by splitting out tcp_fast_parse_options() =
in
> > tcp_validate_incoming()
> =

> I suggest some additional explanation of how the return value of
> tcp_parse_fast_options() has changed meaning. The change to the control f=
low
> in tcp_validate_incoming() doesn't have quite enough context in the email=
 to
> see what's going on.

I made it:


tcp: Allow tcp_fast_parse_options to drop segments

The TCP extra-options parser might decide to drop the segment based on
the present option. Especially, for TCP_MD5, we want to do this as soon
as possible (thus, right after the parsing).

This patch allows to do this by splitting out tcp_fast_parse_options() in
tcp_validate_incoming().

Originally, tcp_fast_parse_options() returned false, when there is no
timestamp option (except in the case of the slow-path processing through
tcp_parse_options() where it always returns true.

So, the return-value of tcp_fast_parse_options() was kind of
inconsistent. With this patch, we make it return true when the segment
should get dropped based on the parsed options, and false otherwise.

In tcp_validate_incoming, we will then just check for
tp->rx_opt.saw_tstamp to see if we should verify PAWS.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>



Christoph


> =

> > =

> > Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> > ---
> > net/ipv4/tcp_input.c | 16 +++++++++++-----
> > 1 file changed, 11 insertions(+), 5 deletions(-)
> > =

> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 734cfc8ff76e..a97f54005452 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -3824,6 +3824,8 @@ static bool tcp_parse_aligned_timestamp(struct tc=
p_sock *tp, const struct tcphdr
> > =

> > /* Fast parse options. This hopes to only see timestamps.
> >  * If it is wrong it falls back on tcp_parse_options().
> > + *
> > + * Returns true if we should drop this packet based on present TCP-opt=
ions.
> >  */
> > static bool tcp_fast_parse_options(const struct net *net,
> > 				   const struct sk_buff *skb,
> > @@ -3834,18 +3836,20 @@ static bool tcp_fast_parse_options(const struct=
 net *net,
> > 	 */
> > 	if (th->doff =3D=3D (sizeof(*th) / 4)) {
> > 		tp->rx_opt.saw_tstamp =3D 0;
> > -		return false;
> > +		goto extra_opt_check;
> > 	} else if (tp->rx_opt.tstamp_ok &&
> > 		   th->doff =3D=3D ((sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4)) {
> > 		if (tcp_parse_aligned_timestamp(tp, th))
> > -			return true;
> > +			goto extra_opt_check;
> > 	}
> > =

> > 	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
> > 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
> > 		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
> > =

> > -	return true;
> > +extra_opt_check:
> > +	/* ToDo - will be added here */
> > +	return false;
> > }
> > =

> > #ifdef CONFIG_TCP_MD5SIG
> > @@ -5165,9 +5169,11 @@ static bool tcp_validate_incoming(struct sock *s=
k, struct sk_buff *skb,
> > 	struct tcp_sock *tp =3D tcp_sk(sk);
> > 	bool rst_seq_match =3D false;
> > =

> > +	if (tcp_fast_parse_options(sock_net(sk), skb, th, tp))
> > +		goto discard;
> > +
> > 	/* RFC1323: H1. Apply PAWS check first. */
> > -	if (tcp_fast_parse_options(sock_net(sk), skb, th, tp) &&
> > -	    tp->rx_opt.saw_tstamp &&
> > +	if (tp->rx_opt.saw_tstamp &&
> > 	    tcp_paws_discard(sk, skb)) {
> > 		if (!th->rst) {
> > 			NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
> > -- =

> > 2.15.0
> > =

> > =

> =

> --
> Mat Martineau
> Intel OTC

--===============4933041139436068722==--
