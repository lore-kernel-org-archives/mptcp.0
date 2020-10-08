Content-Type: multipart/mixed; boundary="===============1637167694021620810=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 2/2] mptcp: subflows garbage collection
Date: Thu, 08 Oct 2020 14:28:56 -0700
Message-ID: <alpine.OSX.2.23.453.2010081359500.49214@ozore-mobl2.amr.corp.intel.com>
In-Reply-To: 885dd6801461324b1a9753625150cf5e55f22852.1602189151.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6258

--===============1637167694021620810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Oct 2020, Paolo Abeni wrote:

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
> net/mptcp/subflow.c  |  6 ++++++
> 3 files changed, 25 insertions(+)
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
> 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
> 		mptcp_check_for_eof(msk);

Still this extra whitespace, but looks good other than that:

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>


I applied both (resolving conflict on patch 1) to net/master and the self =

tests look ok on my system. diag.sh has some failures, but those are the =

same with or without these patches.

--
Mat Martineau
Intel
--===============1637167694021620810==--
