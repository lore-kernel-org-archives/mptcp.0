Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03059168
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 00:44:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="196798964"
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="196798964"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 17:44:29 -0700
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="564733259"
Received: from pkadam-mobl1.amr.corp.intel.com ([10.212.141.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 17:44:29 -0700
Date: Thu, 8 Jul 2021 17:44:29 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, fwestpha@redhat.com
Subject: Re: [PATCH mptcp-next 3/7] mptcp: handle pending data on closed
 subflow
In-Reply-To: <081be14b501647e52b6fc0647ef6b46738dde78a.1624895054.git.pabeni@redhat.com>
Message-ID: <182956c1-3342-8e83-fcfc-2f1881702ce0@linux.intel.com>
References: <cover.1624895054.git.pabeni@redhat.com> <081be14b501647e52b6fc0647ef6b46738dde78a.1624895054.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 28 Jun 2021, Paolo Abeni wrote:

> The PM can close active subflow, e.g. due to ingress RM_ADDR
> option. Such subflow could carry data still unacked at the
> MPTCP-level, both in the write and the rtx_queue, which has
> never reached the other peer.
>
> Currently the mptcp-level retransmission will deliver such data,
> but at a very low rate (at most 1 DSM for each MPTCP rtx interval).
>
> We can speed-up the recovery a lot, moving all the unacked in the
> tcp write_queue, so that it will be pushed again via other
> subflows, at the speed allowed by them.
>
> Also make available the new helper for later patches.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/207
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/options.c  |  9 ++++++---
> net/mptcp/protocol.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.h |  3 +++
> 3 files changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index b5850afea343..c82ad34a0abc 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -975,9 +975,12 @@ static void ack_update_msk(struct mptcp_sock *msk,
> 	old_snd_una = msk->snd_una;
> 	new_snd_una = mptcp_expand_seq(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
>
> -	/* ACK for data not even sent yet? Ignore. */
> -	if (after64(new_snd_una, snd_nxt))
> -		new_snd_una = old_snd_una;
> +	/* ACK for data not even sent yet and even above recovery bound? Ignore.*/
> +	if (unlikely(after64(new_snd_una, snd_nxt))) {
> +		if (!READ_ONCE(msk->recovery) ||
> +		    after64(new_snd_una, READ_ONCE(msk->recovery_snd_nxt)))
> +			new_snd_una = old_snd_una;
> +	}
>
> 	new_wnd_end = new_snd_una + tcp_sk(ssk)->snd_wnd;
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 51f608831fae..b0a7eba202fc 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1032,6 +1032,9 @@ static void __mptcp_clean_una(struct sock *sk)
> 	if (__mptcp_check_fallback(msk))
> 		msk->snd_una = READ_ONCE(msk->snd_nxt);
>
> +	if (unlikely(msk->recovery) && after64(msk->snd_una, msk->recovery_snd_nxt))
> +		WRITE_ONCE(msk->recovery, false);
> +
> 	snd_una = msk->snd_una;
> 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
> 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
> @@ -2135,6 +2138,45 @@ static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
> 	}
> }
>
> +bool __mptcp_retransmit_pending_data(struct sock *sk, const struct sock *ssk)

One small thing: ssk is unused.

> +{
> +	struct mptcp_data_frag *cur, *rtx_head;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
> +	if (__mptcp_check_fallback(mptcp_sk(sk)))
> +		return false;
> +
> +	if (tcp_rtx_and_write_queues_empty(sk))
> +		return false;
> +
> +	/* the closing socket has some data untransmitted and/or unacked:
> +	 * some data in the mptcp rtx queue has not really xmitted yet.
> +	 * keep it simple and re-inject the whole mptcp level rtx queue
> +	 */
> +	mptcp_clean_una_wakeup(sk);
> +	rtx_head = mptcp_rtx_head(sk);
> +	if (!rtx_head)
> +		return false;
> +
> +	/* will accept ack for reijected data before re-sending them */
> +	if (!msk->recovery || after64(msk->snd_nxt, msk->recovery_snd_nxt))
> +		WRITE_ONCE(msk->recovery_snd_nxt, msk->snd_nxt);
> +	WRITE_ONCE(msk->recovery, true);
> +
> +	msk->first_pending = rtx_head;
> +	msk->tx_pending_data += msk->snd_nxt - rtx_head->data_seq;
> +	msk->snd_nxt = rtx_head->data_seq;
> +	msk->snd_burst = 0;
> +
> +	/* be sure to clear the "sent status" on all re-injected fragments */
> +	list_for_each_entry(cur, &msk->rtx_queue, list) {
> +		if (!cur->already_sent)
> +			break;
> +		cur->already_sent = 0;
> +	}
> +	return true;
> +}
> +

--
Mat Martineau
Intel
