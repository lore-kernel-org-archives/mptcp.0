Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EDA72
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 00:02:08 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="306195412"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="306195412"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 17:01:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="469824601"
Received: from rdbrim-mobl3.amr.corp.intel.com ([10.209.14.139])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 17:01:52 -0700
Date: Wed, 8 Sep 2021 17:01:51 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [PATCH mptcp-next 2/6] mptcp: infinite mapping sending
In-Reply-To: <d2a098e248e92789c647d6e81f4cb9353edf8eba.1630914699.git.geliangtang@xiaomi.com>
Message-ID: <2d2c885a-41b7-777f-1b8a-880ffb33b6d@linux.intel.com>
References: <cover.1630914699.git.geliangtang@xiaomi.com> <d2a098e248e92789c647d6e81f4cb9353edf8eba.1630914699.git.geliangtang@xiaomi.com>
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
> This patch added the infinite mapping sending logic.
>
> Added a new flag snd_infinite_mapping_enable in mptcp_sock. Set it true
> when a single contiguous subflow is in use in mptcp_pm_mp_fail_received.
> In mptcp_sendmsg_frag, if this flag is true, call the new function
> mptcp_update_infinite_mapping to set the infinite mapping.
>
> Added a new flag infinite_mapping_snd in struct mptcp_subflow_context.
> In mptcp_write_options, if the infinite mapping has been sent, set this
> flag.
>
> In subflow_check_data_avail, if the infinite_mapping_snd flag is
> set, don't reset this subflow.
>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
> net/mptcp/options.c  |  8 ++++++++
> net/mptcp/pm.c       |  6 ++++++
> net/mptcp/protocol.c | 15 +++++++++++++++
> net/mptcp/protocol.h |  2 ++
> net/mptcp/subflow.c  |  4 +++-
> 5 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 422f4acfb3e6..09768cacd2a8 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1325,6 +1325,14 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> 			}
> 		}
> +
> +		if (mpext->data_len == 0) {
> +			const struct sock *ssk = (const struct sock *)tp;
> +			struct mptcp_subflow_context *subflow;
> +
> +			subflow = mptcp_subflow_ctx(ssk);
> +			subflow->infinite_mapping_snd = 1;
> +		}

This doesn't belong in mptcp_write_options(). I don't think this 
infinite_mapping_snd field is needed. I had recommended a bit in the 
mptcp_ext struct so that could override the normal fallback behavior and 
force the DSS to be populated even though fallback had already started. 
Maybe there are problems with that approach that I overlooked, if so 
please let me know.


> 	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
> 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6ab386ff3294..2830adf64f79 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -251,7 +251,13 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>
> void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> {
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +
> 	pr_debug("fail_seq=%llu", fail_seq);
> +
> +	if (!mptcp_has_another_subflow(sk) && !READ_ONCE(msk->noncontiguous))
> +		WRITE_ONCE(msk->snd_infinite_mapping_enable, true);
> }
>
> /* path manager helpers */
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 553082eb1206..3082eb367df2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1274,6 +1274,18 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
> 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
> }
>
> +static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_ext *mpext)
> +{
> +	if (!mpext)
> +		return;
> +
> +	mpext->data_len = 0;

mpext->data_seq and mpext->subflow_seq need to be set to something here. 
subflow_seq can probably be zero (I don't see anything specific in the 
RFC?).

For data_seq, please see my comments on the previous version of this 
patch:

https://lore.kernel.org/mptcp/a82f6587-1c90-552f-2845-5ff33cf7c770@linux.intel.com/

"""
RFC 8684 says the data_seq to use is "the start of the subflow sequence
number of the most recent segment that was known to be delivered intact
(i.e., was successfully DATA_ACKed)".

In other words, the data_seq from the mapping that was for the *beginning*
of the last fully-acked data segment.

This is something else that we don't specifically keep track of yet. The
necessary information is (all?) in the msk->rtx_queue - I think we will
have to add something to the msk to keep track of the 64-bit sequence
number of each mapping as they are acked. This would be updated in
__mptcp_data_acked() or __mptcp_clean_una().
"""

If it looks like I'm misreading the RFC, or if I need to explain it 
better, please let me know!

> +	if (READ_ONCE(msk->csum_enabled))
> +		mpext->csum = 0;

Better to set mpext->csum = 0 unconditionally here.

> +
> +	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
> +}
> +
> static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 			      struct mptcp_data_frag *dfrag,
> 			      struct mptcp_sendmsg_info *info)
> @@ -1406,6 +1418,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> out:
> 	if (READ_ONCE(msk->csum_enabled))
> 		mptcp_update_data_checksum(skb, copy);
> +	if (READ_ONCE(msk->snd_infinite_mapping_enable))
> +		mptcp_update_infinite_mapping(msk, mpext);
> 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
> 	return copy;
> }
> @@ -2877,6 +2891,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
> 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
> 		WRITE_ONCE(msk->csum_enabled, true);
> 	WRITE_ONCE(msk->noncontiguous, false);
> +	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
>
> 	msk->write_seq = subflow_req->idsn + 1;
> 	msk->snd_nxt = msk->write_seq;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 29322e09e7d6..a058af61cf7c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -250,6 +250,7 @@ struct mptcp_sock {
> 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
> 	bool		csum_enabled;
> 	bool		noncontiguous;
> +	bool		snd_infinite_mapping_enable;
> 	spinlock_t	join_list_lock;
> 	struct work_struct work;
> 	struct sk_buff  *ooo_last_skb;
> @@ -433,6 +434,7 @@ struct mptcp_subflow_context {
> 		backup : 1,
> 		send_mp_prio : 1,
> 		send_mp_fail : 1,
> +		infinite_mapping_snd : 1,
> 		rx_eof : 1,
> 		can_ack : 1,        /* only after processing the remote a key */
> 		disposable : 1,	    /* ctx can be free at ulp release time */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 951aafb6021e..87f42ba7c09c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1179,7 +1179,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 		return true;
> 	}
>
> -	if (subflow->mp_join || subflow->fully_established) {
> +	if (subflow->mp_join ||
> +	    (subflow->fully_established &&
> +	     !subflow->infinite_mapping_snd)) {
> 		/* fatal protocol error, close the socket.
> 		 * subflow_error_report() will introduce the appropriate barriers
> 		 */
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
