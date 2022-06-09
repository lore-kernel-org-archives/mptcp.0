Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB0A7C
	for <mptcp@lists.linux.dev>; Thu,  9 Jun 2022 00:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654734672; x=1686270672;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gYU180e/n7OEevu1zTEr+Nl6X4k0DTdz/YBmcZKKZJU=;
  b=CYs24Lqu+ydbWUeKcbCVFZXYTmidlZKZwRC1KnWAhmam+ADstarvKD7s
   zS81RQuVJg9i3oZV2OLBuk57S1foVq77PL7NVuOL3PPxF657NFUA6WKcW
   4Xkgx7hzBbs/IMuNyPuHBJObmWYPezYZNWOdnGSwwu+CQWjj1QR6CjvwX
   Ut4HBcrQj9KaDFST/FbIogUhKivyObnItqMmsy19E6vIiI4ppFr7rDXm5
   GGLn3SMLtBzza0Qbm9iaRLxaIzam7suo62E1TiEYOJP+u0ExGLMqoqhyf
   AL57G8aNeNm5tnlbPGOijOCi583tM6YXbRrmB+ZonC8UuaBu0M+zVJ33Y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="265889594"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="265889594"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 17:31:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="710184847"
Received: from cthurman-mobl.amr.corp.intel.com ([10.209.41.140])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 17:31:00 -0700
Date: Wed, 8 Jun 2022 17:31:00 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v4 2/2] mptcp: trace MP_FAIL subflow in
 mptcp_sock
In-Reply-To: <005b6c1dda2ecb334cc9f6b07053aa59b69b5613.1654732564.git.geliang.tang@suse.com>
Message-ID: <3ebc14e-ae9-a4ea-f0e0-4a9652a38f3d@linux.intel.com>
References: <cover.1654732564.git.geliang.tang@suse.com> <005b6c1dda2ecb334cc9f6b07053aa59b69b5613.1654732564.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 9 Jun 2022, Geliang Tang wrote:

> This patch adds fail_ssk struct member in struct mptcp_sock to record
> the MP_FAIL subsocket. It can replace the mp_fail_response_expect flag
> in struct mptcp_subflow_context.
>
> Drop mp_fail_response_expect_subflow() helper too, just use this fail_ssk
> in mptcp_mp_fail_no_response() to reset the subflow.
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm.c       |  2 +-
> net/mptcp/protocol.c | 35 +++++++++--------------------------
> net/mptcp/protocol.h |  2 +-
> net/mptcp/subflow.c  |  2 +-
> 4 files changed, 12 insertions(+), 29 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 45a9e02abf24..2a57d95d5492 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -305,7 +305,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> 	if (!READ_ONCE(msk->allow_infinite_fallback))
> 		return;
>
> -	if (!READ_ONCE(subflow->mp_fail_response_expect)) {
> +	if (!msk->fail_ssk) {
> 		pr_debug("send MP_FAIL response and infinite map");
>
> 		subflow->send_mp_fail = 1;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 917df5fb9708..58427fabb061 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2167,21 +2167,6 @@ static void mptcp_retransmit_timer(struct timer_list *t)
> 	sock_put(sk);
> }
>
> -static struct mptcp_subflow_context *
> -mp_fail_response_expect_subflow(struct mptcp_sock *msk)
> -{
> -	struct mptcp_subflow_context *subflow, *ret = NULL;
> -
> -	mptcp_for_each_subflow(msk, subflow) {
> -		if (READ_ONCE(subflow->mp_fail_response_expect)) {
> -			ret = subflow;
> -			break;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
> static void mptcp_timeout_timer(struct timer_list *t)
> {
> 	struct sock *sk = from_timer(sk, t, sk_timer);
> @@ -2507,19 +2492,16 @@ static void __mptcp_retrans(struct sock *sk)
>
> static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
> {
> -	struct mptcp_subflow_context *subflow;
> -	struct sock *ssk;
> +	struct sock *ssk = msk->fail_ssk;
> 	bool slow;
>
> -	subflow = mp_fail_response_expect_subflow(msk);
> -	if (subflow) {
> -		pr_debug("MP_FAIL doesn't respond, reset the subflow");
> +	pr_debug("MP_FAIL doesn't respond, reset the subflow");
>
> -		ssk = mptcp_subflow_tcp_sock(subflow);
> -		slow = lock_sock_fast(ssk);
> -		mptcp_subflow_reset(ssk);
> -		unlock_sock_fast(ssk, slow);
> -	}
> +	slow = lock_sock_fast(ssk);
> +	mptcp_subflow_reset(ssk);
> +	unlock_sock_fast(ssk, slow);
> +
> +	msk->fail_ssk = NULL;
> }
>
> static void mptcp_worker(struct work_struct *work)
> @@ -2562,7 +2544,7 @@ static void mptcp_worker(struct work_struct *work)
> 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
> 		__mptcp_retrans(sk);
>
> -	if (time_after(jiffies, msk->fail_tout))

Hi Geliang -

This condition could be unexpectedly true depending on how close 'jiffies' 
is to wrapping around, if msk->fail_tout remains at its default 0 
value...

> +	if (msk->fail_ssk && time_after(jiffies, msk->fail_tout))

...so it's important to fix it like this!

I think the two patches should be re-squashed to avoid introducing the 
issue in the previous commit. Sound good?

Also, I think the change should be for mptcp-net so we can get the fix in 
to 5.19-rcX

Thanks!

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> 		mptcp_mp_fail_no_response(msk);
>
> unlock:
> @@ -2590,6 +2572,7 @@ static int __mptcp_init_sock(struct sock *sk)
> 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
> 	WRITE_ONCE(msk->allow_infinite_fallback, true);
> 	msk->recovery = false;
> +	msk->fail_ssk = NULL;
> 	msk->fail_tout = 0;
>
> 	mptcp_pm_data_init(msk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f7b01275af94..bef7dea9f358 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -306,6 +306,7 @@ struct mptcp_sock {
>
> 	u32 setsockopt_seq;
> 	char		ca_name[TCP_CA_NAME_MAX];
> +	struct sock	*fail_ssk;
> 	unsigned long	fail_tout;
> };
>
> @@ -469,7 +470,6 @@ struct mptcp_subflow_context {
> 		local_id_valid : 1, /* local_id is correctly initialized */
> 		valid_csum_seen : 1;        /* at least one csum validated */
> 	enum mptcp_data_avail data_avail;
> -	bool	mp_fail_response_expect;
> 	bool	scheduled;
> 	u32	remote_nonce;
> 	u64	thmac;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 866d54a0e83c..5351d54e514a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1235,7 +1235,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 				while ((skb = skb_peek(&ssk->sk_receive_queue)))
> 					sk_eat_skb(ssk, skb);
> 			} else {
> -				WRITE_ONCE(subflow->mp_fail_response_expect, true);
> +				msk->fail_ssk = ssk;
> 				msk->fail_tout = jiffies + TCP_RTO_MAX;
> 			}
> 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
