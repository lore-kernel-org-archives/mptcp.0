Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58D2FB1
	for <mptcp@lists.linux.dev>; Fri, 28 May 2021 00:56:54 +0000 (UTC)
IronPort-SDR: 6PIKbn+JG21fvDSkp6tWtfWSCk20HWy2RAitVz64RuUkRNvCjzwfkwPkdD2ADROCNWBXmlqFdT
 SyooQE9omq5w==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="224090269"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="224090269"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:56:47 -0700
IronPort-SDR: W0tVXPXIz4hhyqhMRSyc3iuBzd+LjOM6PJtSfE/8s0Dm9gpcZYWnM4AhjvkQ+xA7Fl9Pno/DlW
 eOHDL5107/QA==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="415116891"
Received: from mkronenb-mobl.amr.corp.intel.com ([10.209.5.218])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:56:47 -0700
Date: Thu, 27 May 2021 17:56:46 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: wake-up readers only for in sequence
 data.
In-Reply-To: <5009954210af20796d1cf88ca630d19ec12e2132.1622132690.git.pabeni@redhat.com>
Message-ID: <c69480a9-2470-45c1-bb3c-083f1d1b8ed@linux.intel.com>
References: <5009954210af20796d1cf88ca630d19ec12e2132.1622132690.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Thu, 27 May 2021, Paolo Abeni wrote:

> Currently we relay on the subflow->data_avail field,
                ^^^^^ rely

> which is subject to races:
>
> 	ssk1
> 		skb len = 500 DSS(seq=1, len=1000, off=0)
> 		# data_avail == MPTCP_SUBFLOW_DATA_AVAIL
>
> 	ssk2
> 		skb len = 500 DSS(seq = 501, len=1000)
> 		# data_avail == MPTCP_SUBFLOW_DATA_AVAIL
>
> 	ssk1
> 		skb len = 500 DSS(seq = 1, len=1000, off =500)
> 		# still data_avail == MPTCP_SUBFLOW_DATA_AVAIL,
> 		# as the skb is covered by a pre-existing map,
> 		# which was in-sequence at reception time.
>
> Instead we can explicitly check if some has been received in-sequence,
> propagating the info from __mptcp_move_skbs_from_subflow().
>
> Additionally and the 'ONCE' annotation to the 'data_avail' memory
                ^^^ add (right?)

Fixing this one since it's a little confusing to parse, so figured I'd 
edit above too.

> access, as msk will read it outside the subflow socket lock.
>
> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 29 +++++++++++------------------
> net/mptcp/protocol.h |  1 -
> net/mptcp/subflow.c  | 23 +++++++++--------------
> 3 files changed, 20 insertions(+), 33 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 786f09d83d35..1e77d2defd28 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -681,13 +681,13 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
> /* In most cases we will be able to lock the mptcp socket.  If its already
>  * owned, we need to defer to the work queue to avoid ABBA deadlock.
>  */
> -static void move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
> +static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
> {
> 	struct sock *sk = (struct sock *)msk;
> 	unsigned int moved = 0;
>
> 	if (inet_sk_state_load(sk) == TCP_CLOSE)
> -		return;
> +		return false;
>
> 	mptcp_data_lock(sk);
>
> @@ -702,6 +702,8 @@ static void move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
> 	if (mptcp_pending_data_fin(sk, NULL))
> 		mptcp_schedule_work(sk);
> 	mptcp_data_unlock(sk);
> +
> +	return moved > 0;
> }
>
> void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> @@ -709,7 +711,6 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	int sk_rbuf, ssk_rbuf;
> -	bool wake;
>
> 	/* The peer can send data while we are shutting down this
> 	 * subflow at msk destruction time, but we must avoid enqueuing
> @@ -718,28 +719,20 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> 	if (unlikely(subflow->disposable))
> 		return;
>
> -	/* move_skbs_to_msk below can legitly clear the data_avail flag,
> -	 * but we will need later to properly woke the reader, cache its
> -	 * value
> -	 */
> -	wake = subflow->data_avail == MPTCP_SUBFLOW_DATA_AVAIL;
> -	if (wake)
> -		set_bit(MPTCP_DATA_READY, &msk->flags);
> -
> 	ssk_rbuf = READ_ONCE(ssk->sk_rcvbuf);
> 	sk_rbuf = READ_ONCE(sk->sk_rcvbuf);
> 	if (unlikely(ssk_rbuf > sk_rbuf))
> 		sk_rbuf = ssk_rbuf;
>
> -	/* over limit? can't append more skbs to msk */
> +	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
> 	if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf)
> -		goto wake;
> -
> -	move_skbs_to_msk(msk, ssk);
> +		return;
>
> -wake:
> -	if (wake)
> +	/* Wake-up the reader only for in-sequence data */
> +	if (move_skbs_to_msk(msk, ssk)) {
> +		set_bit(MPTCP_DATA_READY, &msk->flags);
> 		sk->sk_data_ready(sk);
> +	}
> }
>
> static bool mptcp_do_flush_join_list(struct mptcp_sock *msk)
> @@ -871,7 +864,7 @@ static struct sock *mptcp_subflow_recv_lookup(const struct mptcp_sock *msk)
> 	sock_owned_by_me(sk);
>
> 	mptcp_for_each_subflow(msk, subflow) {
> -		if (subflow->data_avail)
> +		if (READ_ONCE(subflow->data_avail))
> 			return mptcp_subflow_tcp_sock(subflow);
> 	}
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 74184296b6af..160c2ab09f19 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -373,7 +373,6 @@ mptcp_subflow_rsk(const struct request_sock *rsk)
> enum mptcp_data_avail {
> 	MPTCP_SUBFLOW_NODATA,
> 	MPTCP_SUBFLOW_DATA_AVAIL,
> -	MPTCP_SUBFLOW_OOO_DATA
> };

