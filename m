Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585583FC0
	for <mptcp@lists.linux.dev>; Sat,  4 Sep 2021 00:23:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="283253671"
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="283253671"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 17:23:18 -0700
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="692509160"
Received: from gchandr2-mobl.amr.corp.intel.com ([10.209.38.180])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 17:23:18 -0700
Date: Fri, 3 Sep 2021 17:23:18 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [MPTCP][PATCH RFC 2/5] mptcp: infinite mapping sending
In-Reply-To: <7d43c0b1c5f336641d9c8edef80cd0e37b93b668.1630656206.git.geliangtang@xiaomi.com>
Message-ID: <a82f6587-1c90-552f-2845-5ff33cf7c770@linux.intel.com>
References: <cover.1630656206.git.geliangtang@xiaomi.com> <c9504a9a84a501016ddc53ebbf644f827233b7e0.1630656206.git.geliangtang@xiaomi.com> <7d43c0b1c5f336641d9c8edef80cd0e37b93b668.1630656206.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 3 Sep 2021, Geliang Tang wrote:

> From: Geliang Tang <geliangtang@xiaomi.com>
>
> This patch added the infinite mapping sending logic.
>
> Added a new flag snd_infinite_mapping_enable in mptcp_sock. Set it true
> when a single subflow is in use in mptcp_pm_mp_fail_received.
>
> In mptcp_sendmsg_frag, if this flag is true, call the new function
> mptcp_update_infinite_mapping to set the infinite mapping.
>
> In mptcp_write_options, send out the infinite mapping and fallback to
> a regular TCP.
>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
> net/mptcp/options.c  | 13 +++++++++++++
> net/mptcp/pm.c       |  6 ++++++
> net/mptcp/protocol.c | 21 +++++++++++++++++++++
> net/mptcp/protocol.h |  1 +
> 4 files changed, 41 insertions(+)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1ec6529c4326..e2df21246be7 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1326,6 +1326,19 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 				put_unaligned_be32(mpext->data_len << 16 |
> 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> 			}
> +
> +			if (mpext->data_len == 0) {
> +				const struct sock *ssk = (const struct sock *)tp;
> +				struct mptcp_subflow_context *subflow;
> +				struct mptcp_sock *msk;
> +
> +				subflow = mptcp_subflow_ctx(ssk);
> +				msk = mptcp_sk(subflow->conn);
> +
> +				pr_debug("write infinite mapping!");
> +				pr_fallback(msk);
> +				__mptcp_do_fallback(msk);
> +			}

The fallback action shouldn't happen inside mptcp_write_options(). I have 
a suggestion below.

> 		}
> 	} else if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> 		    OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6ab386ff3294..39f2dcda53bf 100644
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
> +	if (!mptcp_has_another_subflow(sk))
> +		WRITE_ONCE(msk->snd_infinite_mapping_enable, true);

Like patch 1, there needs to be a check for both "single subflow" and 
"contiguous data".

> }
>
> /* path manager helpers */
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index faf6e7000d18..dd7738a6b7f5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1282,6 +1282,22 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
> 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
> }
>
> +static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_ext *mpext)
> +{
> +	if (!mpext)
> +		return;
> +
> +	mpext->data_seq = READ_ONCE(msk->ack_seq);

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

> +	mpext->data_len = 0;

I think it might work well to add an infinite_mapping field to struct 
mptcp_ext, and that could be checked in mptcp_established_options() to 
allow the DSS option to be written even if the fallback flag is set.

> +	if (READ_ONCE(msk->csum_enabled))
> +		mpext->csum = 0;
> +
> +	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
> +
> +	pr_debug("infinite mapping: data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d",
> +		 mpext->data_seq, mpext->subflow_seq, mpext->data_len, mpext->dsn64);
> +}
> +
> static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 			      struct mptcp_data_frag *dfrag,
> 			      struct mptcp_sendmsg_info *info)
> @@ -1390,6 +1406,10 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> out:
> 	if (READ_ONCE(msk->csum_enabled))
> 		mptcp_update_data_checksum(tail, ret);
> +
> +	if (READ_ONCE(msk->snd_infinite_mapping_enable))
> +		mptcp_update_infinite_mapping(msk, mpext);
> +
> 	mptcp_subflow_ctx(ssk)->rel_write_seq += ret;
> 	return ret;
> }
> @@ -2858,6 +2878,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
> 	WRITE_ONCE(msk->fully_established, false);
> 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
> 		WRITE_ONCE(msk->csum_enabled, true);
> +	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
>
> 	msk->write_seq = subflow_req->idsn + 1;
> 	msk->snd_nxt = msk->write_seq;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 99a23fff7b03..33400fcdf1b1 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -246,6 +246,7 @@ struct mptcp_sock {
> 	bool		fully_established;
> 	bool		rcv_data_fin;
> 	bool		snd_data_fin_enable;
> +	bool		snd_infinite_mapping_enable;
> 	bool		rcv_fastclose;
> 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
> 	bool		csum_enabled;
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
