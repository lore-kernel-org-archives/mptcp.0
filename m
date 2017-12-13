Content-Type: multipart/mixed; boundary="===============2770737653484641338=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v3 04/15] tcp: Allow tcp_fast_parse_options to drop
 segments
Date: Tue, 12 Dec 2017 16:28:31 -0800
Message-ID: <alpine.OSX.2.21.1712121601490.15459@sjweber-mobl.amr.corp.intel.com>
In-Reply-To: 20171211214218.35868-5-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 254

--===============2770737653484641338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 11 Dec 2017, Christoph Paasch wrote:

> The TCP extra-options parser might decide to drop the segment based on
> the present option. Especially, for TCP_MD5, we want to do this as soon
> as possible (thus, right after the parsing).
>
> This patch allows to do this by splitting out tcp_fast_parse_options() in
> tcp_validate_incoming().
>
> Originally, tcp_fast_parse_options() returned false, when there is no
> timestamp option (except in the case of the slow-path processing through
> tcp_parse_options() where it always returns true.

Minor nitpick: unmatched paren above.

>
> So, the return-value of tcp_fast_parse_options() was kind of
> inconsistent. With this patch, we make it return true when the segment
> should get dropped based on the parsed options, and false otherwise.
>
> In tcp_validate_incoming, we will then just check for
> tp->rx_opt.saw_tstamp to see if we should verify PAWS.
>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
>
> Notes:
>    v3: * Improved commit-message
>
> net/ipv4/tcp_input.c | 16 +++++++++++-----
> 1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 9550cc42de2d..cba194a0222f 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3832,6 +3832,8 @@ static bool tcp_parse_aligned_timestamp(struct tcp_=
sock *tp, const struct tcphdr
>
> /* Fast parse options. This hopes to only see timestamps.
>  * If it is wrong it falls back on tcp_parse_options().
> + *
> + * Returns true if we should drop this packet based on present TCP-optio=
ns.
>  */
> static bool tcp_fast_parse_options(const struct net *net,
> 				   const struct sk_buff *skb,
> @@ -3842,18 +3844,20 @@ static bool tcp_fast_parse_options(const struct n=
et *net,
> 	 */
> 	if (th->doff =3D=3D (sizeof(*th) / 4)) {
> 		tp->rx_opt.saw_tstamp =3D 0;
> -		return false;
> +		goto extra_opt_check;
> 	} else if (tp->rx_opt.tstamp_ok &&
> 		   th->doff =3D=3D ((sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4)) {
> 		if (tcp_parse_aligned_timestamp(tp, th))
> -			return true;
> +			goto extra_opt_check;
> 	}
>
> 	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
> 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
> 		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
>
> -	return true;
> +extra_opt_check:
> +	/* ToDo - will be added here */
> +	return false;

I'm not sure the "ToDo" will be liked - it would be more of a standalone =

change to wait until the option registration patch to add the gotos. The =

main consideration is that git bisect works fine either way, so it's not a =

big deal to leave this as-is and see if anyone objects.

Mat


> }
>
> #ifdef CONFIG_TCP_MD5SIG
> @@ -5173,9 +5177,11 @@ static bool tcp_validate_incoming(struct sock *sk,=
 struct sk_buff *skb,
> 	struct tcp_sock *tp =3D tcp_sk(sk);
> 	bool rst_seq_match =3D false;
>
> +	if (tcp_fast_parse_options(sock_net(sk), skb, th, tp))
> +		goto discard;
> +
> 	/* RFC1323: H1. Apply PAWS check first. */
> -	if (tcp_fast_parse_options(sock_net(sk), skb, th, tp) &&
> -	    tp->rx_opt.saw_tstamp &&
> +	if (tp->rx_opt.saw_tstamp &&
> 	    tcp_paws_discard(sk, skb)) {
> 		if (!th->rst) {
> 			NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
> -- =

> 2.15.0
>
>

--
Mat Martineau
Intel OTC

--===============2770737653484641338==--
