Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7766B72
	for <mptcp@lists.linux.dev>; Wed,  8 Sep 2021 23:39:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="200160095"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="200160095"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 16:39:22 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="539042862"
Received: from rdbrim-mobl3.amr.corp.intel.com ([10.209.14.139])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 16:39:22 -0700
Date: Wed, 8 Sep 2021 16:39:21 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [PATCH mptcp-next 1/6] mptcp: add noncontiguous flag
In-Reply-To: <fed5c608544799a51138d6fb56871811e3ad71ab.1630914699.git.geliangtang@xiaomi.com>
Message-ID: <75aea2-c940-53aa-cc75-644ff532b73b@linux.intel.com>
References: <cover.1630914699.git.geliangtang@xiaomi.com> <fed5c608544799a51138d6fb56871811e3ad71ab.1630914699.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Sep 2021, Geliang Tang wrote:

> From: Geliang Tang <geliangtang@xiaomi.com>
>
> This patch added a "noncontiguous" flag in the msk to track whether the
> data is contiguous on a subflow. When retransmission happens, we could
> set this flag, and once all retransmissions are DATA_ACK'd that flag
> could be cleared.
>
> When a bad checksum is detected and a single contiguous subflow is in
> use, don't send RST + MP_FAIL, send data_ack + MP_FAIL instead.
>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
> net/mptcp/protocol.c | 13 ++++++++++---
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  | 12 ++++++------
> 3 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2a525c7ae920..553082eb1206 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1098,8 +1098,10 @@ static void __mptcp_clean_una(struct sock *sk)
> 	}
>
> 	/* all retransmitted data acked, recovery completed */
> -	if (unlikely(msk->recovery) && after64(msk->snd_una, msk->recovery_snd_nxt))
> +	if (unlikely(msk->recovery) && after64(msk->snd_una, msk->recovery_snd_nxt)) {
> 		msk->recovery = false;
> +		WRITE_ONCE(msk->noncontiguous, false);

This will only clear msk->noncontiguous if msk->recovery was also set, 
msk->noncontiguous would not get cleared if retransmission was triggered 
by mptcp_retransmit_timer() instead of __mptcp_retransmit_pending_data().

We could add a resend_count (or similar) field to struct mptcp_data_frag 
to keep track of how many times a frag has been resent. Since resending 
always happens at the rtx_head, a resend_count == 0 on the rtx_head dfrag 
would indicate that all retransmitted data had been acknowledged and 
msk->noncontiguous can be cleared.

> +	}
>
> out:
> 	if (cleaned && tcp_under_memory_pressure(sk))
> @@ -2502,8 +2504,10 @@ static void mptcp_worker(struct work_struct *work)
> 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
> 		__mptcp_close_subflow(msk);
>
> -	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
> +	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags)) {
> +		WRITE_ONCE(msk->noncontiguous, true);

This write could be done inside __mptcp_retrans(). Then it can be added in 
one place, and then only set if data was actually resent.


- Mat


> 		__mptcp_retrans(sk);
> +	}
>
> unlock:
> 	release_sock(sk);
> @@ -2872,6 +2876,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
> 	WRITE_ONCE(msk->fully_established, false);
> 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
> 		WRITE_ONCE(msk->csum_enabled, true);
> +	WRITE_ONCE(msk->noncontiguous, false);
>
> 	msk->write_seq = subflow_req->idsn + 1;
> 	msk->snd_nxt = msk->write_seq;
> @@ -3040,8 +3045,10 @@ static void mptcp_release_cb(struct sock *sk)
> 		spin_unlock_bh(&sk->sk_lock.slock);
> 		if (flags & BIT(MPTCP_PUSH_PENDING))
> 			__mptcp_push_pending(sk, 0);
> -		if (flags & BIT(MPTCP_RETRANSMIT))
> +		if (flags & BIT(MPTCP_RETRANSMIT)) {
> +			WRITE_ONCE(mptcp_sk(sk)->noncontiguous, true);
> 			__mptcp_retrans(sk);
> +		}
>
> 		cond_resched();
> 		spin_lock_bh(&sk->sk_lock.slock);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 99a23fff7b03..29322e09e7d6 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -249,6 +249,7 @@ struct mptcp_sock {
> 	bool		rcv_fastclose;
> 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
> 	bool		csum_enabled;
> +	bool		noncontiguous;
> 	spinlock_t	join_list_lock;
> 	struct work_struct work;
> 	struct sk_buff  *ooo_last_skb;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 1de7ce883c37..951aafb6021e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1166,15 +1166,15 @@ static bool subflow_check_data_avail(struct sock *ssk)
> fallback:
> 	/* RFC 8684 section 3.7. */
> 	if (subflow->send_mp_fail) {
> -		if (mptcp_has_another_subflow(ssk)) {
> +		if (mptcp_has_another_subflow(ssk) || READ_ONCE(msk->noncontiguous)) {
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
