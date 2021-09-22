Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154A93FC8
	for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 00:42:09 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="220295185"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="220295185"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 17:42:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="474326715"
Received: from wjwiegan-mobl.amr.corp.intel.com ([10.255.231.88])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 17:42:09 -0700
Date: Tue, 21 Sep 2021 17:42:08 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 1/8] mptcp: track and update contiguous
 data status
In-Reply-To: <60448fc4985b38f168394a8029f74dcba7b81fb6.1631949480.git.geliangtang@gmail.com>
Message-ID: <845a8a5-c067-0a-b0cc-da49227da9da@linux.intel.com>
References: <cover.1631949480.git.geliangtang@gmail.com> <60448fc4985b38f168394a8029f74dcba7b81fb6.1631949480.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 18 Sep 2021, Geliang Tang wrote:

> This patch added a new member last_retrans_seq in the msk to track the
> last retransmitting sequence number.
>
> Add a new helper named mptcp_is_data_contiguous() to check whether the
> data is contiguous on a subflow.
>
> When a bad checksum is detected and a single contiguous subflow is in
> use, don't send RST + MP_FAIL, send data_ack + MP_FAIL instead.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/protocol.c | 15 +++++++++++++--
> net/mptcp/protocol.h |  6 ++++++
> net/mptcp/subflow.c  | 12 ++++++------
> 3 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ff574d62073f..b766b36e6c93 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1102,8 +1102,13 @@ static void __mptcp_clean_una(struct sock *sk)
> 		msk->recovery = false;
>
> out:
> -	if (cleaned && tcp_under_memory_pressure(sk))
> -		__mptcp_mem_reclaim_partial(sk);
> +	if (cleaned) {
> +		if (mptcp_is_data_contiguous(msk))
> +			msk->last_retrans_seq = msk->snd_una - 1;
> +
> +		if (tcp_under_memory_pressure(sk))
> +			__mptcp_mem_reclaim_partial(sk);
> +	}
>
> 	if (snd_una == READ_ONCE(msk->snd_nxt) &&
> 	    snd_una == READ_ONCE(msk->write_seq)) {
> @@ -2419,6 +2424,7 @@ static void __mptcp_retrans(struct sock *sk)
> 	struct mptcp_data_frag *dfrag;
> 	size_t copied = 0;
> 	struct sock *ssk;
> +	u64 retrans_seq;
> 	int ret;
>
> 	mptcp_clean_una_wakeup(sk);
> @@ -2464,6 +2470,9 @@ static void __mptcp_retrans(struct sock *sk)
> 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
> 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> 			 info.size_goal);
> +		retrans_seq = dfrag->data_seq + info.sent;
> +		if (after64(retrans_seq, msk->last_retrans_seq))
> +			msk->last_retrans_seq = retrans_seq;
> 	}
>
> 	release_sock(ssk);
> @@ -2889,6 +2898,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
> 	msk->snd_una = msk->write_seq;
> 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
> 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
> +	msk->last_retrans_seq = subflow_req->idsn - 1;
>
> 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
> 		msk->can_ack = true;
> @@ -3145,6 +3155,7 @@ void mptcp_finish_connect(struct sock *ssk)
> 	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
> 	WRITE_ONCE(msk->can_ack, 1);
> 	WRITE_ONCE(msk->snd_una, msk->write_seq);
> +	WRITE_ONCE(msk->last_retrans_seq, subflow->idsn - 1);
>
> 	mptcp_pm_new_connection(msk, ssk, 0);
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d516fb6578cc..eb3473d128d4 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -227,6 +227,7 @@ struct mptcp_sock {
> 	u64		ack_seq;
> 	u64		rcv_wnd_sent;
> 	u64		rcv_data_fin_seq;
> +	u64		last_retrans_seq;
> 	int		wmem_reserved;
> 	struct sock	*last_snd;
> 	int		snd_burst;
> @@ -625,6 +626,11 @@ static inline bool mptcp_has_another_subflow(struct sock *ssk)
> 	return false;
> }
>
> +static inline bool mptcp_is_data_contiguous(struct mptcp_sock *msk)
> +{
> +	return before64(msk->last_retrans_seq, msk->snd_una);
> +}

As I mentioned in 
https://lore.kernel.org/mptcp/69c4ec57-94ed-4631-317a-617f994bc77@linux.intel.com/ 
I don't think this is enough to be sure the subflow stream is fully 
contiguous (the one remaining subflow has flushed out all MPTCP-level 
retransmissions).

MPTCP can do multiple retransmissions of the same MPTCP-level data, so it 
seems necessary to track the last sequence number using the 32-bit TCP 
sequence number on the subflow. For example, storing a copy of 
tcp_sk(ssk)->snd_nxt after the tcp_push() call in __mptcp_retrans(). Then 
in mptcp_data_ready() we can compare that retransmitted snd_nxt copy with 
tcp_sk(ssk)->snd_una, very similar to the code added to 
__mptcp_clean_una() above.

Anyone have a simpler idea?

- Mat


> +
> void __init mptcp_proto_init(void);
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> int __init mptcp_proto_v6_init(void);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 1de7ce883c37..b07803ed3053 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1166,15 +1166,15 @@ static bool subflow_check_data_avail(struct sock *ssk)
> fallback:
> 	/* RFC 8684 section 3.7. */
> 	if (subflow->send_mp_fail) {
> -		if (mptcp_has_another_subflow(ssk)) {
> +		if (mptcp_has_another_subflow(ssk) || !mptcp_is_data_contiguous(msk)) {
> +			ssk->sk_err = EBADMSG;
> +			tcp_set_state(ssk, TCP_CLOSE);
> +			subflow->reset_transient = 0;
> +			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> +			tcp_send_active_reset(ssk, GFP_ATOMIC);
> 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
> 				sk_eat_skb(ssk, skb);
> 		}
> -		ssk->sk_err = EBADMSG;
> -		tcp_set_state(ssk, TCP_CLOSE);
> -		subflow->reset_transient = 0;
> -		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> -		tcp_send_active_reset(ssk, GFP_ATOMIC);
> 		WRITE_ONCE(subflow->data_avail, 0);
> 		return true;
> 	}
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
