Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958FA15A2
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 00:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652228330; x=1683764330;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4v6yldjYXd7Az8B1xwoauLweUPHr21nDPQ1dCEU9LEQ=;
  b=Ni307aCLhCm+/9DO90nkSvqaRybdhXiEZeqnBY17yJMd3SdzOACq2Ev4
   xBo6RaGVrAPvVhP1Er5YNijTDg9425wCiXgC5qdixbvl+Vp3p3HY7usK9
   5GgQhUQgbOl58fssQ6B9Vsxe/qlLvnnFGJsESxyI2sqAnVld3bpcL7Xv7
   /CYZ5YRJccF/HpokomgF9klEa8dndqumAPTmESX62BfZuGCOePZqUiWqx
   92znEbxSGaffuLDIq452cKDHe8elqtDmSHIwCWnkcjOtRckZCRVnnCsQl
   6nMnuuOQhlFBsO5rMrLMj+qmXnz5/cAYKtaIi6jdbjFSEFUPKBenpnS9C
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="251587286"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="251587286"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:18:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="520269528"
Received: from yperng-mobl1.amr.corp.intel.com ([10.209.50.90])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:18:50 -0700
Date: Tue, 10 May 2022 17:18:49 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next 1/4] Squash to "mptcp: add get_subflow
 wrappers"
In-Reply-To: <769fd51201f15cdc6c582e9b14661445143fdf25.1652108279.git.geliang.tang@suse.com>
Message-ID: <d9a2fc1a-129c-f37-560-f23cd32dc8e8@linux.intel.com>
References: <cover.1652108279.git.geliang.tang@suse.com> <769fd51201f15cdc6c582e9b14661445143fdf25.1652108279.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 9 May 2022, Geliang Tang wrote:

> Add call_again parameter for mptcp_sched_get_send() and
> mptcp_sched_get_retrans().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 13 +++++++++----
> net/mptcp/protocol.h |  4 ++--
> net/mptcp/sched.c    | 10 ++++++++--
> 3 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3c55e7f45aef..4a55a6e89ed5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1558,6 +1558,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 	};
> 	struct mptcp_data_frag *dfrag;
> 	int len, copied = 0;
> +	bool call_again;
>
> 	while ((dfrag = mptcp_send_head(sk))) {
> 		info.sent = dfrag->already_sent;
> @@ -1567,7 +1568,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 			int ret = 0;
>
> 			prev_ssk = ssk;
> -			ssk = mptcp_sched_get_send(msk);
> +			ssk = mptcp_sched_get_send(msk, &call_again);

One thing to check everywhere call_again is used: we need to make sure the 
BPF code can't set call_again = true every time it returns, which would 
get this code stuck in an infinite loop. Could limit it to 
MPTCP_SUBFLOWS_MAX? The BPF verifier would not help with this because the 
BPF code is repeatedly called.

It's also not good if the scheduler returns the same subflow multiple 
times for the same fragment!

These problems (and my comments on the next patch) make me question 
whether the "call_again" design is the right way to go. For example, the 
BPF scheduler could be called once and return a bitmap of which subflows 
to send on, then a flag could be set in each subflow context that is 
"scheduled" for sending. The send loops (whether in __mptcp_push_pending() 
or the subflow delegate chain) could then check the subflow flags to 
figure out which ones to send on. What do you think?



- Mat

>
> 			/* First check. If the ssk has changed since
> 			 * the last round, release prev_ssk
> @@ -1621,6 +1622,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> 	struct sock *xmit_ssk;
> 	int len, copied = 0;
> 	bool first = true;
> +	bool call_again;
>
> 	info.flags = 0;
> 	while ((dfrag = mptcp_send_head(sk))) {
> @@ -1634,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> 			 * check for a different subflow usage only after
> 			 * spooling the first chunk of data
> 			 */
> -			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
> +			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk), &call_again);
> 			if (!xmit_ssk)
> 				goto out;
> 			if (xmit_ssk != ssk) {
> @@ -2461,12 +2463,13 @@ static void __mptcp_retrans(struct sock *sk)
> 	struct mptcp_data_frag *dfrag;
> 	size_t copied = 0;
> 	struct sock *ssk;
> +	bool call_again;
> 	int ret;
>
> 	mptcp_clean_una_wakeup(sk);
>
> 	/* first check ssk: need to kick "stale" logic */
> -	ssk = mptcp_sched_get_retrans(msk);
> +	ssk = mptcp_sched_get_retrans(msk, &call_again);
> 	dfrag = mptcp_rtx_head(sk);
> 	if (!dfrag) {
> 		if (mptcp_data_fin_enabled(msk)) {
> @@ -3117,11 +3120,13 @@ void __mptcp_data_acked(struct sock *sk)
>
> void __mptcp_check_push(struct sock *sk, struct sock *ssk)
> {
> +	bool call_again;
> +
> 	if (!mptcp_send_head(sk))
> 		return;
>
> 	if (!sock_owned_by_user(sk)) {
> -		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
> +		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk), &call_again);
>
> 		if (xmit_ssk == ssk)
> 			__mptcp_subflow_push_pending(sk, ssk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 59a23838782f..2fe0021a678e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -631,8 +631,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
> void mptcp_release_sched(struct mptcp_sock *msk);
> struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
> struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
> -struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
> -struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
> +struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, bool *call_again);
> +struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk, bool *call_again);
>
> static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> {
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 9ee2d30a6f19..83377cd1a4de 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -111,12 +111,14 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk,
> 	return 0;
> }
>
> -struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> +struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, bool *call_again)
> {
> 	struct mptcp_sched_data data;
>
> 	sock_owned_by_me((struct sock *)msk);
>
> +	*call_again = 0;
> +
> 	/* the following check is moved out of mptcp_subflow_get_send */
> 	if (__mptcp_check_fallback(msk)) {
> 		if (!msk->first)
> @@ -131,15 +133,18 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> 	msk->sched->get_subflow(msk, false, &data);
>
> 	msk->last_snd = data.sock;
> +	*call_again = data.call_again;
> 	return data.sock;
> }
>
> -struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
> +struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk, bool *call_again)
> {
> 	struct mptcp_sched_data data;
>
> 	sock_owned_by_me((const struct sock *)msk);
>
> +	*call_again = 0;
> +
> 	/* the following check is moved out of mptcp_subflow_get_retrans */
> 	if (__mptcp_check_fallback(msk))
> 		return NULL;
> @@ -151,5 +156,6 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
> 	msk->sched->get_subflow(msk, true, &data);
>
> 	msk->last_snd = data.sock;
> +	*call_again = data.call_again;
> 	return data.sock;
> }
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
