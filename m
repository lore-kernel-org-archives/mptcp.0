Content-Type: multipart/mixed; boundary="===============2531220755008107777=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 08/12] mptcp: Use full MPTCP-level
 disconnect state machine
Date: Wed, 15 Jul 2020 17:40:00 -0700
Message-ID: <alpine.OSX.2.23.453.2007151723050.40462@mjmartin-mac01.local>
In-Reply-To: 20200716002036.705306-9-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5037

--===============2531220755008107777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jul 2020, Mat Martineau wrote:

> RFC 8684 appendix D describes the connection state machine for
> MPTCP. This patch implements the DATA_FIN / DATA_ACK exchanges and
> MPTCP-level socket state changes described in that appendix, rather than
> simply sending DATA_FIN along with TCP FIN when disconnecting subflows.
>
> DATA_FIN is now sent and acknowledged before shutting down the
> subflows. Received DATA_FIN information (if not part of a data packet)
> is written to the MPTCP socket when the incoming DSS option is parsed by
> the subflow, and the MPTCP worker is scheduled to process the
> flag. DATA_FIN received as part of a full DSS mapping will be handled
> when the mapping is processed.
>
> The DATA_FIN is acknowledged by the worker if the reader is caught
> up. If there is still data to be moved to the MPTCP-level queue, ack_seq
> will be incremented to account for the DATA_FIN when it reaches the end
> of the stream and a DATA_ACK will be sent to the peer.
>
> In this RFC patch, DATA_FIN is sent when calling shutdown(fd, SHUT_WR)
> on the MPTCP socket. mptcp_close() has not yet been updated to wait for
> the peer to DATA_ACK before forcing all the subflows to be closed and
> cleaned up. The handshake is working with both peers using test programs
> with shutdown() and delays, but is not yet working consistently with the
> self tests. It also doesn't currently detect if fallback has happened,
> so there are extra acks sent on fallback connections.
>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
> net/mptcp/options.c  | 11 ++++++
> net/mptcp/protocol.c | 83 +++++++++++++++++++++++++++++++++++---------
> net/mptcp/subflow.c  | 11 ++++--
> 3 files changed, 86 insertions(+), 19 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4e2378369691..72d41c239acf 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -864,6 +864,17 @@ void mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb,
> 	if (mp_opt.use_ack)
> 		update_una(msk, &mp_opt);
>
> +	/* Zero-length packets, like bare ACKs carrying a DATA_FIN, are
> +	 * dropped by the caller and not propagated to the MPTCP layer.
> +	 * Copy the DATA_FIN information now.
> +	 */
> +	if (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq) {
> +		if (mp_opt.data_fin && mp_opt.data_len =3D=3D 1 &&
> +		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq) &&
> +		    schedule_work(&msk->work))
> +			sock_hold(subflow->conn);
> +	}
> +
> 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
> 	if (!mpext)
> 		return;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9eef1fbe300b..d19e7ba5163c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -299,6 +299,12 @@ static void mptcp_check_data_fin(struct sock *sk)
> 	}
> }
>
> +static void mptcp_schedule_work(struct sock *sk)
> +{
> +	if (schedule_work(&mptcp_sk(sk)->work))
> +		sock_hold(sk);
> +}
> +
> static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> 					   struct sock *ssk,
> 					   unsigned int *bytes)
> @@ -356,6 +362,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
> 			seq +=3D len;
> 			moved +=3D len;
>
> +			if (mptcp_pending_data_fin(sk))
> +				mptcp_schedule_work(sk);
> +

I noticed after sending that this check is redundant with the hunk of code =

below. Only the one check at the end of the function is needed.

> 			if (WARN_ON_ONCE(map_remaining < len))
> 				break;
> 		} else {
> @@ -375,6 +384,16 @@ static bool __mptcp_move_skbs_from_subflow(struct mp=
tcp_sock *msk,
>
> 	*bytes =3D moved;
>
> +	/* If the moves have caught up with the DATA_FIN sequence number
> +	 * it's time to ack the DATA_FIN and change socket state, but
> +	 * this is not a good place to change state. Let the workqueue
> +	 * do it.
> +	 */
> +	if (READ_ONCE(msk->rcv_data_fin) &&
> +	    msk->ack_seq + 1 =3D=3D READ_ONCE(msk->rcv_data_fin_seq) &&
> +	    schedule_work(&msk->work))
> +		sock_hold(sk);
> +
> 	return done;
> }
>

--
Mat Martineau
Intel
--===============2531220755008107777==--
