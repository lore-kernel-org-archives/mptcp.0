Content-Type: multipart/mixed; boundary="===============4802116227351373289=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH mptcp-backport] mptcp: fix DATA_FIN generation
 on early shutdown
Date: Fri, 12 Mar 2021 10:45:43 +0100
Message-ID: <a37ad7f3c2364eceedb3581a8c6e027ed2d47362.camel@redhat.com>
In-Reply-To: 20210312012146.108482-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8112

--===============4802116227351373289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-03-11 at 17:21 -0800, Mat Martineau wrote:
> From: Paolo Abeni <pabeni(a)redhat.com>
> =

> If the msk is closed before sending or receiving any data,
> no DATA_FIN is generated, instead an MPC ack packet is
> crafted out.
> =

> In the above scenario, the MPTCP protocol creates and sends a
> pure ack and such packets matches also the criteria for an
> MPC ack and the protocol tries first to insert MPC options,
> leading to the described error.
> =

> This change addresses the issue by avoiding the insertion of an
> MPC option for DATA_FIN packets or if the sub-flow is not
> established.
> =

> To avoid doing multiple times the same test, fetch the data_fin
> flag in a bool variable and pass it to both the interested
> helpers.
> =

> Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data pac=
kets")
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> =

> This is a backport of d87903b63e3ce1eafaa701aec5cc1d0ecd0d84dc to the
> v5.10-stable tree. Paolo and I got email from Greg KH saying the commit
> did not apply cleanly on v5.10.
> =

> The main reason for that was a call to mptcp_data_fin_enabled(), which
> was added as part of "mptcp: refactor shutdown and close":
> =

> static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
> {
>        return READ_ONCE(msk->snd_data_fin_enable) &&
>               READ_ONCE(msk->write_seq) =3D=3D READ_ONCE(msk->snd_nxt);
> }
> =

> That code depends on the introduction of msk->snd_nxt in the same patch
> series for v5.11. In this backport I just used
> READ_ONCE(msk->snd_data_fin_enable).
> =

> This only changes v5.10 behavior before sending any data, so it *seems*
> like this approach to the backport is workable. The self tests are
> successful but don't have coverage for this fix.
> =

> What do you think Paolo?

The patch LGTM, except for a very minor thing see below).

The relevat scenario should be covered by the following pktdrill tests,
in our repo:

gtests/net/mptcp/syscalls/connect_close.pkt
gtests/net/mptcp/syscalls/connect_close_ack_ooo.pkt

[...]
> @@ -664,10 +668,11 @@ bool mptcp_established_options(struct sock *sk, str=
uct sk_buff *skb,
>  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
>  		return false;
>  =

> -	if (mptcp_established_options_mp(sk, skb, &opt_size, remaining, opts))
> +	snd_data_fin =3D READ_ONCE(msk->snd_data_fin_enable);

This introduces an additional empty line WRT to original patch. Could
be removed just to be more similar to the original code, but it's not
much relevant anyway.

It would be great if you could give a spin to the patched kernel with
the above mentioned pktdrill tests case.

Cheers,

Paolo

--===============4802116227351373289==--
