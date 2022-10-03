Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F38F44
	for <mptcp@lists.linux.dev>; Mon,  3 Oct 2022 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664836218; x=1696372218;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XZ/LQupl1qTCiHujjnx4RvFkfeP8GYJ/EunMR6pjb3k=;
  b=Sh2s1yDT6iqnC3aqBKxREcLUs0diD4UC9nEqBZ7/zoQMh3oQOdAuBOXD
   1hWHHhCyzf6vBD6h7UHyHm1QODZP/YQYnV3wAU4kFAC4MFyX2zk8i6YWk
   9R+Oq6cZooV4zFx4AIRbKLsoA56FrF20DWHHE8RfzkTfR2yIiC3vhf3ia
   1L5+Yr0G2/T2IBusel6esEPwwY/jDe+/BmaA0yxFKnkOvWvGGzazHs8d4
   mKDy1ISK/x8LfFhwI3O3XJeufI4TLoW7wy9+tm0iVv8AGtSgBCHZvpK7r
   k7TaCnqrXPvWJj/SUiL5odkh+NaNgNy6KPuRb805dTM9jk7z169kx8DfY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="329175878"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="329175878"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:30:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="868786114"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="868786114"
Received: from wyeh-mobl.amr.corp.intel.com ([10.209.18.252])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:30:17 -0700
Date: Mon, 3 Oct 2022 15:30:17 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Dmytro Shytyi <dmytro@shytyi.net>
Subject: Re: [PATCH mptcp-next] mptcp: factor out mptcp_connect()
In-Reply-To: <ddbb4cae497ea3df00bb82b238fdef63b8924fad.1664812609.git.pabeni@redhat.com>
Message-ID: <8ac60988-ce35-f411-082b-06732bd7f3c2@linux.intel.com>
References: <ddbb4cae497ea3df00bb82b238fdef63b8924fad.1664812609.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 3 Oct 2022, Paolo Abeni wrote:

> The current MPTCP connect implementation duplicates a bit of inet
> code and does not use nor provide a struct proto->connect callback,
> which in turn will not fit the upcoming fastopen implementation.
>
> Refactor such implementation to use the common helper, moving the
> MPTCP-specific bits into mptcp_connect(). Additionally, avoid an
> indirect call to the subflow connect callback.
>
> Note that the fastopen call-path invokes mptcp_connect() while already
> holding the subflow socket lock. Explicitly keep track of such path
> via a new MPTCP-level flag and handle the locking accordingly.
>
> Additionally, track the connect flags in a new msk field to allow
> propagating them to the subflow inet_stream_connect call.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 128 +++++++++++++++++++++----------------------
> net/mptcp/protocol.h |   4 +-
> 2 files changed, 65 insertions(+), 67 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8feb684408f7..6245248d0182 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1689,7 +1689,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>
> 		lock_sock(ssk);
>
> +		msk->connect_flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
> +		msk->is_sendmsg = 1;
> 		ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
> +		msk->is_sendmsg = 0;

