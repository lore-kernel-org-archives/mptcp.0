Content-Type: multipart/mixed; boundary="===============1355096744523985160=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v3 03/15] tcp: Pass sock and skb to tcp_options_write
Date: Tue, 12 Dec 2017 16:00:16 -0800
Message-ID: <alpine.OSX.2.21.1712121546010.15459@sjweber-mobl.amr.corp.intel.com>
In-Reply-To: 20171211214218.35868-4-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 249

--===============1355096744523985160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 11 Dec 2017, Christoph Paasch wrote:

> Because, to write the extra-options, we need the request-socket to parse =
the
> list of extra-options to be written to the TCP-header.
> The skb is also needed so that extra-options like TCP_MD5SIG can compute
> the hash properly.

Without reading ahead in the patch set, people won't know what =

"extra-options" are. A little more context would help:

"""

An upcoming patch adds a configurable, per-socket list of TCP options to =

populate in the TCP header. This requires tcp_options_write() to know the =

socket (to use the options list) and the skb (to provide visibility to the =

packet data for options like TCP_MD5SIG).

"""


Mat


>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
>
> Notes:
>    v3: * Merged with next commit to make it to reduce the number of commi=
ts.
>
> net/ipv4/tcp_output.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index e0335be600d3..751396f22bb3 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -444,10 +444,14 @@ struct tcp_out_options {
>  * At least SACK_PERM as the first option is known to lead to a disaster
>  * (but it may well be that other scenarios fail similarly).
>  */
> -static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
> +static void tcp_options_write(__be32 *ptr, struct sk_buff *skb, struct s=
ock *sk,
> 			      struct tcp_out_options *opts)
> {
> 	u16 options =3D opts->options;	/* mungable copy */
> +	struct tcp_sock *tp =3D NULL;
> +
> +	if (sk_fullsock(sk))
> +		tp =3D tcp_sk(sk);
>
> 	if (unlikely(OPTION_MD5 & options)) {
> 		*ptr++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
> @@ -1136,7 +1140,7 @@ static int tcp_transmit_skb(struct sock *sk, struct=
 sk_buff *skb, int clone_it,
> 		 */
> 		th->window	=3D htons(min(tp->rcv_wnd, 65535U));
> 	}
> -	tcp_options_write((__be32 *)(th + 1), tp, &opts);
> +	tcp_options_write((__be32 *)(th + 1), skb, sk, &opts);
> #ifdef CONFIG_TCP_MD5SIG
> 	/* Calculate the MD5 hash, as we have all we need now */
> 	if (md5) {
> @@ -3246,7 +3250,7 @@ struct sk_buff *tcp_make_synack(const struct sock *=
sk, struct dst_entry *dst,
> 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
> 	th->window =3D htons(min(req->rsk_rcv_wnd, 65535U));
> 	th->doff =3D (tcp_header_size >> 2);
> -	tcp_options_write((__be32 *)(th + 1), NULL, &opts);
> +	tcp_options_write((__be32 *)(th + 1), skb, req_to_sk(req), &opts);
> 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
>
> #ifdef CONFIG_TCP_MD5SIG
> -- =

> 2.15.0
>
>

--
Mat Martineau
Intel OTC

--===============1355096744523985160==--
