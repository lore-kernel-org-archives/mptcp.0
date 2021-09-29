Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD92FAF
	for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 22:16:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="205200197"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="205200197"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 15:16:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="476792527"
Received: from crobert2-mobl.amr.corp.intel.com ([10.212.137.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 15:16:30 -0700
Date: Wed, 29 Sep 2021 15:16:29 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v6 5/9] mptcp: infinite mapping sending
In-Reply-To: <2128ccf27ebb66936b4a908dd5704dd7d7c72807.1632900306.git.geliangtang@gmail.com>
Message-ID: <82fb3dde-4518-f73c-b8f8-47b577158ec@linux.intel.com>
References: <cover.1632900306.git.geliangtang@gmail.com> <2128ccf27ebb66936b4a908dd5704dd7d7c72807.1632900306.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 29 Sep 2021, Geliang Tang wrote:

> This patch added the infinite mapping sending logic.
>
> Added a new flag send_infinite_map in struct mptcp_subflow_context. Set
> it true when a single contiguous subflow is in use in
> mptcp_pm_mp_fail_received.
>
> In mptcp_sendmsg_frag, if this flag is true, call the new function
> mptcp_update_infinite_map to set the infinite mapping.
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> include/net/mptcp.h  |  3 ++-
> net/mptcp/options.c  |  2 +-
> net/mptcp/pm.c       |  5 +++++
> net/mptcp/protocol.c | 19 +++++++++++++++++++
> net/mptcp/protocol.h | 12 ++++++++++++
> 5 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index f83fa48408b3..29e930540ea2 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -35,7 +35,8 @@ struct mptcp_ext {
> 			frozen:1,
> 			reset_transient:1;
> 	u8		reset_reason:4,
> -			csum_reqd:1;
> +			csum_reqd:1,
> +			infinite_map:1;
> };
>
> #define MPTCP_RM_IDS_MAX	8
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 422f4acfb3e6..f4591421ed22 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -816,7 +816,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>
> 	opts->suboptions = 0;
>
> -	if (unlikely(__mptcp_check_fallback(msk)))
> +	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
> 		return false;
>
> 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6ab386ff3294..5b99c0c9c17e 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -251,7 +251,12 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>
> void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> {
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +
> 	pr_debug("fail_seq=%llu", fail_seq);
> +
> +	if (mptcp_allow_infinite_fallback(sk))
> +		subflow->send_infinite_map = 1;
> }
>
> /* path manager helpers */
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 334bbce69fcb..5b73493c75c5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1274,6 +1274,23 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
> 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
> }
>
> +static void mptcp_update_infinite_map(struct mptcp_sock *msk, struct sock *ssk,
> +				      struct mptcp_ext *mpext)
> +{
> +	if (!mpext)
> +		return;
> +
> +	mpext->infinite_map = 1;
> +	mpext->data_seq = READ_ONCE(msk->last_ack_dss_start);
> +	mpext->subflow_seq = 0;

To match up with Christoph's reply from a couple of days ago (if I'm 
reading it right), I think you just delete the above 2 lines so data_seq 
and subflow_seq are unmodified from the values they were set to in 
mptcp_sendmsg_frag().

Mat


> +	mpext->data_len = 0;
> +	mpext->csum = 0;
> +
> +	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
> +	pr_fallback(msk);
> +	__mptcp_do_fallback(msk);
> +}
> +
> static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 			      struct mptcp_data_frag *dfrag,
> 			      struct mptcp_sendmsg_info *info)
> @@ -1406,6 +1423,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> out:
> 	if (READ_ONCE(msk->csum_enabled))
> 		mptcp_update_data_checksum(skb, copy);
> +	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
> +		mptcp_update_infinite_map(msk, ssk, mpext);
> 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
> 	return copy;
> }
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7927acf53f06..9da4dd3b2e2d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -433,6 +433,7 @@ struct mptcp_subflow_context {
> 		backup : 1,
> 		send_mp_prio : 1,
> 		send_mp_fail : 1,
> +		send_infinite_map : 1,
> 		rx_eof : 1,
> 		can_ack : 1,        /* only after processing the remote a key */
> 		disposable : 1,	    /* ctx can be free at ulp release time */
> @@ -872,6 +873,17 @@ static inline void mptcp_do_fallback(struct sock *sk)
>
> #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
>
> +static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
> +{
> +	struct mptcp_ext *mpext;
> +
> +	mpext = skb ? mptcp_get_ext(skb) : NULL;
> +	if (mpext && mpext->infinite_map)
> +		return true;
> +
> +	return false;
> +}
> +
> static inline bool subflow_simultaneous_connect(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
