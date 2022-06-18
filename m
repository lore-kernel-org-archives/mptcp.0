Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E177B
	for <mptcp@lists.linux.dev>; Sat, 18 Jun 2022 00:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655513487; x=1687049487;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2OgOLvu6QFYU/AcV3pEGwyD2ANNzpB8LdmPoJcz7jrU=;
  b=Al4q+lEWewypdVE4Jeo2xmIumOABxLx9FJY3yC6rfIXH0TfdioiIHurC
   l4w6/4Ut+2q8SfzjiniicEIB8f6wADQmFxEte0R9GJFuD0lWrxx2Wq4Ik
   0aYBG/pdefDQPMNwLlRIPdCeaLW2LB9i5ANvKBy1NviZMBWrEz9DrI/qJ
   xhcNKFofGQcydVQnx5XMBLG7rQiKlznVY7Qkw4X0OEEavdQQ9O7Dnj0s1
   6PUILMuLbacbLjOdnpkR1QsHPJh8W+SdqNHl5vi+FF0KSRLkbdNIgfE5O
   nzyOX54QMmaXNkrSpKp6UADviAfJhcXLxK58nmy78StLYrCqqzPcF4Z0s
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280348679"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280348679"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 17:51:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="763441662"
Received: from theiders-mobl.amr.corp.intel.com ([10.209.81.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 17:51:26 -0700
Date: Fri, 17 Jun 2022 17:51:26 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v3 6/6] mptcp: fix race on unaccepted mptcp
 sockets
In-Reply-To: <dd32766a57e98209da3257e9c68980a3b8727797.1655460262.git.pabeni@redhat.com>
Message-ID: <cae3fd3-d3f9-c57-8fe8-12c6a215e9fa@linux.intel.com>
References: <cover.1655460262.git.pabeni@redhat.com> <dd32766a57e98209da3257e9c68980a3b8727797.1655460262.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 17 Jun 2022, Paolo Abeni wrote:

> When the listener socket owning the relevant request is closed,
> it frees the unaccepted subflows and that causes later deletion
> of the paired MPTCP sockets.
>
> The mptcp socket's worker can run in the time interval between such delete
> operations. When that happens, any access to msk->first will cause an UaF
> access, as the subflow cleanup did not cleared such field in the mptcp
> socket.

Did you run in to this UaF in a self test? Was it possible before this 
patch series?

>
> Address the issue explictly traversing the listener socket accept
> queue at close time and performing the needed cleanup on the pending
> msk.
>
> Note that the locking is a bit tricky, as we need to acquire the msk
> socket lock, while still owning the subflow socket one.
>
> Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c |  5 +++++
> net/mptcp/protocol.h |  2 ++
> net/mptcp/subflow.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 57 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 00ba9c44933a..6d2aa41390e7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2318,6 +2318,11 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		kfree_rcu(subflow, rcu);
> 	} else {
> 		/* otherwise tcp will dispose of the ssk and subflow ctx */
> +		if (ssk->sk_state == TCP_LISTEN) {
> +			tcp_set_state(ssk, TCP_CLOSE);
> +			mptcp_subflow_queue_clean(ssk);
> +			inet_csk_listen_stop(ssk);
> +		}
> 		__tcp_close(ssk, 0);
>
> 		/* close acquired an extra ref */
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index ad9b02b1b3e6..95c9ace1437b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -306,6 +306,7 @@ struct mptcp_sock {
>
> 	u32 setsockopt_seq;
> 	char		ca_name[TCP_CA_NAME_MAX];
> +	struct mptcp_sock	*dl_next;
> };
>
> #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
> @@ -610,6 +611,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		     struct mptcp_subflow_context *subflow);
> void mptcp_subflow_send_ack(struct sock *ssk);
> void mptcp_subflow_reset(struct sock *ssk);
> +void mptcp_subflow_queue_clean(struct sock *ssk);
> void mptcp_sock_graft(struct sock *sk, struct socket *parent);
> struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 1e182301e58b..db83db1b3c4c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1723,6 +1723,56 @@ static void subflow_state_change(struct sock *sk)
> 	}
> }
>
> +void mptcp_subflow_queue_clean(struct sock *listener_ssk)
> +{
> +	struct request_sock_queue *queue = &inet_csk(listener_ssk)->icsk_accept_queue;
> +	struct mptcp_sock *msk, *next, *head = NULL;
> +	struct request_sock *req;
> +
> +	/* build a list of all unaccepted mptcp sockets */
> +	spin_lock_bh(&queue->rskq_lock);
> +	for (req = queue->rskq_accept_head; req; req = req->dl_next) {
> +		struct mptcp_subflow_context *subflow;
> +		struct sock *ssk = req->sk;
> +		struct mptcp_sock *msk;
> +
> +		if (!sk_is_mptcp(ssk))
> +			continue;
> +
> +		subflow = mptcp_subflow_ctx(ssk);
> +		if (!subflow || !subflow->conn)
> +			continue;
> +
> +		/* skip if already in list */
> +		msk = mptcp_sk(subflow->conn);
> +		if (msk->dl_next || msk == head)
> +			continue;
> +
> +		msk->dl_next = head;

Why is it ok to read/modify msk->dl_next without the msk locked here, but 
the msk lock is needed below?


Are the only msks in this queue created by incoming MP_CAPABLE SYNs? Or 
could MP_JOIN subflow request socks be involved too, which would have 
msk->first pointers to completely different listener ssks?


> +		head = msk;
> +	}
> +	spin_unlock_bh(&queue->rskq_lock);
> +	if (!head)
> +		return;
> +
> +	/* can't acquire the msk socket lock under the subflow one,
> +	 * or will cause ABBA deadlock
> +	 */
> +	release_sock(listener_ssk);
> +
> +	for (msk = head; msk; msk = next) {
> +		struct sock *sk = (struct sock *)msk;
> +		bool slow;
> +
> +		slow = lock_sock_fast_nested(sk);
> +		next = msk->dl_next;
> +		msk->first = NULL;

Related to my question above, does it make sense to check that msk->first 
== listener_ssk before setting to NULL?


> +		msk->dl_next = NULL;
> +		unlock_sock_fast(sk, slow);
> +	}
> +	lock_sock(listener_ssk);

The lock being re-acquired here was locked by the caller using:

lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);


Should that notation be used here too?

> +}
> +
> static int subflow_ulp_init(struct sock *sk)
> {
> 	struct inet_connection_sock *icsk = inet_csk(sk);
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
