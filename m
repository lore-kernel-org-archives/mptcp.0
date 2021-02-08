Content-Type: multipart/mixed; boundary="===============9208813642057525103=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 1/3] mptcp: schedule worker when subflow is
 closed
Date: Tue, 09 Feb 2021 00:33:50 +0100
Message-ID: <c0d75ae27fc7f93e57d470458df9e5c043e75a9a.camel@redhat.com>
In-Reply-To: 20210202174754.6861-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7689

--===============9208813642057525103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, 2021-02-02 at 18:47 +0100, Florian Westphal wrote:
> When remote side closes a subflow we should schedule the worker to
> dispose of the subflow in a timely manner.
> =

> Otherwise, SF_CLOSED event won't be generated until the mptcp
> socket itself is closing or local side is closing another subflow.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/subflow.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index b8b670cb6116..57f6361eb07c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1413,6 +1413,13 @@ static void subflow_state_change(struct sock *sk)
>  	if (mptcp_subflow_data_available(sk))
>  		mptcp_data_ready(parent, sk);
>  =

> +	if (sk->sk_state =3D=3D TCP_CLOSE &&
> +	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(parent)->flag=
s)) {
> +		sock_hold(parent);
> +		if (!schedule_work(&mptcp_sk(parent)->work))
> +			sock_put(parent);
> +	}
> +

Looks like this is causing issue/154. Reverting this patch the issues
goes away here. @Matttbe: could you please double check that?

In case of fallback, the subflow can be closed by the peer while there
are data pending in the subflow receive queue. Calling
mptcp_close_subflow() will discard such data and will corrupt the
stream.

I think that scenario is possible even with full msk, if the peer
closes a single subflow while the msk is still alive (before DATA_FIN).

A possible fix could be additionally checking for empty ssk-
>sk_recevive_queue, plush adding a similar chunk
in __mptcp_move_skbs_from_subflow(). =


That means that subflow_close even could be delayed by user-space, if
the latter does not spool the pending ingress data.

Or the NL event generation cold be de-coupled from the actual subflow
close() but I fear some side effect even there.

Note that calling __mptcp_move_skbs_from_subflow()
from mptcp_close_subflow() will not solve the issue, as the msk receive
queue could be full - I think;)

Side note: it would be nice using the deferred actions to do the
netlink call, to avoid the workqueue usage. AFAICS this is one of the
few workqueue usage that can be triggered on a server by any client
regardless of the server configuration (the others being
DATA_FIN/DATA_FIN-ack processing).

Cheers,

Paolo

--===============9208813642057525103==--
