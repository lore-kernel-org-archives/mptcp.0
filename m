Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4EE3FCB
	for <mptcp@lists.linux.dev>; Tue, 28 Sep 2021 00:52:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="288252610"
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="288252610"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 17:52:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="486338141"
Received: from eequijad-mobl.amr.corp.intel.com ([10.209.4.10])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 17:52:19 -0700
Date: Mon, 27 Sep 2021 17:52:19 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v5 1/8] mptcp: track and update contiguous
 data status
In-Reply-To: <50885831cb65affbe180d3d9be3ba879f8e331f2.1632666254.git.geliangtang@gmail.com>
Message-ID: <ccd12bb9-df4b-e646-9a65-e8de219e15c2@linux.intel.com>
References: <cover.1632666254.git.geliangtang@gmail.com> <50885831cb65affbe180d3d9be3ba879f8e331f2.1632666254.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sun, 26 Sep 2021, Geliang Tang wrote:

> This patch added a new member last_retrans_seq in mptcp_subflow_context
> to track the last retransmitting sequence number.
>
> Add a new helper named mptcp_is_data_contiguous() to check whether the
> data is contiguous on a subflow.
>
> When a bad checksum is detected and a single contiguous subflow is in use,
> don't send RST + MP_FAIL, send data_ack + MP_FAIL instead.
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Hi Geliang -

I know there's been a lot of churn in this part of the patch series, 
hopefully we can simplify a little to allow us to merge the first step of 
infinite mapping send/recv.

In v3 and v4 reviews, I suggested tracking the subflow sequence number 
like you do in this patch. After the discussion in the 2021-09-23 meeting, 
proper tracking of contiguous data appeared even more complicated, so 
Paolo had a suggestion to allow fallback in one simple-to-check case: Only 
do infinite mapping fallback if there is a single subflow AND there have 
been no retransmissions AND there have never been any MP_JOINs.

That can be tracked with a "allow_infinite_fallback" bool in mptcp_sock, 
which gets initialized to 'true' when the connection begins and is set to 
'false' on any retransmit or successful MP_JOIN.

Paolo, is that an accurate summary?


It's important that this type of fallback only happens when it is 
guaranteed that the stream is fully in-sequence, otherwise the 
application's data gets corrupted. The above suggestion lets us merge 
working infinite mapping code, and then figure out the more complicated 
"fallback after retransmissions or join" logic in a separate patch series.


Thanks,

Mat



> ---
> net/mptcp/protocol.c |  6 ++++++
> net/mptcp/protocol.h |  8 ++++++++
> net/mptcp/subflow.c  | 12 ++++++------
> 3 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f8ad049d6941..cf8cccfefb51 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -729,6 +729,9 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> 	if (unlikely(subflow->disposable))
> 		return;
>
> +	if (!subflow->last_retrans_seq || mptcp_is_data_contiguous(ssk))
> +		subflow->last_retrans_seq = tcp_sk(ssk)->snd_una - 1;
> +
> 	ssk_rbuf = READ_ONCE(ssk->sk_rcvbuf);
> 	sk_rbuf = READ_ONCE(sk->sk_rcvbuf);
> 	if (unlikely(ssk_rbuf > sk_rbuf))
> @@ -2415,6 +2418,7 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
> static void __mptcp_retrans(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {};
> 	struct mptcp_data_frag *dfrag;
> 	size_t copied = 0;
> @@ -2464,6 +2468,8 @@ static void __mptcp_retrans(struct sock *sk)
> 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
> 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> 			 info.size_goal);
> +		subflow = mptcp_subflow_ctx(ssk);
> +		subflow->last_retrans_seq = tcp_sk(ssk)->snd_nxt;
> 	}
>
> 	release_sock(ssk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7379ab580a7e..e090a9244f8b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -416,6 +416,7 @@ struct mptcp_subflow_context {
> 	u32	map_data_len;
> 	__wsum	map_data_csum;
> 	u32	map_csum_len;
> +	u32	last_retrans_seq;
> 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
> 		request_join : 1,   /* send MP_JOIN */
> 		request_bkup : 1,
> @@ -625,6 +626,13 @@ static inline bool mptcp_has_another_subflow(struct sock *ssk)
> 	return false;
> }
>
> +static inline bool mptcp_is_data_contiguous(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +
> +	return before(subflow->last_retrans_seq, tcp_sk(ssk)->snd_una);
> +}
> +
> void __init mptcp_proto_init(void);
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> int __init mptcp_proto_v6_init(void);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6172f380dfb7..a8f46a48feb1 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1166,15 +1166,15 @@ static bool subflow_check_data_avail(struct sock *ssk)
> fallback:
> 	/* RFC 8684 section 3.7. */
> 	if (subflow->send_mp_fail) {
> -		if (mptcp_has_another_subflow(ssk)) {
> +		if (mptcp_has_another_subflow(ssk) || !mptcp_is_data_contiguous(ssk)) {
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
