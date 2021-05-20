Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0677370
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 23:15:00 +0000 (UTC)
IronPort-SDR: N9nZ7jXUsUB13obfd/UPqYuiAPs1nUnH2SH5SD7h4pOxda2rwaafFZe8+9QJOyMMF7qEUBppI6
 TjlrV0fpmV8A==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="265272120"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="265272120"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 16:14:58 -0700
IronPort-SDR: BdG6FvyVwn1PMbICA7K1GSNHeD+I1RDNQ0Y/c7RWYLGpPuRn0lA1xrxuiRPe5oc7XoCGcPH9pP
 tBVv2jREKkaQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395886399"
Received: from srfejes-mobl4.amr.corp.intel.com ([10.209.82.208])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 16:14:58 -0700
Date: Thu, 20 May 2021 16:14:58 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-net] Squash-to: "mptcp: fix sk_forward_memory
 corruption under memory pressure"
In-Reply-To: <03e3ba49f6d847686dced53e915ace73928fd008.1621517601.git.pabeni@redhat.com>
Message-ID: <b0eeeebe-bccf-4a26-6fd1-9021eadd4116@linux.intel.com>
References: <03e3ba49f6d847686dced53e915ace73928fd008.1621517601.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 20 May 2021, Paolo Abeni wrote:

> Commit message to be replaced as follow:
>
> """
> mptcp: fix sk_forward_memory corruption on retransmission
>
> MPTCP sk_forward_memory handling is a bit special, as such field
> is protected by the msk socket spin_lock, instead of the plain
> socket lock.
>
> Currently we have a code path updating such field without handling
> the relevant lock:
>
> __mptcp_retrans() -> __mptcp_clean_una_wakeup()
>
> Several helpers in __mptcp_clean_una_wakeup() will update
> sk_forward_alloc, possibly causing such field corruption, as reported
> by Matthieu.
>
> Address the issue providing and using a new variant of blamed function
> which explicitly acquires the msk spin lock.
> """
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 32 +++++++++++++-------------------
> 1 file changed, 13 insertions(+), 19 deletions(-)

This version of the fix looks good to me, thanks.

-Mat


>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0dcb9b753f80..446acfb85493 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1040,7 +1040,7 @@ static void dfrag_clear(struct sock *sk, struct mptcp_data_frag *dfrag)
> 	put_page(dfrag->page);
> }
>
> -static bool __mptcp_do_clean_una(struct sock *sk)
> +static void __mptcp_clean_una(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct mptcp_data_frag *dtmp, *dfrag;
> @@ -1081,6 +1081,12 @@ static bool __mptcp_do_clean_una(struct sock *sk)
> 	}
>
> out:
> +	if (cleaned) {
> +		if (tcp_under_memory_pressure(sk)) {
> +			__mptcp_update_wmem(sk);
> +			sk_mem_reclaim_partial(sk);
> +		}
> +	}
>
> 	if (snd_una == READ_ONCE(msk->snd_nxt)) {
> 		if (msk->timer_ival && !mptcp_data_fin_enabled(msk))
> @@ -1088,34 +1094,22 @@ static bool __mptcp_do_clean_una(struct sock *sk)
> 	} else {
> 		mptcp_reset_timer(sk);
> 	}
> -	return cleaned;
> -}
> -
> -static void __mptcp_clean_una(struct sock *sk)
> -{
> -	if (__mptcp_do_clean_una(sk) && tcp_under_memory_pressure(sk)) {
> -		__mptcp_update_wmem(sk);
> -		sk_mem_reclaim_partial(sk);
> -	}
> }
>
> static void __mptcp_clean_una_wakeup(struct sock *sk)
> {
> +#ifdef CONFIG_LOCKDEP
> +	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock.slock));
> +#endif
> 	__mptcp_clean_una(sk);
> 	mptcp_write_space(sk);
> }
>
> -/* variant __mptcp_clean_una_wakeup() for caller owning the msk socket lock,
> - * but not the msk_data_lock/msk socket spin lock
> - */
> static void mptcp_clean_una_wakeup(struct sock *sk)
> {
> -#ifdef CONFIG_LOCKDEP
> -	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock));
> -#endif
> -	if (__mptcp_do_clean_una(sk) && tcp_under_memory_pressure(sk))
> -		mptcp_mem_reclaim_partial(sk);
> -	mptcp_write_space(sk);
> +	mptcp_data_lock(sk);
> +	__mptcp_clean_una_wakeup(sk);
> +	mptcp_data_unlock(sk);
> }
>
> static void mptcp_enter_memory_pressure(struct sock *sk)
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