Now subflow->data_avail is effectively a bool.

Is it appropriate in -net to change it to a bool (in this patch or make it 
a series)? Or better to save that enum->bool conversion for net-next?

If we keep the enum, it makes sense to explicitly write or compare to 
MPTCP_SUBFLOW_NODATA rather than use 0 or have checks like "if 
(READ_ONCE(subflow->data_avail))", because all of those code lines are 
getting touched anyway.

>
> struct mptcp_delegated_action {
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 726bc3d083fa..783a542e5bb7 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1098,7 +1098,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 	struct sk_buff *skb;
>
> 	if (!skb_peek(&ssk->sk_receive_queue))
> -		subflow->data_avail = 0;
> +		WRITE_ONCE(subflow->data_avail, 0);
> 	if (subflow->data_avail)

Ok, the one line of context immediately above isn't currently changed but 
my enum->bool comment applies to that line too.


These review comments are only about code/commit formatting and wouldn't 
affect the compiled code, so I do want to point out that the functionality 
of the patch looks good to me. Could apply to export and squash some 
updates to get more testing exposure now. Let Matthieu know what you 
prefer.

Mat


> 		return true;
>
> @@ -1137,18 +1137,13 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 		ack_seq = mptcp_subflow_get_mapped_dsn(subflow);
> 		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx", old_ack,
> 			 ack_seq);
> -		if (ack_seq == old_ack) {
> -			subflow->data_avail = MPTCP_SUBFLOW_DATA_AVAIL;
> -			break;
> -		} else if (after64(ack_seq, old_ack)) {
> -			subflow->data_avail = MPTCP_SUBFLOW_OOO_DATA;
> -			break;
> +		if (unlikely(before64(ack_seq, old_ack))) {
> +			mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
> +			continue;
> 		}
>
> -		/* only accept in-sequence mapping. Old values are spurious
> -		 * retransmission
> -		 */
> -		mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
> +		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
> +		break;
> 	}
> 	return true;
>
> @@ -1168,7 +1163,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 		subflow->reset_transient = 0;
> 		subflow->reset_reason = MPTCP_RST_EMPTCP;
> 		tcp_send_active_reset(ssk, GFP_ATOMIC);
> -		subflow->data_avail = 0;
> +		WRITE_ONCE(subflow->data_avail, 0);
> 		return false;
> 	}
>
> @@ -1178,7 +1173,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 	subflow->map_seq = READ_ONCE(msk->ack_seq);
> 	subflow->map_data_len = skb->len;
> 	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
> -	subflow->data_avail = MPTCP_SUBFLOW_DATA_AVAIL;
> +	WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
> 	return true;
> }
>
> @@ -1190,7 +1185,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
> 	if (subflow->map_valid &&
> 	    mptcp_subflow_get_map_offset(subflow) >= subflow->map_data_len) {
> 		subflow->map_valid = 0;
> -		subflow->data_avail = 0;
> +		WRITE_ONCE(subflow->data_avail, 0);
>
> 		pr_debug("Done with mapping: seq=%u data_len=%u",
> 			 subflow->map_subflow_seq,
> -- 
> 2.26.3

--
Mat Martineau
Intel
