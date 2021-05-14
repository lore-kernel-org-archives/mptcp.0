Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FB71
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 21:44:09 +0000 (UTC)
IronPort-SDR: eBYVx9g3jV8RTqMdx+YouQq9QrRfRDo75Y8lwa0X5LRYnkRmOtlJT3BiCqYzqF2FjbzCUH4ZvM
 mM1tutQ9MQCw==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="221256437"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="221256437"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 14:44:08 -0700
IronPort-SDR: oveyQ9BAdwb/m3GRBGicapXKAiROu9eghDZGdMazNoNrwEXWsRSr9fLDOqmfgYUzIiz42ShsSP
 1TzDIs/1hANQ==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="457940620"
Received: from akshtadu-mobl.amr.corp.intel.com ([10.251.18.116])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 14:44:08 -0700
Date: Fri, 14 May 2021 14:44:07 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net] mptcp: fix sk_forward_memory corruption under
 memory pressure
In-Reply-To: <b84d11a2f4c33e69637567e64138a453611064dc.1620986525.git.pabeni@redhat.com>
Message-ID: <c8818a1d-c0f7-935a-8f6f-e7573e3c0bd@linux.intel.com>
References: <b84d11a2f4c33e69637567e64138a453611064dc.1620986525.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 14 May 2021, Paolo Abeni wrote:

> MPTCP sk_forward_memory handling is a bit special, as such field
> is protected by the msk socket spin_lock, instead of the plain
> socket lock.
>
> Currently we have a code path updating such field without handling
> the relevant lock:
>
> __mptcp_retrans() -> __mptcp_clean_una_wakeup() -> __mptcp_update_wmem()
>
> We can hit the above only under memory pressure. When that happen,
> forward memory accounting could be corrupted, as reported by Mat.
>

Me? :)

> Address the issue creating a new variant of __mptcp_clean_una_wakeup()
> which handle fwd memory updates with the proper care and invoking
> such new helper in the relevant code path.
>
> Reported-by: 'Matthieu Baerts <matthieu.baerts@tessares.net>'
> Fixes: 64b9cea7a0af ("mptcp: fix spurious retransmissions")

and
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/172

correct?

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 36 ++++++++++++++++++++++++++++--------
> 1 file changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2d21a4793d9d..1d5d451e9211 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -947,6 +947,10 @@ static void __mptcp_update_wmem(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
>
> +#ifdef CONFIG_LOCKDEP
> +	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock.slock));
> +#endif
> +
> 	if (!msk->wmem_reserved)
> 		return;
>
> @@ -1027,7 +1031,7 @@ static void dfrag_clear(struct sock *sk, struct mptcp_data_frag *dfrag)
> 	put_page(dfrag->page);
> }
>
> -static void __mptcp_clean_una(struct sock *sk)
> +static bool __mptcp_do_clean_una(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct mptcp_data_frag *dtmp, *dfrag;
> @@ -1068,12 +1072,6 @@ static void __mptcp_clean_una(struct sock *sk)
> 	}
>
> out:
> -	if (cleaned) {
> -		if (tcp_under_memory_pressure(sk)) {
> -			__mptcp_update_wmem(sk);
> -			sk_mem_reclaim_partial(sk);
> -		}
> -	}
>
> 	if (snd_una == READ_ONCE(msk->snd_nxt)) {
> 		if (msk->timer_ival && !mptcp_data_fin_enabled(msk))
> @@ -1081,6 +1079,15 @@ static void __mptcp_clean_una(struct sock *sk)
> 	} else {
> 		mptcp_reset_timer(sk);
> 	}
> +	return cleaned;
> +}
> +
> +static void __mptcp_clean_una(struct sock *sk)
> +{
> +	if (__mptcp_do_clean_una(sk) && tcp_under_memory_pressure(sk)) {
> +		__mptcp_update_wmem(sk);
> +		sk_mem_reclaim_partial(sk);
> +	}
> }
>
> static void __mptcp_clean_una_wakeup(struct sock *sk)
> @@ -1089,6 +1096,19 @@ static void __mptcp_clean_una_wakeup(struct sock *sk)
> 	mptcp_write_space(sk);
> }
>
> +/* variant __mptcp_clean_una_wakeup() for caller owning the msk socket lock,
> + * but not the msk_data_lock/msk socket spin lock
> + */
> +static void mptcp_clean_una_wakeup(struct sock *sk)
> +{
> +#ifdef CONFIG_LOCKDEP
> +	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock));
> +#endif
> +	if (__mptcp_do_clean_una(sk) && tcp_under_memory_pressure(sk))
> +		mptcp_mem_reclaim_partial(sk);
> +	mptcp_write_space(sk);
> +}
> +
> static void mptcp_enter_memory_pressure(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow;
> @@ -2299,7 +2319,7 @@ static void __mptcp_retrans(struct sock *sk)
> 	struct sock *ssk;
> 	int ret;
>
> -	__mptcp_clean_una_wakeup(sk);
> +	mptcp_clean_una_wakeup(sk);
> 	dfrag = mptcp_rtx_head(sk);
> 	if (!dfrag) {
> 		if (mptcp_data_fin_enabled(msk)) {
> -- 
> 2.26.3

Looks good to me. Thanks Paolo.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
