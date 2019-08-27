Content-Type: multipart/mixed; boundary="===============5430588655616849943=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: fall back to tcp when dss checksum are
 requested
Date: Tue, 27 Aug 2019 09:49:22 -0700
Message-ID: <20190827164922.GY5994@MacBook-Pro-64.local>
In-Reply-To: 20190827105334.GY20113@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1713

--===============5430588655616849943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 27/08/19 - 12:53:34, Florian Westphal wrote:
> Florian Westphal <fw(a)strlen.de> wrote:
> > Peter Krystad <peter.krystad(a)linux.intel.com> wrote:
> > > =

> > > Hi Florian -
> > > =

> > > My thinking here was that code in mptcp_parse_options() just parses t=
he
> > > options without having knowledge about configuration. There is existi=
ng logic
> > > for peer requesting checksums in subflow_v4_init_req().

I don't think it is bad to have these decisions made in
mptcp_parse_options(). E.g., tcp_parse_options() also makes decisions based
on the system's config (see the checks for the TCP-timestamp sysctl and
others).

Passing around these things across the stack makes the design more complex
IMO.


Cheers,
Christoph

> > =

> > Uh, I don't understand this then.  Can you fix this?
> > =

> > mptcp-next can't talk to mptcp kernel unless one disables checksums on
> > the mptcp kernel.
> > =

> > mptcp (out of tree) excepts checksums in default settings and will reset
> > the connection quickly.  I don't see how to fallback to tcp in that case
> > except with the patch I sent (not setting mp capable).
> =

> I hacked this thing together but I can't say I like it, but I found no
> other solution to transport the needed information (csum requested)
> to the spots that need to withdraw the mp_capable=3D1 decision.
> =

>  net/mptcp/options.c |  3 +++
>  net/mptcp/subflow.c | 21 +++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 9f892478d336..2bfba0cee72c 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -320,6 +320,9 @@ void mptcp_rcv_synsent(struct sock *sk)
>  	struct subflow_context *subflow =3D subflow_ctx(sk);
>  =

>  	if (subflow->request_mptcp && tp->rx_opt.mptcp.mp_capable) {
> +		if (tp->rx_opt.mptcp.flags & MPTCP_CAP_CHECKSUM_REQD)
> +			subflow->use_checksum =3D 1;
> +
>  		subflow->mp_capable =3D 1;
>  		subflow->remote_key =3D tp->rx_opt.mptcp.sndr_key;
>  		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index c9dcb601dce3..ec1e1ada657b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -74,6 +74,22 @@ static void subflow_v4_init_req(struct request_sock *r=
eq,
>  	subflow_req->mp_capable =3D 0;
>  	subflow_req->mp_join =3D 0;
>  =

> +	/* RFC 6824, Section 3.1:
> +	 * "For the Checksum Required bit (labeled "A"), if either
> +	 * host requires the use of checksums, checksums MUST be used.
> +	 * In other words, the only way for checksums not to be used
> +	 * is if both hosts in their SYNs set A=3D0."
> +	 *
> +	 * Section 3.3.0:
> +	 * "If a checksum is not present when its use has been
> +	 * negotiated, the receiver MUST close the subflow with a RST as it is
> +	 * considered broken."
> +	 *
> +	 * We don't implement DSS checksum - fall back to TCP.
> +	 */
> +	if (rx_opt.mptcp.flags & MPTCP_CAP_CHECKSUM_REQD)
> +		return;
> +
>  	if (rx_opt.mptcp.mp_capable && rx_opt.mptcp.mp_join)
>  		return;
>  =

> @@ -148,6 +164,11 @@ static void subflow_finish_connect(struct sock *sk, =
const struct sk_buff *skb)
>  	if (subflow->mp_capable && !subflow->conn_finished) {
>  		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow_ctx(sk),
>  			 subflow->remote_key);
> +
> +		/* We don't support DSS checksums, no choice but to disable mptcp */
> +		if (subflow->use_checksum)
> +			subflow->mp_capable =3D 0;
> +
>  		mptcp_finish_connect(subflow->conn, subflow->mp_capable);
>  		subflow->conn_finished =3D 1;
>  =

> -- =

> 2.21.0
> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============5430588655616849943==--
