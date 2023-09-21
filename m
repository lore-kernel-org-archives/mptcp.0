Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399522032D
	for <mptcp@lists.linux.dev>; Thu, 21 Sep 2023 23:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42184C433C8;
	Thu, 21 Sep 2023 23:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695339751;
	bh=3lznet4fUty5b7nrg8B7d0fTcP+VuQoqpmkPgeGIkiM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=A2zMNh6HMqMvUURV5oCqSOWvElSqcQw6RjJYNeQ6W8vV6QIlBRBOj3f3/VWswjeL7
	 SQn5hz+iPpuItCPbJ4r8sY1WAkU6uxKXXeWU+Z52h/bPwWPjGaepi8zDLiqYhwzlxS
	 /uV/9pPnXejQfLzBEJnUbnXaZw1+Z26PmLKSucKvtN+QumBWnZyyo2MRazDj1Ho9G7
	 4iUjH3mnbCRZt2sGE/dgyN6IWgnGurWbQY9FDWNNplfVKr8Vf9LkHUbTzbnFbz4jtP
	 YIIvK6SWoEnafOb3xODKrzjr/wOP96oxVlDVMaPO6P93zuZtihDOdwkADu7iFLJg0Y
	 28uC20nrfYKlg==
Date: Thu, 21 Sep 2023 16:42:25 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
Subject: Re: [PATCH mptcp-next v4 1/4] mptcp: fix delegated action races.
In-Reply-To: <93a4a1fde9b8b8e1a723ae8c2938954af9388eb5.1695200723.git.pabeni@redhat.com>
Message-ID: <c2229739-1a72-e19e-9014-25a6d1055ced@kernel.org>
References: <cover.1695200723.git.pabeni@redhat.com> <93a4a1fde9b8b8e1a723ae8c2938954af9388eb5.1695200723.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 20 Sep 2023, Paolo Abeni wrote:

