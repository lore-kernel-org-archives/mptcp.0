Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA092FA4
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 23:42:52 +0000 (UTC)
IronPort-SDR: qEqvx9onQR5qkAbAiFLNcdB5XxNUk9rAHz8cPucwgWkO6eYUq7Kkjk/jpx8Ua0TvG5YJ1GGDSz
 zfZPsJHI50iw==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="183632786"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="183632786"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 16:42:51 -0700
IronPort-SDR: XMA0Orb1Bx7yovhl3rLZWYe0/7k7AXuDtPpJIIMlE7HJLAA9O2LjYQNDfLg3aKL33l+Jz+VO4k
 0Fwqr7Jzb5zw==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="618112648"
Received: from glmorris-mobl.amr.corp.intel.com ([10.212.196.131])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 16:42:51 -0700
Date: Fri, 23 Apr 2021 16:42:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@gmail.com>
Subject: Re: [PATCH v4 mptcp-next 16/22] Squash-to: mptcp: validate the data
 checksum
In-Reply-To: <7a57898c62ea8d8476037db1b050cbd3d2a8133f.1619189145.git.pabeni@redhat.com>
Message-ID: <929ae094-622b-e477-6dc4-db5b5103c0@linux.intel.com>
References: <cover.1619189145.git.pabeni@redhat.com> <7a57898c62ea8d8476037db1b050cbd3d2a8133f.1619189145.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 23 Apr 2021, Paolo Abeni wrote:

