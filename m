Content-Type: multipart/mixed; boundary="===============2828077663261159083=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: avoid validating MP_CAPABLE keys on 3way
 HS handling
Date: Wed, 17 Jul 2019 10:22:24 -0700
Message-ID: <ecca172a2bb504903508130b725637838b06a202.camel@linux.intel.com>
In-Reply-To: 93774B8D-125C-4817-BDBE-CD8A86DEF7C9@apple.com
X-Status: 
X-Keywords:                  
X-UID: 1507

--===============2828077663261159083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-17 at 11:05 +0200, Christoph Paasch wrote:
> > On Jul 17, 2019, at 10:57 AM, Paolo Abeni <pabeni(a)redhat.com> wrote:
> > =

> > The server side already stored the key on syn, and 3way HS ack
> > reception is fragile: the ack can be lost, and the following
> > data pkts processed instead.
> > =

> > This fixes the pending self-test issue in my testbed.
> > =

> > Suggested-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> > Suggested-by: Christoph Paasch <cpaasch(a)apple.com>
> > Fixes: af550dd282ca ("mptcp: Create SUBFLOW socket for incoming connect=
ions")
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > --
> > I'm ok with squashing into the Fixes commit, but that will likely cause
> > conflicts.
> > =

> > We can possible have [in the future] a similar issue with MP_JOIN, as we
> > validate the token on 3way HS ack reception, and that is fragile ??!
> =

> without having easy access at the code right now:
> =

> How is the function token_join_valid() doing the validation? Because, the=
 third ACK does not contain the token. Only the HMAC. So, upon reception of=
 the third ACK of a new subflow the server has to validate the HMAC. The is=
sue with a lost third ACK does not apply for new subflows because here MPTC=
P uses a 4-way handshake. The client won't send any data until it received =
the fourth ACK from the server.
> =


token_join_valid() uses the token received in the SYN (and saved in the
request sock) to look up the MPTCP connection sock, where the keys from the
original connection are saved. HMAC is calculated from keys, the nonce sent=
 in
the SYN-ACK, and the nonce received in the SYN. But we may still have the s=
ame
problem that options are not sent on re-transmission of a lost third ACK.

Peter.

> =

> Patch looks good by the way!
> =

> Cheers,
> Christoph
> =

> > ---
> > net/mptcp/subflow.c | 10 ++--------
> > 1 file changed, 2 insertions(+), 8 deletions(-)
> > =

> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index fdc5aecab897..d91d817b8779 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -143,14 +143,8 @@ static struct sock *subflow_syn_recv_sock(const st=
ruct sock *sk,
> > =

> > 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener=
->conn);
> > =

> > -	if (subflow_req->mp_capable) {
> > -		opt_rx.mptcp.mp_capable =3D 0;
> > -		mptcp_get_options(skb, &opt_rx);
> > -		if (!opt_rx.mptcp.mp_capable ||
> > -		    subflow_req->local_key !=3D opt_rx.mptcp.rcvr_key ||
> > -		    subflow_req->remote_key !=3D opt_rx.mptcp.sndr_key)
> > -			return NULL;
> > -	} else if (subflow_req->mp_join) {
> > +	/* if the sk is MP_CAPABLE, we already received the client key */
> > +	if (!subflow_req->mp_capable && subflow_req->mp_join) {
> > 		opt_rx.mptcp.mp_join =3D 0;
> > 		mptcp_get_options(skb, &opt_rx);
> > 		if (!opt_rx.mptcp.mp_join || token_join_valid(req, &opt_rx))
> > -- =

> > 2.20.1
> > =

> > _______________________________________________
> > mptcp mailing list
> > mptcp(a)lists.01.org
> > https://lists.01.org/mailman/listinfo/mptcp
> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============2828077663261159083==--
