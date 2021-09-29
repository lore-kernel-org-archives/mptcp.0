Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA8F2FAF
	for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 22:12:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="225092006"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="225092006"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 15:12:32 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="555067333"
Received: from crobert2-mobl.amr.corp.intel.com ([10.212.137.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 15:12:31 -0700
Date: Wed, 29 Sep 2021 15:12:30 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v6 3/9] mptcp: track and update contiguous
 data status
In-Reply-To: <9bed3d49d6b462cebc714587fc48d14402269349.1632900306.git.geliangtang@gmail.com>
Message-ID: <d92e5afa-a7b2-a13-6bde-cd26188eb1c9@linux.intel.com>
References: <cover.1632900306.git.geliangtang@gmail.com> <9bed3d49d6b462cebc714587fc48d14402269349.1632900306.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 29 Sep 2021, Geliang Tang wrote:

> This patch added a new member allow_infinite_fallback in mptcp_sock,
> which gets initialized to 'true' when the connection begins and is set
> to 'false' on any retransmit or successful MP_JOIN.
>
> Rename the helper function mptcp_is_data_contiguous() to
> mptcp_allow_infinite_fallback(). In it, only do infinite mapping fallback
> if there is a single subflow AND there have been no retransmissions AND
> there have never been any MP_JOINs.
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/protocol.c |  2 ++
> net/mptcp/protocol.h | 10 +++++++---
> net/mptcp/subflow.c  |  2 +-
> 3 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f8ad049d6941..48979cb82126 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2464,6 +2464,7 @@ static void __mptcp_retrans(struct sock *sk)
> 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
> 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> 			 info.size_goal);
> +		WRITE_ONCE(msk->allow_infinite_fallback, false);
> 	}
>
> 	release_sock(ssk);
> @@ -2542,6 +2543,7 @@ static int __mptcp_init_sock(struct sock *sk)
> 	msk->first = NULL;
> 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
> 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
> +	WRITE_ONCE(msk->allow_infinite_fallback, true);
> 	msk->recovery = false;
>
> 	mptcp_pm_data_init(msk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7379ab580a7e..4807e486e762 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -249,6 +249,7 @@ struct mptcp_sock {
> 	bool		rcv_fastclose;
> 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
> 	bool		csum_enabled;
> +	bool		allow_infinite_fallback;
> 	spinlock_t	join_list_lock;
> 	struct work_struct work;
> 	struct sk_buff  *ooo_last_skb;
> @@ -612,17 +613,20 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
> 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
> }
>
> -static inline bool mptcp_has_another_subflow(struct sock *ssk)
> +static inline bool mptcp_allow_infinite_fallback(struct sock *ssk)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk), *tmp;
> 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>
> 	mptcp_for_each_subflow(msk, tmp) {
> +		if (tmp->mp_join)
> +			return false;
> +
> 		if (tmp != subflow)
> -			return true;
> +			return false;

Sorry I missed your patch-1 v5 reply yesterday! I think it's better for 
now to implement the simpler check discussed in the meeting last week and 
in the v5 review, which is to set allow_infinite_fallback = false when a 
join happens (in mptcp_finish_join() and __mptcp_subflow_connect()). Then 
there's no need to iterate over the subflows here.

We don't have a good answer yet for how to guarantee a subflow and the 
MPTCP-level stream are in a correct state to fallback *after* 
retransmissions or joins, so I think it's important to get this 
single-subflow infinite mapping working and tests implemented first. There 
must be absolute certainty that fallback will not corrupt the application 
data stream.

Mat

> 	}
>
> -	return false;
> +	return READ_ONCE(msk->allow_infinite_fallback);
> }
>
> void __init mptcp_proto_init(void);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 87a9ffebcc42..28ed7dc6e170 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1167,7 +1167,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 	if (!__mptcp_check_fallback(msk)) {
> 		/* RFC 8684 section 3.7. */
> 		if (subflow->send_mp_fail) {
> -			if (mptcp_has_another_subflow(ssk)) {
> +			if (!mptcp_allow_infinite_fallback(ssk)) {
> 				ssk->sk_err = EBADMSG;
> 				tcp_set_state(ssk, TCP_CLOSE);
> 				subflow->reset_transient = 0;
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