> The delegated action infrastructure is prone to the following
> race: different CPUs can try to schedule different delegated
> actions on the same subflow at the same time.
>
> Each of them will check different bits via mptcp_subflow_delegate(),
> and will try to schedule the action on the related per-cpu napi
> instance.
>
> Depending on the timing, both can observe an empty delegated list
> node, causing the same entry to be added simultaneously on two different
> lists.
>
> The root cause is that the delegated actions infra does not provide
> a single synchronization point. Address the issue reserving an additional
> bit to mark the subflow as scheduled for delegation. Acquiring such bit
> guarantee the caller to own the delegated list node, and being able to
> safely schedule the subflow.
>
> Clear such bit only when the subflow scheduling is completed, ensuring
> proper barrier in place.
>
> Additionally swap the meaning of the delegated_action bitmask, to allow
> the usage of the existing helper to set multiple bit at once.
>
> Fixes: bcd97734318d ("mptcp: use delegate action to schedule 3rd ack retrans")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 28 ++++++++++++++--------------
> net/mptcp/protocol.h | 35 ++++++++++++-----------------------
> net/mptcp/subflow.c  |  6 ++++--
> 3 files changed, 30 insertions(+), 39 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1a0b463f8c97..04eda1b8f7a4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3425,24 +3425,21 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
> 	sk_reset_timer(ssk, &icsk->icsk_delack_timer, timeout);
> }
>
> -void mptcp_subflow_process_delegated(struct sock *ssk)
> +void mptcp_subflow_process_delegated(struct sock *ssk, long status)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> 	struct sock *sk = subflow->conn;
>
> -	if (test_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status)) {
> +	if (status & BIT(MPTCP_DELEGATE_SEND)) {
> 		mptcp_data_lock(sk);
> 		if (!sock_owned_by_user(sk))
> 			__mptcp_subflow_push_pending(sk, ssk, true);
> 		else
> 			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
> 		mptcp_data_unlock(sk);
> -		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SEND);
> 	}
> -	if (test_bit(MPTCP_DELEGATE_ACK, &subflow->delegated_status)) {
> +	if (status & BIT(MPTCP_DELEGATE_ACK))
> 		schedule_3rdack_retransmission(ssk);
> -		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_ACK);
> -	}
> }
>
> static int mptcp_hash(struct sock *sk)
> @@ -3968,14 +3965,17 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>
> 		bh_lock_sock_nested(ssk);
> -		if (!sock_owned_by_user(ssk) &&
> -		    mptcp_subflow_has_delegated_action(subflow))
> -			mptcp_subflow_process_delegated(ssk);
> -		/* ... elsewhere tcp_release_cb_override already processed
> -		 * the action or will do at next release_sock().
> -		 * In both case must dequeue the subflow here - on the same
> -		 * CPU that scheduled it.
> -		 */
> +		if (!sock_owned_by_user(ssk)) {
> +			mptcp_subflow_process_delegated(ssk, xchg(&subflow->delegated_status, 0));
> +		} else {
> +			/* tcp_release_cb_override already processed
> +			 * the action or will do at next release_sock().
> +			 * In both case must dequeue the subflow here - on the same
> +			 * CPU that scheduled it.
> +			 */
> +			smp_wmb();
> +			clear_bit(MPTCP_DELEGATE_SCHEDULED, &subflow->delegated_status);
> +		}
> 		bh_unlock_sock(ssk);
> 		sock_put(ssk);
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3c938e3560e4..7c7ad087d8ac 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -444,9 +444,11 @@ struct mptcp_delegated_action {
>
> DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
>
> -#define MPTCP_DELEGATE_SEND		0
> -#define MPTCP_DELEGATE_ACK		1
> +#define MPTCP_DELEGATE_SCHEDULED	0
> +#define MPTCP_DELEGATE_SEND		1
> +#define MPTCP_DELEGATE_ACK		2
>
> +#define MPTCP_DELEGATE_ACTIONS_MASK	(~BIT(MPTCP_DELEGATE_SCHEDULED))
> /* MPTCP subflow context */
> struct mptcp_subflow_context {
> 	struct	list_head node;/* conn_list of subflows */
> @@ -564,23 +566,24 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow_context *subflow)
> 	return subflow->map_seq + mptcp_subflow_get_map_offset(subflow);
> }
>
> -void mptcp_subflow_process_delegated(struct sock *ssk);
> +void mptcp_subflow_process_delegated(struct sock *ssk, long actions);
>
> static inline void mptcp_subflow_delegate(struct mptcp_subflow_context *subflow, int action)
> {
> +	long old, mask = BIT(MPTCP_DELEGATE_SCHEDULED) | BIT(action);
> 	struct mptcp_delegated_action *delegated;
> 	bool schedule;
>
> 	/* the caller held the subflow bh socket lock */
> 	lockdep_assert_in_softirq();
>
> -	/* The implied barrier pairs with mptcp_subflow_delegated_done(), and
> -	 * ensures the below list check sees list updates done prior to status
> -	 * bit changes
> +	/* The implied barrier pairs with tcp_release_cb_override()
> +	 * mptcp_napi_poll(), and ensures the below list check sees list
> +	 * updates done prior to delegated status bits changes
> 	 */
> -	if (!test_and_set_bit(action, &subflow->delegated_status)) {
> -		/* still on delegated list from previous scheduling */
> -		if (!list_empty(&subflow->delegated_node))
> +	old = set_mask_bits(&subflow->delegated_status, 0, mask);

Hi Paolo -

The naming of the 'mask' variable here made it a little harder to 
understand at first glance, as the middle arg of the set_mask_bits macro 
is the one that does the masking (clearing) of bits. How about 'set_bits' 
(or similar) instead.

> +	if (!(old & BIT(MPTCP_DELEGATE_SCHEDULED))) {
> +		if (WARN_ON_ONCE(!list_empty(&subflow->delegated_node)))
> 			return;
>
> 		delegated = this_cpu_ptr(&mptcp_delegated_actions);
> @@ -605,20 +608,6 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
> 	return ret;
> }
>
> -static inline bool mptcp_subflow_has_delegated_action(const struct mptcp_subflow_context *subflow)
> -{
> -	return !!READ_ONCE(subflow->delegated_status);
> -}
> -
> -static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *subflow, int action)
> -{
> -	/* pairs with mptcp_subflow_delegate, ensures delegate_node is updated before
> -	 * touching the status bit
> -	 */
> -	smp_wmb();
> -	clear_bit(action, &subflow->delegated_status);
> -}
> -
> int mptcp_is_enabled(const struct net *net);
> unsigned int mptcp_get_add_addr_timeout(const struct net *net);
> int mptcp_is_checksum_enabled(const struct net *net);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 918c1a235790..0d860cb730b4 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1956,9 +1956,11 @@ static void subflow_ulp_clone(const struct request_sock *req,
> static void tcp_release_cb_override(struct sock *ssk)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	long status;
>
> -	if (mptcp_subflow_has_delegated_action(subflow))
> -		mptcp_subflow_process_delegated(ssk);
> +	status = set_mask_bits(&subflow->delegated_status, MPTCP_DELEGATE_ACTIONS_MASK, 0);

Can you add a comment here regarding the interaction with 
mptcp_napi_poll()?

Thanks,

Mat

