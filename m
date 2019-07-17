Content-Type: multipart/mixed; boundary="===============7737969187501663149=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: avoid validating MP_CAPABLE keys on 3way
 HS handling
Date: Wed, 17 Jul 2019 10:22:33 -0700
Message-ID: <7d182ff726cb95e049fd92e3d45eff23d89ed150.camel@linux.intel.com>
In-Reply-To: b24b483a57666b5315ad574618ed114289ccbcc9.1563353875.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1508

--===============7737969187501663149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Looks good to me.

On Wed, 2019-07-17 at 10:57 +0200, Paolo Abeni wrote:
> The server side already stored the key on syn, and 3way HS ack
> reception is fragile: the ack can be lost, and the following
> data pkts processed instead.
> =

> This fixes the pending self-test issue in my testbed.
> =

> Suggested-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> Suggested-by: Christoph Paasch <cpaasch(a)apple.com>
> Fixes: af550dd282ca ("mptcp: Create SUBFLOW socket for incoming connectio=
ns")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> --
> I'm ok with squashing into the Fixes commit, but that will likely cause
> conflicts.
> =

> We can possible have [in the future] a similar issue with MP_JOIN, as we
> validate the token on 3way HS ack reception, and that is fragile ??!
> ---
>  net/mptcp/subflow.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index fdc5aecab897..d91d817b8779 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -143,14 +143,8 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
>  =

>  	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener-=
>conn);
>  =

> -	if (subflow_req->mp_capable) {
> -		opt_rx.mptcp.mp_capable =3D 0;
> -		mptcp_get_options(skb, &opt_rx);
> -		if (!opt_rx.mptcp.mp_capable ||
> -		    subflow_req->local_key !=3D opt_rx.mptcp.rcvr_key ||
> -		    subflow_req->remote_key !=3D opt_rx.mptcp.sndr_key)
> -			return NULL;
> -	} else if (subflow_req->mp_join) {
> +	/* if the sk is MP_CAPABLE, we already received the client key */
> +	if (!subflow_req->mp_capable && subflow_req->mp_join) {
>  		opt_rx.mptcp.mp_join =3D 0;
>  		mptcp_get_options(skb, &opt_rx);
>  		if (!opt_rx.mptcp.mp_join || token_join_valid(req, &opt_rx))


--===============7737969187501663149==--
