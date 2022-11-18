Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D63D51B
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 22:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668809731; x=1700345731;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tHlApG95Qad3pXe4NNtt0pLmYZlK6KeJhc5HvyxU+To=;
  b=eeNrOnilcABl3ZuMaV149beKcrCVHghMQMLebTaEHdyaNdvRpR6qX5/a
   29D2B6Hc1CPGmRNb9zmzS+hZjUZ8wk7KXnqYu256q66dTdeRs/NhH3Mc3
   0LTzZX53Mm9bar/qbJ4XEyz755RDDMjmCCDAMvQXWSNfM1OOmDhWA0XNG
   JuSrhpKvXiEE6zQhCxj8siishApFDwHwEjHNxxdcX/swos629y8OxM5Zj
   Pu3NRolYL8RMqEcdQpjzIAWuedFBvB5VaWwslDcOd6+TMvmqSJp4FEm1b
   YgZjiwqAe6/oDKDagnk2DmSC3uFPCT45NwSqPtmpnmz94JPyC5pGE5DDa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="313276797"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="313276797"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 14:15:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="969429759"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="969429759"
Received: from kwells1-mobl1.amr.corp.intel.com ([10.212.140.181])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 14:15:31 -0800
Date: Fri, 18 Nov 2022 14:15:30 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v20 5/7] mptcp: delay updating already_sent
In-Reply-To: <863432f61618b8625948918365524c9bfa9f9aed.1668598782.git.geliang.tang@suse.com>
Message-ID: <4bb1b7db-1410-c0d7-ea8a-f73965605ee4@linux.intel.com>
References: <cover.1668598782.git.geliang.tang@suse.com> <863432f61618b8625948918365524c9bfa9f9aed.1668598782.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Nov 2022, Geliang Tang wrote:

> This patch adds a new member sent in struct mptcp_data_frag, save
> info->sent in it, to support delay updating already_sent of dfrags
> until all data is sent.
>

I think this patch is likely the cause of the DSS issues you mentioned in 
https://lore.kernel.org/mptcp/20221022125610.GA28495@bogon/

Looking at the code some more, __mptcp_clean_una() accesses and modifies 
dfrag->already_sent. If data is sent on one subflow, it can be acked at 
any time - even while the redundant sends are still happening on other 
subflows. So I don't think delaying dfrag->already_sent updates is a 
design that can work.

This makes me think that redundant sends need to work more like the MPTCP 
retransmit code path. When the scheduler selects multiple subflows, the 
first subflow to send is a "normal" transmit, and any other subflows would 
act like a retransmit when accessing the dfrags.


- Mat


> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 18 ++++++++++++++++--
> net/mptcp/protocol.h |  1 +
> 2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4c249d1b9ec6..a1007751bd4d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1099,6 +1099,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
> 	dfrag->data_seq = msk->write_seq;
> 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
> 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
> +	dfrag->sent = 0;
> 	dfrag->already_sent = 0;
> 	dfrag->page = pfrag->page;
>
> @@ -1484,11 +1485,11 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
> {
> 	u64 snd_nxt_new = dfrag->data_seq;
>
> -	dfrag->already_sent += sent;
> +	dfrag->sent += sent;
>
> 	msk->snd_burst -= sent;
>
> -	snd_nxt_new += dfrag->already_sent;
> +	snd_nxt_new += dfrag->sent;
>
> 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
> 	 * is recovering after a failover. In that event, this re-sends
> @@ -1513,6 +1514,18 @@ static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_inf
>
> static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
> {
> +	struct mptcp_data_frag *dfrag = mptcp_send_head(sk);
> +
> +	if (!dfrag)
> +		return;
> +
> +	do {
> +		if (dfrag->sent) {
> +			dfrag->already_sent = max(dfrag->already_sent, dfrag->sent);
> +			dfrag->sent = 0;
> +		}
> +	} while ((dfrag = mptcp_next_frag(sk, dfrag)));
> +
> 	mptcp_update_first_pending(sk, info);
> }
>
> @@ -1539,6 +1552,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> 		info->sent = dfrag->already_sent;
> 		info->limit = dfrag->data_len;
> 		len = dfrag->data_len - dfrag->already_sent;
> +		dfrag->sent = info->sent;
> 		while (len > 0) {
> 			int ret = 0;
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index cdce0c092c3c..cdadb39a03da 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -250,6 +250,7 @@ struct mptcp_data_frag {
> 	u16 data_len;
> 	u16 offset;
> 	u16 overhead;
> +	u16 sent;
> 	u16 already_sent;
> 	struct page *page;
> };
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
