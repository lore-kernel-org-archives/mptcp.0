Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDBE3FC2
	for <mptcp@lists.linux.dev>; Fri, 10 Sep 2021 00:39:53 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="220628682"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="220628682"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 17:39:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="470321076"
Received: from jabusaid-mobl.amr.corp.intel.com ([10.255.231.212])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 17:39:52 -0700
Date: Thu, 9 Sep 2021 17:39:51 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [PATCH mptcp-next v2 4/9] mptcp: add start_seq in the msk
In-Reply-To: <48b3740fe2e7339114c7aa8278e5615cdb6b997b.1631188109.git.geliangtang@xiaomi.com>
Message-ID: <1aa2848e-81da-216-4767-999e77bf5db5@linux.intel.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com> <48b3740fe2e7339114c7aa8278e5615cdb6b997b.1631188109.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 9 Sep 2021, Geliang Tang wrote:

> From: Geliang Tang <geliangtang@xiaomi.com>
>
> This patch added a new member named start_seq to the msk to keep track of
> the beginning of the last fully-acked data segment. This would be updated
> in __mptcp_move_skb and mptcp_pending_data_fin.
>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
> net/mptcp/protocol.c | 4 ++++
> net/mptcp/protocol.h | 1 +
> 2 files changed, 5 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 81ea03b9fff6..c7ecd3e3b537 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -308,6 +308,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
>
> 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
> 		/* in sequence */
> +		WRITE_ONCE(msk->start_seq, msk->ack_seq);

This is tracking the previous value of ack_seq, which is not always 
aligned with the beginning of a DSS segment. It's also recording a 
sequence number for data received by this peer... but I think the RFC is 
asking for the inifinite mapping sequence number to be for data *sent* by 
this peer and acked by the other side.

This peer has already sent acknowledgements for the data received, so 
there's no need to send information (old rx sequence numbers) that the 
other side already has.

- Mat


> 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
> 		tail = skb_peek_tail(&sk->sk_receive_queue);
> 		if (tail && mptcp_try_coalesce(sk, tail, skb))
> @@ -523,6 +524,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
> 	 */
>
> 	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
> +		WRITE_ONCE(msk->start_seq, msk->ack_seq);
> 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
> 		WRITE_ONCE(msk->rcv_data_fin, 0);
>
> @@ -2894,6 +2896,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
> 		WRITE_ONCE(msk->ack_seq, ack_seq);
> 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
> 	}
> +	WRITE_ONCE(msk->start_seq, 0);
>
> #if !IS_ENABLED(CONFIG_KASAN)
> 	sock_reset_flag(nsk, SOCK_RCU_FREE);
> @@ -3141,6 +3144,7 @@ void mptcp_finish_connect(struct sock *ssk)
> 	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
> 	WRITE_ONCE(msk->can_ack, 1);
> 	WRITE_ONCE(msk->snd_una, msk->write_seq);
> +	WRITE_ONCE(msk->start_seq, 0);
>
> 	mptcp_pm_new_connection(msk, ssk, 0);
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 5644a361b9c7..77af55171ded 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -226,6 +226,7 @@ struct mptcp_sock {
> 	u64		remote_key;
> 	u64		write_seq;
> 	u64		snd_nxt;
> +	u64		start_seq;
> 	u64		ack_seq;
> 	u64		rcv_wnd_sent;
> 	u64		rcv_data_fin_seq;
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