> Move the RX csum validation into get_mapping_status().
> If the current mapping is valid and csum is enabled traverse the
> later pending skbs and compute csum incrementally till the whole
> mapping has been covered. If not enough data is available in the
> rx queue, return MAPPING_EMPTY - that is, no data.
>
> Next subflow_data_ready invocation will trigger again csum computation.
>
> When the full DSS is available, validate the csum and return to the
> caller an appropriate error code, to trigger subflow reset of fallback
> as required by the RFC.
>
> Additionally:
> - if the csum prevence in the DSS don't match the negotiated value
> e.g. csum present, but not requested, return invalid mapping to trigger
> subflow reset.
> - keep some csum state, to avoid re-compute the csum on the
> same data when multiple rx queue traversal are required.
> - clean-up the uncompleted mapping from the receive queue on close,
> to allow proper subflow disposal
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
> - drop unrelated 'fallback' changes (geliang)
> - fix csum computation for data segment with data fin bit set
> ---
> net/mptcp/protocol.c |  35 ---------------
> net/mptcp/protocol.h |   7 +--
> net/mptcp/subflow.c  | 104 +++++++++++++++++++++++++++++++++++++++----
> 3 files changed, 99 insertions(+), 47 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5160256de731..0d8005b480ab 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -520,35 +520,6 @@ static bool mptcp_check_data_fin(struct sock *sk)
> 	return ret;
> }
>
> -static bool mptcp_validate_data_checksum(struct sock *ssk)
> -{
> -	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> -	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> -	struct csum_pseudo_header header;
> -	__wsum csum;
> -
> -	if (__mptcp_check_fallback(msk))
> -		goto out;
> -
> -	if (subflow->csum_len < subflow->map_data_len)
> -		goto out;
> -
> -	header.data_seq = subflow->map_seq;
> -	header.subflow_seq = subflow->map_subflow_seq;
> -	header.data_len = subflow->map_data_len;
> -	header.csum = subflow->map_csum;
> -
> -	csum = csum_partial(&header, sizeof(header), subflow->data_csum);
> -
> -	if (csum_fold(csum))
> -		return false;
> -	subflow->data_csum = 0;
> -	subflow->csum_len = 0;
> -
> -out:
> -	return true;
> -}
> -
> static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> 					   struct sock *ssk,
> 					   unsigned int *bytes)
> @@ -617,12 +588,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> 			if (tp->urg_data)
> 				done = true;
>
> -			if (READ_ONCE(msk->csum_enabled)) {
> -				subflow->data_csum = skb_checksum(skb, offset, len,
> -								  subflow->data_csum);
> -				subflow->csum_len += len;
> -				mptcp_validate_data_checksum(ssk);
> -			}
> 			if (__mptcp_move_skb(msk, ssk, skb, offset, len))
> 				moved += len;
> 			seq += len;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 176f175a00bd..747cd94da78b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -399,9 +399,8 @@ struct mptcp_subflow_context {
> 	u32	map_subflow_seq;
> 	u32	ssn_offset;
> 	u32	map_data_len;
> -	__wsum	data_csum;
> -	u32	csum_len;
> -	__sum16	map_csum;
> +	__wsum	map_data_csum;
> +	u32	map_csum_len;
> 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
> 		request_join : 1,   /* send MP_JOIN */
> 		request_bkup : 1,
> @@ -411,6 +410,8 @@ struct mptcp_subflow_context {
> 		pm_notified : 1,    /* PM hook called for established status */
> 		conn_finished : 1,
> 		map_valid : 1,
> +		map_csum_reqd : 1,
> +		map_data_fin : 1,
> 		mpc_map : 1,
> 		backup : 1,
> 		send_mp_prio : 1,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 68efc81eaf2c..0ee568a99da1 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -829,10 +829,86 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
> 	return true;
> }
>
> +static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *skb,
> +					      bool csum_reqd)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	struct csum_pseudo_header header;
> +	u32 offset, seq, delta;
> +	__wsum csum;
> +	int len;
> +
> +	if (!csum_reqd)
> +		return MAPPING_OK;
> +
> +	/* mapping already validated on previous traversal */
> +	if (subflow->map_csum_len == subflow->map_data_len)
> +		return MAPPING_OK;
> +
> +	/* traverse the receive queue, ensuring it contains a full
> +	 * DSS mapping and accumulating the related csum.
> +	 * Preserve the accoumlate csum across multiple calls, to compute
> +	 * the csum only once
> +	 */
> +	delta = subflow->map_data_len - subflow->map_csum_len;
> +	for (;;) {
> +		seq = tcp_sk(ssk)->copied_seq + subflow->map_csum_len;
> +		offset = seq - TCP_SKB_CB(skb)->seq;
> +
> +		/* if the current skb has not been accounted yet, csum its contents
> +		 * up to the amount covered by the current DSS
> +		 */
> +		if (offset < skb->len) {
> +			len = min(skb->len - offset, delta);
> +			delta -= len;
> +			subflow->map_csum_len += len;
> +			subflow->map_data_csum = skb_checksum(skb, offset, len,
> +							      subflow->map_data_csum);

skb_checksum() can only be used here if the data values are properly 
aligned for the 16-bit checksum. Think about the pathological case of all 
skbs with 1-byte payloads - you can't update the checksum until you have 
two bytes to feed to the checksum calculation (unless it's the last 
byte).

Also see the comment with checksum_partial() that ends up doing the work 
for skb_checksum() - "this function must be called with even lengths, 
except for the last fragment, which may be odd".

Unfortunately even more complexity is needed to handle partial checksums 
of odd-length data - if it's not the end of a mapping (where the odd 
length is ok), would need to exclude the trailing 1 byte and then combine 
that byte with the next chunk of data that arrives.

mptcp_verif_dss_csum() in the multipath-tcp.org kernel has a bunch of 
logic to deal with this.

I was starting to think that it might be easier to just calculate the csum 
once when the full mapping is available, but the code would still have to 
handle arbitrary odd-length or odd-aligned data in each skb.


Overall, I think the changes to the series are moving the code in the 
right direction. Thanks for working on this!

Mat

> +		}
> +		if (delta == 0)
> +			break;
> +
> +		if (skb_queue_is_last(&ssk->sk_receive_queue, skb)) {
> +			/* if this subflow is closed, the partial mapping
> +			 * will be never completed; flush the pending skbs, so
> +			 * that subflow_sched_work_if_closed() can kick in
> +			 */
> +			if (unlikely(ssk->sk_state == TCP_CLOSE))
> +				while ((skb = skb_peek(&ssk->sk_receive_queue)))
> +					sk_eat_skb(ssk, skb);
> +
> +			/* not enough data to validate the csum */
> +			return MAPPING_EMPTY;
> +		}
> +
> +		/* the DSS mapping for next skbs will be validated later,
> +		 * when a get_mapping_status call will process such skb
> +		 */
> +		skb = skb->next;
> +	}
> +
> +	/* note that 'map_data_len' accounts only for the carried data, does
> +	 * not include the eventual seq increment due to the data fin,
> +	 * while the pseudo header requires the original DSS data len,
> +	 * including that
> +	 */
> +	header.data_seq = subflow->map_seq;
> +	header.subflow_seq = subflow->map_subflow_seq;
> +	header.data_len = subflow->map_data_len + subflow->map_data_fin;
> +	header.csum = 0;
> +
> +	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
> +	if (unlikely(csum_fold(csum)))
> +		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
> +
> +	return MAPPING_OK;
> +}
> +
> static enum mapping_status get_mapping_status(struct sock *ssk,
> 					      struct mptcp_sock *msk)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	bool csum_reqd = READ_ONCE(msk->csum_enabled);
> 	struct mptcp_ext *mpext;
> 	struct sk_buff *skb;
> 	u16 data_len;
> @@ -926,9 +1002,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 		/* Allow replacing only with an identical map */
> 		if (subflow->map_seq == map_seq &&
> 		    subflow->map_subflow_seq == mpext->subflow_seq &&
> -		    subflow->map_data_len == data_len) {
> +		    subflow->map_data_len == data_len &&
> +		    subflow->map_csum_reqd == mpext->csum_reqd) {
> 			skb_ext_del(skb, SKB_EXT_MPTCP);
> -			return MAPPING_OK;
> +			goto validate_csum;
> 		}
>
> 		/* If this skb data are fully covered by the current mapping,
> @@ -940,20 +1017,27 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 		}
>
> 		/* will validate the next map after consuming the current one */
> -		return MAPPING_OK;
> +		goto validate_csum;
> 	}
>
> 	subflow->map_seq = map_seq;
> 	subflow->map_subflow_seq = mpext->subflow_seq;
> 	subflow->map_data_len = data_len;
> 	subflow->map_valid = 1;
> +	subflow->map_data_fin = mpext->data_fin;
> 	subflow->mpc_map = mpext->mpc_map;
> -	subflow->data_csum = 0;
> -	subflow->csum_len = 0;
> -	subflow->map_csum = mpext->csum;
> -	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%u",
> +	subflow->map_csum_reqd = mpext->csum_reqd;
> +	subflow->map_csum_len = 0;
> +	subflow->map_data_csum = csum_unfold(mpext->csum);
> +
> +	/* Cfr RFC 8684 Section 3.3.0 */
> +	if (unlikely(subflow->map_csum_reqd != csum_reqd))
> +		return MAPPING_INVALID;
> +
> +	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
> 		 subflow->map_seq, subflow->map_subflow_seq,
> -		 subflow->map_data_len, subflow->map_csum);
> +		 subflow->map_data_len, subflow->map_csum_reqd,
> +		 subflow->map_data_csum);
>
> validate_seq:
> 	/* we revalidate valid mapping on new skb, because we must ensure
> @@ -963,7 +1047,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 		return MAPPING_INVALID;
>
> 	skb_ext_del(skb, SKB_EXT_MPTCP);
> -	return MAPPING_OK;
> +
> +validate_csum:
> +	return validate_data_csum(ssk, skb, csum_reqd);
> }
>
> static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
> -- 
> 2.26.2
>
>
>

--
Mat Martineau
Intel
