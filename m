Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429CDF61
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 21:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2046BC433C7;
	Wed, 12 Jul 2023 21:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689199156;
	bh=7o5GGCUGPf5jy4McYJl4mStMFinrtC1nTzJGhFtH2RY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BpVuHV5yhqQNcYsLEJ1k0W+zB5/lItbIsRQFkIyC5wuhMM017MubY/0hyAFk8is2C
	 n577iJuzZ8dHbXCN0ZuFaCY5we0XWBkAtwC5xCm0w/G9T9XBXhgP1G5bcsnuX2CQkp
	 nt09YG+XnmKmcme8NFzmaNtkNJ9TiIhl5wW5dTzLbz82t5C3J0/1gv9mSYDJRLXtNN
	 gHYbI/AZjHJ/hxNEx7X9Sd35ajkCfnIh0sD72XLolnAaR7qZ/fId/IPCwBssQ1FN0l
	 BzR7dfB7vzP2cFbib+YxdZXHbdJFlti53PUJrTTZ0BvA9mI5MbrLKnrCuifyduoYb+
	 nQ8VHYCEM58rQ==
Date: Wed, 12 Jul 2023 14:59:10 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 14/14] mptcp: get rid of msk->subflow
In-Reply-To: <f994b6d9cf322414f649676bf283326658fc428d.1688993570.git.pabeni@redhat.com>
Message-ID: <e062c54d-acff-d89a-1a99-9c0bc9ab9a3c@kernel.org>
References: <cover.1688993569.git.pabeni@redhat.com> <f994b6d9cf322414f649676bf283326658fc428d.1688993570.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 10 Jul 2023, Paolo Abeni wrote:

> Such field is now unused just as a flag to control the first subflow
> deletion at close() time. Introduce a new bit flag for that and finally
> drop the mentioned field.
>
> As an intended side effect, now the first subflow sock is not freed
> before close() even for passive sockets. The msk has no open/active
> subflows if the first one is closed and the subflow list is singular,
> update accordingly the state check in mptcp_stream_accept().
>
> Among other benefits, the subflow removal, reduces the amount of memory
> used on the client side for each mptcp connection, allows passive sockets
> to go through successful accept()/disconnect()/connect() and makes return
> error code consistent for failing both passive and active sockets.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Side notes:
> - syzkaller will be likely happy about the new code path to possibly
>  exploit
> - we could possibly avoid allocating the 'socket' struct at
>  __mptcp_subflow_connect() time, but that will require more invasive
>  helpers creation in inet core.
> ---
> net/mptcp/protocol.c | 22 +++++-----------------
> net/mptcp/protocol.h | 13 ++++++-------
> 2 files changed, 11 insertions(+), 24 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1c12c7911c43..0518a37e62c7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -91,7 +91,6 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
> 		return err;
>
> 	WRITE_ONCE(msk->first, ssock->sk);
> -	WRITE_ONCE(msk->subflow, ssock);
> 	subflow = mptcp_subflow_ctx(ssock->sk);
> 	list_add(&subflow->node, &msk->conn_list);
> 	sock_hold(ssock->sk);
> @@ -101,6 +100,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
> 	/* This is the first subflow, always with id 0 */
> 	subflow->local_id_valid = 1;
> 	mptcp_sock_graft(msk->first, sk->sk_socket);
> +	iput(SOCK_INODE(ssock));
>
> 	return 0;
> }
> @@ -2263,14 +2263,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
> 	return min_stale_count > 1 ? backup : NULL;
> }
>
> -static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
> -{
> -	if (msk->subflow) {
> -		iput(SOCK_INODE(msk->subflow));
> -		WRITE_ONCE(msk->subflow, NULL);
> -	}
> -}
> -
> bool __mptcp_retransmit_pending_data(struct sock *sk)
> {
> 	struct mptcp_data_frag *cur, *rtx_head;
> @@ -2349,7 +2341,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		goto out_release;
> 	}
>
> -	dispose_it = !msk->subflow || ssk != msk->subflow->sk;
> +	dispose_it = msk->free_first || ssk != msk->first;
> 	if (dispose_it)
> 		list_del(&subflow->node);
>
> @@ -2370,7 +2362,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		 * disconnect should never fail
> 		 */
> 		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
> -		msk->subflow->state = SS_UNCONNECTED;
> 		mptcp_subflow_ctx_reset(subflow);
> 		release_sock(ssk);
>
> @@ -3147,7 +3138,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
> 	msk = mptcp_sk(nsk);
> 	msk->local_key = subflow_req->local_key;
> 	msk->token = subflow_req->token;
> -	WRITE_ONCE(msk->subflow, NULL);
> 	msk->in_accept_queue = 1;
> 	WRITE_ONCE(msk->fully_established, false);
> 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
> @@ -3285,10 +3275,8 @@ static void mptcp_destroy(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
>
> -	/* clears msk->subflow, allowing the following to close
> -	 * even the initial subflow
> -	 */
> -	mptcp_dispose_initial_subflow(msk);
> +	/* allow the following to close even the initial subflow */
> +	msk->free_first = 1;
> 	mptcp_destroy_common(msk, 0);
> 	sk_sockets_allocated_dec(sk);
> }
> @@ -3828,7 +3816,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
> 		    unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
> 			__mptcp_close_ssk(newsk, msk->first,
> 					  mptcp_subflow_ctx(msk->first), 0);
> -			if (unlikely(list_empty(&msk->conn_list)))
> +			if (unlikely(list_is_singular(&msk->conn_list)))

There are other checks for an empty conn_list in the PM code. Do we need a 
new helper to check for "no open/active subflows", if list_empty() is no 
longer the correct thing?

> 				inet_sk_state_store(newsk, TCP_CLOSE);
> 		}
> 	}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index c26587fd7d50..1b4457c44fe8 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -297,7 +297,8 @@ struct mptcp_sock {
> 			cork:1,
> 			nodelay:1,
> 			fastopening:1,
> -			in_accept_queue:1;
> +			in_accept_queue:1,
> +			free_first:1;
> 	struct work_struct work;
> 	struct sk_buff  *ooo_last_skb;
> 	struct rb_root  out_of_order_queue;
> @@ -306,12 +307,10 @@ struct mptcp_sock {
> 	struct list_head rtx_queue;
> 	struct mptcp_data_frag *first_pending;
> 	struct list_head join_list;
> -	struct socket	*subflow; /* outgoing connect/listener/!mp_capable
> -				   * The mptcp ops can safely dereference, using suitable
> -				   * ONCE annotation, the subflow outside the socket
> -				   * lock as such sock is freed after close().
> -				   */
> -	struct sock	*first;
> +	struct sock	*first; /* The mptcp ops can safely dereference, using suitable
> +				 * ONCE annotation, the subflow outside the socket
> +				 * lock as such sock is freed after close().
> +				 */
> 	struct mptcp_pm_data	pm;
> 	struct mptcp_sched_ops	*sched;
> 	struct {
> -- 
> 2.41.0
>
>
>
