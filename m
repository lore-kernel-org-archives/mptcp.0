Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A03D7C
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 22:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655763343; x=1687299343;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nRW+H0sv6DDaEJV6Wvhb8lZUYUuEAJDs+j11pSxwYg8=;
  b=hF1cwx/F/ZNxrQlI6JyPcyRmMA2z62jZt0z9gCOECdHZy1j3iojSVnxa
   ZjqO08KsKVOGwsw4QFCt5DlIinEj05QQphB4yXx0dooenFkH1n/QYtLJV
   K7MHX4/aXFhNgYY3z2AXFgI7zNcNwGDa2GhJqvpe+DztkUtx21HiFwmWX
   8IDEJRankkhTzX6fYj0ZQ/tkVFvGBimU71Xeqcf3izf/xo0dWl0paHuqb
   e+bvbNEbEFcwyUqnimTLdQ+zz0X0QNn9kM/i+sPf3yJPm9dFh2xz3G71+
   W8aUMk9SeiMlm8iF/wfs5D4czj7Gb/Rold3TPTA57b4wh5OldqvOVHYXm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="366303112"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="366303112"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 15:15:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="584854338"
Received: from mmachax-mobl.amr.corp.intel.com ([10.212.156.191])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 15:15:42 -0700
Date: Mon, 20 Jun 2022 15:15:42 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v4 6/6] mptcp: fix race on unaccepted mptcp
 sockets
In-Reply-To: <6d0c040baa09ca582d78a0a6afc7bba2308fcd98.1655723410.git.pabeni@redhat.com>
Message-ID: <9f5b9672-edd5-2a5c-2db2-886a053d8b2@linux.intel.com>
References: <cover.1655723410.git.pabeni@redhat.com> <6d0c040baa09ca582d78a0a6afc7bba2308fcd98.1655723410.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 20 Jun 2022, Paolo Abeni wrote:

> When the listener socket owning the relevant request is closed,
> it frees the unaccepted subflows and that causes later deletion
> of the paired MPTCP sockets.
>
> The mptcp socket's worker can run in the time interval between such delete
> operations. When that happens, any access to msk->first will cause an UaF
> access, as the subflow cleanup did not cleared such field in the mptcp
> socket.
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
> v3 -> v4:
> - use correct lockdep annotation when re-acquiring the listener sock lock
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
> index 5c87a269af80..2c953703edf2 100644
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
> +		msk->dl_next = NULL;
> +		unlock_sock_fast(sk, slow);
> +	}
> +	lock_sock(listener_ssk);

Hi Paolo -

I think the nested locking fix didn't make it in to v4 as posted? This 
lock_sock(listener_ssk) line is the one I was mentioning, and the 
lock_sock_fast_nested() a few lines earlier was already in v3.

It's the lock_sock_nested() call in __mptcp_close_ssk() that I was 
suggesting this should match.

Otherwise, the series looks good. Thanks for answering my v3 questions.


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
