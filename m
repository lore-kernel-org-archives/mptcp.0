Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A831E7B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 00:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666743705; x=1698279705;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZLBfY7hEiwFu+KdjARa8wmKd2I/CKdG1g6W85IzCs6Y=;
  b=HsZUtNiVFcRxJYWHp8A5q89szkci9uQq8CyoQFzcVEvaxC9tVhzefSgG
   fwf3yiOmBw+buVy5cdAfNs9F/c9PyB+2T/We9LsTWIn5w1Qblm/9e7gU4
   vstFyoD/pVPXhv6iPOWyQEBzsOEHiaCyw6879BCJSkQW/GM8G6IzihJ+T
   JoVyBD2RKuY0YcYpdAUkE0caBAhL2JU4sMB6PD6fZ8GMcFVYMWfPjM743
   9qDM4ZR39n8YHpqT123EcJ94SJw2XeswV57ZjIH6i6XAnSj8udbFV2zJH
   PTCJVdzSpJZuH8abThchkoRsu+aSY8W1YyafP4izns7Cw7gh7KK1xwGeS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="288220144"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="288220144"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 17:21:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="806857249"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="806857249"
Received: from knnguyen-mobl1.amr.corp.intel.com ([10.209.107.240])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 17:21:43 -0700
Date: Tue, 25 Oct 2022 17:21:42 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v15 03/19] mptcp: move last_snd into
 mptcp_sched_ops
In-Reply-To: <a552af9d09a972538976a1b5ae3159707baa24a8.1666349129.git.geliang.tang@suse.com>
Message-ID: <5cb339d4-afe9-1dfa-4fcb-66a301c1b203@linux.intel.com>
References: <cover.1666349129.git.geliang.tang@suse.com> <a552af9d09a972538976a1b5ae3159707baa24a8.1666349129.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 21 Oct 2022, Geliang Tang wrote:

> Drop the useless msk->last_snd and macro MPTCP_RESET_SCHEDULER. Move
> last_snd from struct mptcp_sock into struct mptcp_sched_ops.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/net/mptcp.h    |  3 +++
> net/mptcp/pm.c         |  9 +--------
> net/mptcp/pm_netlink.c |  3 ---
> net/mptcp/protocol.c   | 13 ++++---------
> net/mptcp/protocol.h   |  2 --
> net/mptcp/sched.c      |  3 +++
> 6 files changed, 11 insertions(+), 22 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 0f386d805957..a45e00bf2f3e 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -110,6 +110,9 @@ struct mptcp_sched_ops {
> 	int (*get_subflow)(const struct mptcp_sock *msk,
> 			   struct mptcp_sched_data *data);
>
> +	/* round-robin scheduler */
> +	struct sock	*last_snd;
> +

Hi Geliang -

There's one mptcp_sched_ops per scheduler, not one per socket. So it 
doesn't work to add per-socket data (like last_snd and snd_burst) to this 
structure.

- Mat


> 	char			name[MPTCP_SCHED_NAME_MAX];
> 	struct module		*owner;
> 	struct list_head	list;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 45e2a48397b9..cdeb7280ac76 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -282,15 +282,8 @@ void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
>
> 	pr_debug("subflow->backup=%d, bkup=%d\n", subflow->backup, bkup);
> 	msk = mptcp_sk(sk);
> -	if (subflow->backup != bkup) {
> +	if (subflow->backup != bkup)
> 		subflow->backup = bkup;
> -		mptcp_data_lock(sk);
> -		if (!sock_owned_by_user(sk))
> -			msk->last_snd = NULL;
> -		else
> -			__set_bit(MPTCP_RESET_SCHEDULER,  &msk->cb_flags);
> -		mptcp_data_unlock(sk);
> -	}
>
> 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, msk, ssk, GFP_ATOMIC);
> }
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 9813ed0fde9b..1f2da4aedcb4 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -475,9 +475,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
>
> 	slow = lock_sock_fast(ssk);
> 	if (prio) {
> -		if (subflow->backup != backup)
> -			msk->last_snd = NULL;
> -
> 		subflow->send_mp_prio = 1;
> 		subflow->backup = backup;
> 		subflow->request_bkup = backup;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 03312e762606..a9d33dea2a8a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1469,16 +1469,13 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>
> 	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
> 	wmem = READ_ONCE(ssk->sk_wmem_queued);
> -	if (!burst) {
> -		msk->last_snd = NULL;
> +	if (!burst)
> 		return ssk;
> -	}
>
> 	subflow = mptcp_subflow_ctx(ssk);
> 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
> 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
> 					   burst + wmem);
> -	msk->last_snd = ssk;
> 	msk->snd_burst = burst;
> 	return ssk;
> }
> @@ -2378,8 +2375,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		msk->first = NULL;
>
> out:
> -	if (ssk == msk->last_snd)
> -		msk->last_snd = NULL;
> +	if (msk->sched && ssk == msk->sched->last_snd)
> +		msk->sched->last_snd = NULL;
>
> 	if (need_push)
> 		__mptcp_push_pending(sk, 0);
> @@ -3013,7 +3010,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
> 	 * subflow
> 	 */
> 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
> -	msk->last_snd = NULL;
> +	msk->sched->last_snd = NULL;
> 	WRITE_ONCE(msk->flags, 0);
> 	msk->cb_flags = 0;
> 	msk->push_pending = 0;
> @@ -3274,8 +3271,6 @@ static void mptcp_release_cb(struct sock *sk)
> 			__mptcp_set_connected(sk);
> 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
> 			__mptcp_error_report(sk);
> -		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
> -			msk->last_snd = NULL;
> 	}
>
> 	__mptcp_update_rmem(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8f48f881adf8..a58fa261f487 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -124,7 +124,6 @@
> #define MPTCP_RETRANSMIT	4
> #define MPTCP_FLUSH_JOIN_LIST	5
> #define MPTCP_CONNECTED		6
> -#define MPTCP_RESET_SCHEDULER	7
>
> static inline bool before64(__u64 seq1, __u64 seq2)
> {
> @@ -258,7 +257,6 @@ struct mptcp_sock {
> 	atomic64_t	rcv_wnd_sent;
> 	u64		rcv_data_fin_seq;
> 	int		rmem_fwd_alloc;
> -	struct sock	*last_snd;
> 	int		snd_burst;
> 	int		old_wspace;
> 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 6324a8a76382..f6c622e15584 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -68,6 +68,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
> 	if (msk->sched->init)
> 		msk->sched->init(msk);
>
> +	msk->sched->last_snd = NULL;
> +
> 	pr_debug("sched=%s", msk->sched->name);
>
> out:
> @@ -81,6 +83,7 @@ void mptcp_release_sched(struct mptcp_sock *msk)
> 	if (!sched)
> 		return;
>
> +	msk->sched->last_snd = NULL;
> 	msk->sched = NULL;
> 	if (sched->release)
> 		sched->release(msk);
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
