Content-Type: multipart/mixed; boundary="===============2774056625290510129=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: avoid validating MP_CAPABLE keys on 3way
 HS handling
Date: Wed, 17 Jul 2019 11:05:43 +0200
Message-ID: <93774B8D-125C-4817-BDBE-CD8A86DEF7C9@apple.com>
In-Reply-To: b24b483a57666b5315ad574618ed114289ccbcc9.1563353875.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1504

--===============2774056625290510129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> On Jul 17, 2019, at 10:57 AM, Paolo Abeni <pabeni(a)redhat.com> wrote:
> =

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

without having easy access at the code right now:

How is the function token_join_valid() doing the validation? Because, the t=
hird ACK does not contain the token. Only the HMAC. So, upon reception of t=
he third ACK of a new subflow the server has to validate the HMAC. The issu=
e with a lost third ACK does not apply for new subflows because here MPTCP =
uses a 4-way handshake. The client won't send any data until it received th=
e fourth ACK from the server.



Patch looks good by the way!

Cheers,
Christoph

> ---
> net/mptcp/subflow.c | 10 ++--------
> 1 file changed, 2 insertions(+), 8 deletions(-)
> =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index fdc5aecab897..d91d817b8779 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -143,14 +143,8 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
> =

> 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->=
conn);
> =

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
> 		opt_rx.mptcp.mp_join =3D 0;
> 		mptcp_get_options(skb, &opt_rx);
> 		if (!opt_rx.mptcp.mp_join || token_join_valid(req, &opt_rx))
> -- =

> 2.20.1
> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============2774056625290510129==--