I'm not excited about passing the flags this way (new msk members), but it 
seems better than changing the parameters of (struct proto_ops)->connect 
(and every connect function it's used with). So, I'm ok with the above 
change.

> 		copied += copied_syn;
> 		if (ret == -EINPROGRESS && copied_syn > 0) {
> 			/* reflect the new state on the MPTCP socket */
> @@ -3506,10 +3509,65 @@ static int mptcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
> 	return put_user(answ, (int __user *)arg);
> }
>
> +static void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
> +					 struct mptcp_subflow_context *subflow)
> +{
> +	subflow->request_mptcp = 0;
> +	__mptcp_do_fallback(msk);
> +}
> +
> +static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct socket *ssock;
> +	int err = -EINVAL;
> +
> +	ssock = __mptcp_nmpc_socket(msk);
> +	if (!ssock)
> +		return -EINVAL;
> +
> +	mptcp_token_destroy(msk);
> +	inet_sk_state_store(sk, TCP_SYN_SENT);
> +	subflow = mptcp_subflow_ctx(ssock->sk);
> +#ifdef CONFIG_TCP_MD5SIG
> +	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
> +	 * TCP option space.
> +	 */
> +	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
> +		mptcp_subflow_early_fallback(msk, subflow);
> +#endif
> +	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk)) {
> +		MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT);
> +		mptcp_subflow_early_fallback(msk, subflow);
> +	}
> +	if (likely(!__mptcp_check_fallback(msk)))
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
> +
> +	/* if reaching here via the fastopen/sendmsg path, the caller already
> +	 * acquired the subflow socket lock, too.
> +	 */
> +	if (msk->is_sendmsg)
> +		err = __inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags, 1);
> +	else
> +		err = inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags);
> +	inet_sk(sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
> +
> +	/* on successful connect, the msk state will be moved to established by
> +	 * subflow_finish_connect()
> +	 */
> +	if (!err || err == -EINPROGRESS)
> +		mptcp_copy_inaddrs(sk, ssock->sk);
> +	else
> +		inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
> +	return err;
> +}
> +
> static struct proto mptcp_prot = {
> 	.name		= "MPTCP",
> 	.owner		= THIS_MODULE,
> 	.init		= mptcp_init_sock,
> +	.connect	= mptcp_connect,
> 	.disconnect	= mptcp_disconnect,
> 	.close		= mptcp_close,
> 	.accept		= mptcp_accept,
> @@ -3561,78 +3619,16 @@ static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
> 	return err;
> }
>
> -static void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
> -					 struct mptcp_subflow_context *subflow)
> -{
> -	subflow->request_mptcp = 0;
> -	__mptcp_do_fallback(msk);
> -}
> -
> static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> 				int addr_len, int flags)
> {
> -	struct mptcp_sock *msk = mptcp_sk(sock->sk);
> -	struct mptcp_subflow_context *subflow;
> -	struct socket *ssock;
> -	int err = -EINVAL;
> +	int ret;
>
> 	lock_sock(sock->sk);
> -	if (uaddr) {
> -		if (addr_len < sizeof(uaddr->sa_family))
> -			goto unlock;
> -
> -		if (uaddr->sa_family == AF_UNSPEC) {
> -			err = mptcp_disconnect(sock->sk, flags);
> -			sock->state = err ? SS_DISCONNECTING : SS_UNCONNECTED;
> -			goto unlock;
> -		}
> -	}
> -
> -	if (sock->state != SS_UNCONNECTED && msk->subflow) {
> -		/* pending connection or invalid state, let existing subflow
> -		 * cope with that
> -		 */
> -		ssock = msk->subflow;
> -		goto do_connect;
> -	}

I don't see a similar chunk of code added back in elsewhere in this patch.

After looking at the commit message for 41be81a8d3d0 ("mptcp: fix 
unblocking connect()"), I'm not sure the nonblocking connect is still 
handled? I see where __inet_stream_connect() will not call mptcp_connect() 
with SS_UNCONNECTED, but it's not obvious why it's no longer important to 
handle this scenario any more. Could you clarify the reasoning for this in 
the commit message if the nonblocking connect is handled some other way 
now?

- Mat

> -
> -	ssock = __mptcp_nmpc_socket(msk);
> -	if (!ssock)
> -		goto unlock;
> -
> -	mptcp_token_destroy(msk);
> -	inet_sk_state_store(sock->sk, TCP_SYN_SENT);
> -	subflow = mptcp_subflow_ctx(ssock->sk);
> -#ifdef CONFIG_TCP_MD5SIG
> -	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
> -	 * TCP option space.
> -	 */
> -	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
> -		mptcp_subflow_early_fallback(msk, subflow);
> -#endif
> -	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk)) {
> -		MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT);
> -		mptcp_subflow_early_fallback(msk, subflow);
> -	}
> -	if (likely(!__mptcp_check_fallback(msk)))
> -		MPTCP_INC_STATS(sock_net(sock->sk), MPTCP_MIB_MPCAPABLEACTIVE);
> -
> -do_connect:
> -	err = ssock->ops->connect(ssock, uaddr, addr_len, flags);
> -	inet_sk(sock->sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
> -	sock->state = ssock->state;
> -
> -	/* on successful connect, the msk state will be moved to established by
> -	 * subflow_finish_connect()
> -	 */
> -	if (!err || err == -EINPROGRESS)
> -		mptcp_copy_inaddrs(sock->sk, ssock->sk);
> -	else
> -		inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
> -
> -unlock:
> +	mptcp_sk(sock->sk)->connect_flags = flags;
> +	ret = __inet_stream_connect(sock, uaddr, addr_len, flags, 0);
> 	release_sock(sock->sk);
> -	return err;
> +	return ret;
> }
>
> static int mptcp_listen(struct socket *sock, int backlog)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 93c535440a5c..18f866b1afda 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -285,7 +285,9 @@ struct mptcp_sock {
> 	u8		mpc_endpoint_id;
> 	u8		recvmsg_inq:1,
> 			cork:1,
> -			nodelay:1;
> +			nodelay:1,
> +			is_sendmsg:1;
> +	int		connect_flags;
> 	struct work_struct work;
> 	struct sk_buff  *ooo_last_skb;
> 	struct rb_root  out_of_order_queue;
> -- 
> 2.37.3
>
>
>

--
Mat Martineau
Intel
