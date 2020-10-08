Content-Type: multipart/mixed; boundary="===============5858396651143185046=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 2/2] mptcp: subflows garbage collection
Date: Wed, 07 Oct 2020 17:22:24 -0700
Message-ID: <alpine.OSX.2.23.453.2010071717070.42191@ytakamor-mobl2.gar.corp.intel.com>
In-Reply-To: d63dc99e177c7a5a73a04edc9aa96c78a076ae01.1602091906.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6245

--===============5858396651143185046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Paolo,

On Wed, 7 Oct 2020, Paolo Abeni wrote:

> The msk can close MP_JOIN subflows if the initial handshake
> fails. Currently such subflows are kept alive in the
> conn_list untill the msk itself is closed.
>
> Beyond the wasted memory, we could end-up sending the
> DATA_FIN and the DATA_FIN ack on such socket, even after a
> reset.
>
> Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machin=
e")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 18 ++++++++++++++++++
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  |  5 +++++
> 3 files changed, 24 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 82b324ed3c4c..92e0152f831b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1701,6 +1701,20 @@ static void pm_work(struct mptcp_sock *msk)
> 	spin_unlock_bh(&msk->pm.lock);
> }
>
> +static void __mptcp_close_subflow(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +
> +	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +		if (inet_sk_state_load(ssk) !=3D TCP_CLOSE)
> +			continue;
> +
> +		__mptcp_close_ssk((struct sock *)msk, ssk, subflow, 0);
> +	}
> +}
> +
> static void mptcp_worker(struct work_struct *work)
> {
> 	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
> @@ -1718,11 +1732,15 @@ static void mptcp_worker(struct work_struct *work)
> 	mptcp_clean_una(sk);
> 	mptcp_check_data_fin_ack(sk);
> 	__mptcp_flush_join_list(msk);
> +	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
> +		__mptcp_close_subflow(msk);
> +
> 	__mptcp_move_skbs(msk);
>
> 	if (msk->pm.status)
> 		pm_work(msk);
>
> +

Some whitespace noise here.

> 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
> 		mptcp_check_for_eof(msk);
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index de5219fd3570..3462c00afd9e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -90,6 +90,7 @@
> #define MPTCP_WORK_RTX		2
> #define MPTCP_WORK_EOF		3
> #define MPTCP_FALLBACK_DONE	4
> +#define MPTCP_WORK_CLOSE_SUBFLOW 5
>
> struct mptcp_options_received {
> 	u64	sndr_key;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d2eb5f2abe5a..5ff806dc4b83 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -273,9 +273,14 @@ static bool subflow_thmac_valid(struct mptcp_subflow=
_context *subflow)
>
> void mptcp_subflow_reset(struct sock *ssk)
> {
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	struct sock *sk =3D subflow->conn;
> +
> 	tcp_set_state(ssk, TCP_CLOSE);
> 	tcp_send_active_reset(ssk, GFP_ATOMIC);
> 	tcp_done(ssk);
> +	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
> +		mptcp_schedule_work(sk);

There's a build problem here, mptcp_schedule() is introduced later in the =

export branch and isn't on -net or net-next.

Otherwise, the series looks good.

--
Mat Martineau
Intel
--===============5858396651143185046==--
