Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8A9442A
	for <mptcp@lists.linux.dev>; Tue,  4 Oct 2022 22:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664921752; x=1696457752;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=otWSWhCXHlRgmhQNvX7a0tspzQ8zwA6p/VTkVIu9El0=;
  b=AlXYayrJ2HeflloPc86JUqtakXbaHuf1EQuibnyGlt0koD0e5b9MQto9
   0q+sTHwBYgXZprlTlQsPgPvzcp2bE7UsnrskJaYPLu5AYrr4FeKAwdZzk
   0eeooXCF7kHBpe3JP9nTfFncQ4pV/t5VVulTUvLjsbRMsovCFCZj/5O8t
   wJsY4gpyKPH9Pty8pY1qdg6gzILE4ty00y8YbMGlSb7nZpzpON5cGnqaO
   1l1sHrbw3W/9mKr5I4wTwdu0hdatXXLHZoLq3+jxzLt8Bukhl5Yn3PFYz
   OTvkOvTLWbaJ8oOKA2UNPxUZe1VSYNDMOFKPHeKJdhiZPJoE4TSnOjzwS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="283405889"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="283405889"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 15:15:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="952965357"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="952965357"
Received: from jessicat-mobl.amr.corp.intel.com ([10.209.12.163])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 15:15:51 -0700
Date: Tue, 4 Oct 2022 15:15:51 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Dmytro Shytyi <dmytro@shytyi.net>
Subject: Re: [PATCH mptcp-next v2] mptcp: factor out mptcp_connect()
In-Reply-To: <c74935435f59a6120f62c56bd5e1519c30d269bf.1664915909.git.pabeni@redhat.com>
Message-ID: <878049c3-3455-aa3b-4c98-e315253037af@linux.intel.com>
References: <c74935435f59a6120f62c56bd5e1519c30d269bf.1664915909.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 4 Oct 2022, Paolo Abeni wrote:

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
> v1 -> v2:
> - properly update msk state on unblocking connect

v2 looks good to me, I also tried it with your updated packetdrill tests 
(https://github.com/multipath-tcp/packetdrill/pull/94).

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> net/mptcp/protocol.c | 136 ++++++++++++++++++++++---------------------
> net/mptcp/protocol.h |   4 +-
> 2 files changed, 73 insertions(+), 67 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8feb684408f7..1aa940928b4f 100644
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
> 		copied += copied_syn;
> 		if (ret == -EINPROGRESS && copied_syn > 0) {
> 			/* reflect the new state on the MPTCP socket */
> @@ -3506,10 +3509,73 @@ static int mptcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
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
> +	if (unlikely(err && err != -EINPROGRESS)) {
> +		inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
> +		return err;
> +	}
> +
> +	mptcp_copy_inaddrs(sk, ssock->sk);
> +
> +	/* unblocking connect, mptcp-level inet_stream_connect will error out
> +	 * without changing the socket state, update it here.
> +	 */
> +	if (err == -EINPROGRESS)
> +		sk->sk_socket->state = ssock->state;
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
> @@ -3561,78 +3627,16 @@ static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
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
