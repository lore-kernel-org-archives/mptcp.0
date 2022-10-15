Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C95363
	for <mptcp@lists.linux.dev>; Sat, 15 Oct 2022 00:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665792530; x=1697328530;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PYYj0szIwHgI8fbMJpwt1xC5TxPIxb8NWSHOCjeTCmc=;
  b=jkQK5RvwuQ/jK88VJmIT4s+HxEk70Rz+ht7ccUF4GD65VCbTDwRz7edU
   vQOjitwtYvh/AH6mT20Pj/7YZ5f0NJ+YAS5VsMJmjLrwxgkjArjGBmpM9
   oKe0Pn1A1jF7/LyaOTAm9rehzL8VnipXALcI4abu8UMEuxj7yXFOWA4NY
   68dmbWgMFn6SxqOOQbIsC3gFIV5iNn/ecyDUQrp37KlkhjoPPNnIi5FfC
   SJUqgIq06KZXrgkdGJW+CT9lyRIE/aq4o0Eg8qf8dUUqnJZ90dnAPwJ3c
   oQd2zBwg+mRtBwBDReocaEjaCda/LbOgaLVtbc3SLgH68PdM4QgU8rSUc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="332020152"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="332020152"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 17:08:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="732495046"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="732495046"
Received: from mcunning-mobl1.amr.corp.intel.com ([10.212.193.28])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 17:08:49 -0700
Date: Fri, 14 Oct 2022 17:08:48 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>, Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 05/15] mptcp: drop snd_burst in
 mptcp_sock
In-Reply-To: <d93f71b399dcd3d66562f10ab63d27dbb24580f4.1665753926.git.geliang.tang@suse.com>
Message-ID: <693b0cac-2c3d-1031-7295-5c679fd7b568@linux.intel.com>
References: <cover.1665753926.git.geliang.tang@suse.com> <d93f71b399dcd3d66562f10ab63d27dbb24580f4.1665753926.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 Oct 2022, Geliang Tang wrote:

> Drop snd_burst of struct mptcp_sock, use data->snd_burst instead of
> msk->snd_burst.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 18 ++++++++++--------
> net/mptcp/protocol.h |  1 -
> 2 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c807220277e1..e95a49e5bc89 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1406,7 +1406,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>  * returns the subflow that will transmit the next DSS
>  * additionally updates the rtx timeout
>  */
> -static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> +static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
> +					   struct mptcp_sched_data *data)
> {
> 	struct subflow_send_info send_info[SSK_MODE_MAX];
> 	struct mptcp_subflow_context *subflow;
> @@ -1427,7 +1428,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 	}
>
> 	/* re-use last subflow, if the burst allow that */
> -	if (msk->last_snd && msk->snd_burst > 0 &&
> +	if (msk->last_snd && data->snd_burst > 0 &&
> 	    sk_stream_memory_free(msk->last_snd) &&
> 	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
> 		mptcp_set_timeout(sk);
> @@ -1496,7 +1497,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
> 					   burst + wmem);
> 	msk->last_snd = ssk;
> -	msk->snd_burst = burst;
> +	data->snd_burst = burst;
> 	return ssk;
> }
>
> @@ -1514,8 +1515,6 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
>
> 	dfrag->already_sent += sent;
>
> -	msk->snd_burst -= sent;
> -
> 	snd_nxt_new += dfrag->already_sent;
>
> 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
> @@ -1541,6 +1540,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> {
> 	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_sched_data data = { 0 };

I think moving snd_burst to struct mptcp_sched_data will make the default 
scheduler behave differently. The old location (in msk) would use the 
burst length even across multiple pushes. Clearing snd_burst more 
frequently can cause the scheduler to switch subflows more often when 
multiple subflows are available.

The patch after this (removing last_snd) also contributes to that 
behavior.

Paolo, do you think it's important to use a "burst" across multiple 
mptcp_push_pending() calls, or is it mostly relevant within a single push?


- Mat

> 	struct mptcp_sendmsg_info info = {
> 				.flags = flags,
> 	};
> @@ -1556,7 +1556,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 			int ret = 0;
>
> 			prev_ssk = ssk;
> -			ssk = mptcp_subflow_get_send(msk);
> +			ssk = mptcp_subflow_get_send(msk, &data);
>
> 			/* First check. If the ssk has changed since
> 			 * the last round, release prev_ssk
> @@ -1584,6 +1584,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 			do_check_data_fin = true;
> 			info.sent += ret;
> 			len -= ret;
> +			data.snd_burst -= ret;
>
> 			mptcp_update_post_push(msk, dfrag, ret);
> 		}
> @@ -1605,6 +1606,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_sched_data data = { 0 };
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> @@ -1623,7 +1625,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> 			/* check for a different subflow usage only after
> 			 * spooling the first chunk of data
> 			 */
> -			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
> +			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk, &data);
> 			if (!xmit_ssk)
> 				goto out;
> 			if (xmit_ssk != ssk) {
> @@ -1639,6 +1641,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> 			info.sent += ret;
> 			copied += ret;
> 			len -= ret;
> +			data.snd_burst -= ret;
> 			first = false;
>
> 			mptcp_update_post_push(msk, dfrag, ret);
> @@ -2277,7 +2280,6 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
> 	mptcp_data_unlock(sk);
>
> 	msk->first_pending = rtx_head;
> -	msk->snd_burst = 0;
>
> 	/* be sure to clear the "sent status" on all re-injected fragments */
> 	list_for_each_entry(cur, &msk->rtx_queue, list) {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 270c187c9001..b731e7b37f5a 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -259,7 +259,6 @@ struct mptcp_sock {
> 	u64		rcv_data_fin_seq;
> 	int		rmem_fwd_alloc;
> 	struct sock	*last_snd;
> -	int		snd_burst;
> 	int		old_wspace;
> 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
> 						 * recovery related fields are under data_lock
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
