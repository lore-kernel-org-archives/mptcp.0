Content-Type: multipart/mixed; boundary="===============4002056574031013151=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 3/5] tcp: init MPTCP option before parsing.
Date: Mon, 27 Apr 2020 19:43:02 +0200
Message-ID: <1601536ea355dda6d6c7f62144723f00b151bf0c.camel@redhat.com>
In-Reply-To: 606694a5d5c7a74aa90f2bf6f8275933a17b626d.1587738345.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4254

--===============4002056574031013151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-04-24 at 19:14 +0200, Paolo Abeni wrote:
> The sub_options field carries per packet information,
> The MPTCP option parsing will set the relevant bits according
> to the ingress option.
> =

> Currently the sub_option field is cleared only on option
> reset, so that a sub_option set by e.g. a packet later dropped
> due to seq checks, will remain visible on next good packet.
> =

> The above allows out-of-windows packets to corrupt the mptcp
> stream.
> =

> Fix the above clearing the sub_options field before options
> parsing.
> =

> Additionally avoid explicitly clearing the add_addr sub-option
> after processing it - no more needed, as it's now always
> cleared before parsing.
> =

> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  include/linux/tcp.h  | 1 -
>  net/ipv4/tcp_input.c | 1 +
>  net/mptcp/options.c  | 1 -
>  3 files changed, 1 insertion(+), 2 deletions(-)
> =

> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index b2b34db4f424..bc16bb3bcbd1 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -152,7 +152,6 @@ static inline void tcp_clear_options(struct tcp_optio=
ns_received *rx_opt)
>  #if IS_ENABLED(CONFIG_SMC)
>  	rx_opt->smc_ok =3D 0;
>  #endif
> -	mptcp_init_options(rx_opt);
>  }
>  =

>  /* This is the max number of SACKS that we'll generate and process. It's=
 safe
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index bf4ced9273e8..738a0db29f77 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3848,6 +3848,7 @@ void tcp_parse_options(const struct net *net,
>  =

>  	ptr =3D (const unsigned char *)(th + 1);
>  	opt_rx->saw_tstamp =3D 0;
> +	mptcp_init_options(opt_rx);
>  =

>  	while (length > 0) {
>  		int opcode =3D *ptr++;

I just noticed the above is not enough: we will get stray mptcp option
values when hitting the tcp_fast_parse_options() code path (no opt in
the rx packet, or only tstamp).

Usually the export branch always set mptcp option, so we do not hit
tcp_fast_parse_options(), but due to another bug - still quite obscure
- the sender does that on some race.

More importantly, a generic MPTCP endpoint may chose to omit the DSS in
some packets.

A possible fix would be adding more mptcp_init_options() in
tcp_fast_parse_options(), but that starts looking very wrong... =


As an alternative, I was looking at booking an 'unused' bit in
tcp_skb_cb() but even that will need explicit initialization.

Another option would be calling skb_ext_add() in mptcp_parse_option(), =

clear the mptcp option only when the extension is added and using
mptcp_get_ext() in mptcp_incoming_options() to validate the
mptcp_options_received sub options flags.

The last one is probably the more robust alternative, but has the
downside to force ext allocation on syn packet (we currently don't do
that) and possibly try multiple allocation on memory pressure - if
skb_ext_add() fails at option parsing time and the ingress packet has
multiple mptcp options.

Any better option?

Thanks,

Paolo

--===============4002056574031013151==--
