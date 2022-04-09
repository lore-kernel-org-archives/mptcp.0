Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C84A43
	for <mptcp@lists.linux.dev>; Sat,  9 Apr 2022 00:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649462642; x=1680998642;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UY8f0NqyUvulCqLMPLzzZePjeb6cT8ObuTP/fBpQu0E=;
  b=Y5sj2u5SAN4+b1J1pgqCuIC9islbJ9LaATsCOPIewjTDvpdh6a7avD1v
   i+3xHIjpFKoFHjxcPBW2pQWYbk6L27LvaxRTyyOB2sYYsmpJNHn3F4RGj
   WO0x45va0/Ng6wL9/cZZ5QfLOaZ2PRqPEVTKuQ966OBnabpfvq2ODYxRz
   LygZFvm8qGpRD9QW56IJ260FxHCQL+rXUORH7tSarmhA4YZKfdcjWi4m6
   xRdVZDESdnplcY104y+oiB7wlm2S/r7pFe/JmIBztvY/dwkRs00HgCVm7
   /reeloyr59Fsv1uv/4sXuOFlo+3PSOLci3LWdIcexIX67OnLGvqJV5Zd+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="348165162"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="348165162"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 17:04:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="643112203"
Received: from kogunron-mobl.amr.corp.intel.com ([10.134.42.75])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 17:04:00 -0700
Date: Fri, 8 Apr 2022 17:03:59 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 5/8] mptcp: add get_subflow wrapper
In-Reply-To: <752c5475b78dc8408b2f0dc6274b35dff0a08710.1649432004.git.geliang.tang@suse.com>
Message-ID: <f975ec8e-d53e-6b29-37fc-2c302e5f9ff@linux.intel.com>
References: <cover.1649432004.git.geliang.tang@suse.com> <752c5475b78dc8408b2f0dc6274b35dff0a08710.1649432004.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 8 Apr 2022, Geliang Tang wrote:

> This patch defines a new wrapper mptcp_sched_get_subflow(), invoke
> get_subflow() of msk->sched in it. Use the wrapper instead of using
> mptcp_subflow_get_send() directly.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 8 ++++----
> net/mptcp/protocol.h | 6 ++++++
> 2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1153bddb92a6..785c428f87ea 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 			int ret = 0;
>
> 			prev_ssk = ssk;
> -			ssk = mptcp_subflow_get_send(msk);
> +			ssk = mptcp_sched_get_subflow(msk, false);
>
> 			/* First check. If the ssk has changed since
> 			 * the last round, release prev_ssk
> @@ -1636,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> 			 * check for a different subflow usage only after
> 			 * spooling the first chunk of data
> 			 */
> -			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
> +			xmit_ssk = first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk), false);
> 			if (!xmit_ssk)
> 				goto out;
> 			if (xmit_ssk != ssk) {
> @@ -2481,7 +2481,7 @@ static void __mptcp_retrans(struct sock *sk)
> 	mptcp_clean_una_wakeup(sk);
>
> 	/* first check ssk: need to kick "stale" logic */
> -	ssk = mptcp_subflow_get_retrans(msk);
> +	ssk = mptcp_sched_get_subflow(msk, true);
> 	dfrag = mptcp_rtx_head(sk);
> 	if (!dfrag) {
> 		if (mptcp_data_fin_enabled(msk)) {
> @@ -3145,7 +3145,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
> 		return;
>
> 	if (!sock_owned_by_user(sk)) {
> -		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
> +		struct sock *xmit_ssk = mptcp_sched_get_subflow(mptcp_sk(sk), false);
>
> 		if (xmit_ssk == ssk)
> 			__mptcp_subflow_push_pending(sk, ssk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 2b3143045f89..a58c5c84e72b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -619,6 +619,12 @@ int mptcp_init_sched(struct mptcp_sock *msk,
> 		     struct mptcp_sched_ops *sched);
> void mptcp_release_sched(struct mptcp_sock *msk);
>
> +static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk, bool retrans)
> +{
> +	return INDIRECT_CALL_INET_1(msk->sched->get_subflow,
> +				    mptcp_get_subflow_default, msk, retrans);
> +}

Thanks, this works for handling retransmission.

I'd still like to get some community input on the "redundant scheduler" 
use case and allowing simultaneous transmission on multiple subflows 
before we merge these changes to the export branch. Since the APIs for BPF 
are userspace-visible, that's important to sort out. The transmit and 
retransmit code would need big enough changes that it might be good to 
discuss and agree on the requirements first.

> +
> static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> {
> 	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
