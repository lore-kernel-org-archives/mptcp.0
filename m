Content-Type: multipart/mixed; boundary="===============1019869947578868793=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 4/0004] Squash-to: "mptcp: Add handling of
 outgoing MP_JOIN requests"
Date: Wed, 04 Mar 2020 16:14:43 -0800
Message-ID: <alpine.OSX.2.22.394.2003041501400.33439@mlee22-mobl.amr.corp.intel.com>
In-Reply-To: 98f314b8358e6d65ff31513c3adc137b06d9b21e.1583334095.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3865

--===============1019869947578868793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Mar 2020, Paolo Abeni wrote:

> Schedule 3rd ack retransmission via delack timer, and clear
> it on fully established event

It seems ok to me to borrow the delack timer. Is it enough to only =

retransmit the 3rd ack one time?

>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/options.c | 61 ++++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 52 insertions(+), 9 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index eb688b3f759f..6f01ae8efeee 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -341,6 +341,38 @@ void mptcp_rcv_synsent(struct sock *sk)
> 	}
> }
>
> +/* MP_JOIN client subflow must wait for 4th ack before sending any data:
> + * TCP can't schedule delack timer before the subflow is fully establish=
ed.
> + * MPTCP uses the delack timer to do 3rd ack retransmissions
> + */
> +static void schedule_3rdack_retransmission(struct sock *sk)
> +{
> +	struct inet_connection_sock *icsk =3D inet_csk(sk);
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	unsigned long timeout;
> +
> +	/* reschedule with a timeout above RTT, as we must look only for drop */
> +	if (tp->srtt_us)
> +		timeout =3D tp->srtt_us << 1;
> +	else
> +		timeout =3D TCP_TIMEOUT_INIT;
> +
> +	WARN_ON_ONCE(icsk->icsk_ack.pending & ICSK_ACK_TIMER);
> +	icsk->icsk_ack.pending |=3D ICSK_ACK_SCHED | ICSK_ACK_TIMER;
> +	icsk->icsk_ack.timeout =3D timeout;
> +	sk_reset_timer(sk, &icsk->icsk_delack_timer, timeout);
> +}
> +
> +static void clear_3rdack_retransmission(struct sock *sk)
> +{
> +	struct inet_connection_sock *icsk =3D inet_csk(sk);
> +
> +	sk_stop_timer(sk, &icsk->icsk_delack_timer);
> +	icsk->icsk_ack.timeout =3D 0;
> +	icsk->icsk_ack.ato =3D 0;
> +	icsk->icsk_ack.pending &=3D ~(ICSK_ACK_SCHED | ICSK_ACK_TIMER);
> +}
> +
> static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff =
*skb,
> 					 unsigned int *size,
> 					 unsigned int remaining,
> @@ -350,12 +382,20 @@ static bool mptcp_established_options_mp(struct soc=
k *sk, struct sk_buff *skb,
> 	struct mptcp_ext *mpext;
> 	unsigned int data_len;
>
> -	pr_debug("subflow=3D%p fully established=3D%d seq=3D%x:%x remaining=3D%=
d",
> -		 subflow, subflow->fully_established, subflow->snd_isn,
> -		 skb ? TCP_SKB_CB(skb)->seq : 0, remaining);
> +	/* When skb is not available, we better over-estimate the emitted
> +	 * options len. A full DSS option (28 bytes) is longer than
> +	 * TCPOLEN_MPTCP_MPC_ACK_DATA(22) or TCPOLEN_MPTCP_MPJ_ACK(24), so
> +	 * let's the caller try to fit that.

Since *size is not set within this function, I suggest replacing this last =

line with "tell the caller to defer the estimate to =

mptcp_established_options_dss(), which will reserve enough space".

> +	 */
> +	if (!skb)
> +		return false;
> +
> +	/* MPC/MPJ needed only on 3rd ack packet */
> +	if (subflow->snd_isn !=3D TCP_SKB_CB(skb)->seq ||
> +	    subflow->fully_established)

snd_isn is going to match sometimes when the sequence numbers wrap around, =

I think it would be good to check subflow->fully_established first to =

clarify that snd_isn is only meaningful in the !subflow_fully_established =

case.

> +		return false;
>
> -	if (subflow->mp_capable && !subflow->fully_established && skb &&
> -	    subflow->snd_isn =3D=3D TCP_SKB_CB(skb)->seq) {
> +	if (subflow->mp_capable) {
> 		/* When skb is not available, we better over-estimate the
> 		 * emitted options len. A full DSS option is longer than
> 		 * TCPOLEN_MPTCP_MPC_ACK_DATA, so let's the caller try to fit

Looks like this comment was left in when copy/pasting

> @@ -388,12 +428,13 @@ static bool mptcp_established_options_mp(struct soc=
k *sk, struct sk_buff *skb,
> 			 data_len);
>
> 		return true;
> -	} else if (subflow->mp_join && !subflow->fourth_ack) {
> +	} else if (subflow->mp_join) {
> 		opts->suboptions =3D OPTION_MPTCP_MPJ_ACK;
> 		memcpy(opts->hmac, subflow->hmac, MPTCPOPT_HMAC_LEN);
> 		*size =3D TCPOLEN_MPTCP_MPJ_ACK;
> -		subflow->fourth_ack =3D 1;
> 		pr_debug("subflow=3D%p", subflow);
> +
> +		schedule_3rdack_retransmission(sk);
> 		return true;
> 	}
> 	return false;
> @@ -633,10 +674,12 @@ static bool check_fully_established(struct mptcp_so=
ck *msk, struct sock *sk,
> 		return true;
>
> 	subflow->pm_notified =3D 1;
> -	if (subflow->mp_join)
> +	if (subflow->mp_join) {
> +		clear_3rdack_retransmission(sk);
> 		mptcp_pm_subflow_established(msk, subflow);
> -	else
> +	} else {
> 		mptcp_pm_fully_established(msk);
> +	}
> 	return true;
> }
>
> -- =

> 2.21.1

--
Mat Martineau
Intel
--===============1019869947578868793==--
