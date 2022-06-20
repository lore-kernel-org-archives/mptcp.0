Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547480E
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 20:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655757527; x=1687293527;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Z9N2l2auTVP5rETJ1cP01V+Q1dGx3R/CasofWphYgIg=;
  b=hOi9Uyy1S3soG0rSuWOKtksUZEQH4yGgHCtO6DLwalD+4ZwEdtD/Hyp6
   OQbGIpOZTc16IE1NsMCt78PHw8DXM8vYsHAf/ALXWa73KpnNr8yDFOFFD
   UX42BxsBA7MFDZO4b9MFe+CEtdUlS4087XIB/nRsO4Cxw9KL1XEwGpZv1
   huPCAM5Htlv6PwCoXakpqcz6XsZbsuvmzfaItDKlbLzomhL/HkP93W8+L
   hHnZC3GkTZf+QZBIDI8zMK4CEZ7IJnGb7Se3ZB8WvDpo/0zDvX0ucm4UC
   uQts0bT6kUmukohjjtEhcPjH/DsV+gsni4MK9iRlyDSo1Fst27K++RuzE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="343964758"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="343964758"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 13:38:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="729527744"
Received: from mmachax-mobl.amr.corp.intel.com ([10.212.156.191])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 13:38:46 -0700
Date: Mon, 20 Jun 2022 13:38:46 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v3 2/3] mptcp: drop SK_RECLAIM_* macros
In-Reply-To: <b7884c6176c0dc56361a5cc365215333b5b81ec2.1655741931.git.pabeni@redhat.com>
Message-ID: <839d9fca-c1e-f557-8d7-12dede91916c@linux.intel.com>
References: <630f7e13d7226f8c37a9cc0c66008a298c1e6b9e.1655741931.git.pabeni@redhat.com> <b7884c6176c0dc56361a5cc365215333b5b81ec2.1655741931.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 20 Jun 2022, Paolo Abeni wrote:

> After commit 4890b686f408 ("net: keep sk->sk_forward_alloc as small as
> possible"), the MPTCP protocol is the last SK_RECLAIM_CHUNK and
> SK_RECLAIM_THRESHOLD users.
>
> Update the MPTCP reclaim schema to match the core/TCP one and drop the
> mentioned macros. This additionally clean the MPTCP code a bit.
>

Please also add one more patch to the series that deletes SK_RECLAIM_* 
from include/net/sock.h

- Mat

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 35 ++---------------------------------
> 1 file changed, 2 insertions(+), 33 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0d4b2c010da0..b31bac33f87a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -181,8 +181,8 @@ static void mptcp_rmem_uncharge(struct sock *sk, int size)
> 	reclaimable = msk->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
>
> 	/* see sk_mem_uncharge() for the rationale behind the following schema */
> -	if (unlikely(reclaimable >= SK_RECLAIM_THRESHOLD))
> -		__mptcp_rmem_reclaim(sk, SK_RECLAIM_CHUNK);
> +	if (unlikely(reclaimable >= PAGE_SIZE))
> +		__mptcp_rmem_reclaim(sk, reclaimable);
> }
>
> static void mptcp_rfree(struct sk_buff *skb)
> @@ -961,25 +961,6 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
> 		df->data_seq + df->data_len == msk->write_seq;
> }
>
> -static void __mptcp_mem_reclaim_partial(struct sock *sk)
> -{
> -	int reclaimable = mptcp_sk(sk)->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
> -
> -	lockdep_assert_held_once(&sk->sk_lock.slock);
> -
> -	if (reclaimable > (int)PAGE_SIZE)
> -		__mptcp_rmem_reclaim(sk, reclaimable - 1);
> -
> -	sk_mem_reclaim(sk);
> -}
> -
> -static void mptcp_mem_reclaim_partial(struct sock *sk)
> -{
> -	mptcp_data_lock(sk);
> -	__mptcp_mem_reclaim_partial(sk);
> -	mptcp_data_unlock(sk);
> -}
> -
> static void dfrag_uncharge(struct sock *sk, int len)
> {
> 	sk_mem_uncharge(sk, len);
> @@ -999,7 +980,6 @@ static void __mptcp_clean_una(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct mptcp_data_frag *dtmp, *dfrag;
> -	bool cleaned = false;
> 	u64 snd_una;
>
> 	/* on fallback we just need to ignore snd_una, as this is really
> @@ -1022,7 +1002,6 @@ static void __mptcp_clean_una(struct sock *sk)
> 		}
>
> 		dfrag_clear(sk, dfrag);
> -		cleaned = true;
> 	}
>
> 	dfrag = mptcp_rtx_head(sk);
> @@ -1044,7 +1023,6 @@ static void __mptcp_clean_una(struct sock *sk)
> 		dfrag->already_sent -= delta;
>
> 		dfrag_uncharge(sk, delta);
> -		cleaned = true;
> 	}
>
> 	/* all retransmitted data acked, recovery completed */
> @@ -1052,9 +1030,6 @@ static void __mptcp_clean_una(struct sock *sk)
> 		msk->recovery = false;
>
> out:
> -	if (cleaned && tcp_under_memory_pressure(sk))
> -		__mptcp_mem_reclaim_partial(sk);
> -
> 	if (snd_una == READ_ONCE(msk->snd_nxt) &&
> 	    snd_una == READ_ONCE(msk->write_seq)) {
> 		if (mptcp_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
> @@ -1206,12 +1181,6 @@ static struct sk_buff *mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, boo
> {
> 	gfp_t gfp = data_lock_held ? GFP_ATOMIC : sk->sk_allocation;
>
> -	if (unlikely(tcp_under_memory_pressure(sk))) {
> -		if (data_lock_held)
> -			__mptcp_mem_reclaim_partial(sk);
> -		else
> -			mptcp_mem_reclaim_partial(sk);
> -	}
> 	return __mptcp_alloc_tx_skb(sk, ssk, gfp);
> }
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
