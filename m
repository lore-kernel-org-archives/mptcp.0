Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF49DF56
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 21:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850C4C433C8;
	Wed, 12 Jul 2023 21:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689198599;
	bh=SYCp7eGcxrdVnrr2T2FJwRX4JnXMjsk6ahndpqPOncw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=K/mEmWcG4ajcC4POFCX5gDNfmAqIvDRnYqmkOwT2zZ7d9eNaxBLl8lJOddSTHUi8a
	 3PYiBZ98BX+Mm7Iv5P6aRpgDOKEqWa9WjVIV+Qh20hCRmPo5aEdqBz2SoTTr7VbvPD
	 76DxfPg/41Wi1BzWhghi0FnyT97/E3uNDXZ1k7/M+YeKclXB+eaKKyfkXT4sDYtWrl
	 D0atY+Dzyi6itcwUxD8ZnOs5qzAvyJWTf1PKEjsJAFCK2fBEBO0LRZBdpBlPgRcrx1
	 6EsdfHgbNYG14ZnrDYgZcbDAGGP1KEl0ZuVj0f+z8HsIOQ7Ib0mjGUnivsUyMeJ+gz
	 GwBOq9dvTQLOQ==
Date: Wed, 12 Jul 2023 14:49:57 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 03/14] mptcp: avoid additional __inet_stream_connect()
 call
In-Reply-To: <3f427fdc84212cde2d5ad09a46925a43a4a0fae7.1688993569.git.pabeni@redhat.com>
Message-ID: <6f46d6b1-2aa9-e56f-f473-0300c08e2788@kernel.org>
References: <cover.1688993569.git.pabeni@redhat.com> <3f427fdc84212cde2d5ad09a46925a43a4a0fae7.1688993569.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 10 Jul 2023, Paolo Abeni wrote:

> The mptcp protocol maintains an additional socket just to easily
> invoke a few stream operations on the first subflow. One of them is
> __inet_stream_connect().
>

Hi Paolo -

Thanks for the series! It will be good to get rid of the confusing subflow 
pointer.

> We are going to remove the first subflow socket soon, so avoid
> the addictional indirection via at connect time, calling directly
       ^^^^^^^^^^^

"additional" is misspelled this way in many of the series commit messages.

> into the sock-level connect() ops.
>
> No functional change intended.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 40 +++++++++++++++++++++++++++++-----------
> 1 file changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 17174bdae1ca..7445a3cf8812 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3629,22 +3629,24 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct socket *ssock;
> 	int err = -EINVAL;
> +	struct sock *ssk;
>
> 	ssock = __mptcp_nmpc_socket(msk);
> 	if (IS_ERR(ssock))
> 		return PTR_ERR(ssock);
>
> 	inet_sk_state_store(sk, TCP_SYN_SENT);
> -	subflow = mptcp_subflow_ctx(ssock->sk);
> +	ssk = msk->first;
> +	subflow = mptcp_subflow_ctx(ssk);
> #ifdef CONFIG_TCP_MD5SIG
> 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
> 	 * TCP option space.
> 	 */
> -	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
> +	if (rcu_access_pointer(tcp_sk(ssk)->md5sig_info))
> 		mptcp_subflow_early_fallback(msk, subflow);
> #endif
> -	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk)) {
> -		MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT);
> +	if (subflow->request_mptcp && mptcp_token_new_connect(ssk)) {
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
> 		mptcp_subflow_early_fallback(msk, subflow);
> 	}
> 	if (likely(!__mptcp_check_fallback(msk)))
> @@ -3653,21 +3655,37 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
> 	/* if reaching here via the fastopen/sendmsg path, the caller already
> 	 * acquired the subflow socket lock, too.
> 	 */
> -	if (msk->fastopening)
> -		err = __inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK, 1);
> -	else
> -		err = inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK);
> -	inet_sk(sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
> +	if (!msk->fastopening)
> +		lock_sock(ssk);
> +
> +	if (ssk->sk_state != TCP_CLOSE)
> +		goto out;
> +
> +	if (BPF_CGROUP_PRE_CONNECT_ENABLED(ssk)) {
> +		err = ssk->sk_prot->pre_connect(ssk, uaddr, addr_len);
> +		if (err)
> +			goto out;
> +	}
> +
> +	err = ssk->sk_prot->connect(ssk, uaddr, addr_len);
> +	if (err < 0)
> +		goto out;
> +
> +	inet_sk(sk)->defer_connect = inet_sk(ssk)->defer_connect;

The above code doesn't do everything __inet_stream_connect() does. Is that 
code omitted here because the caller of this function handles the timeouts 
and msk-level socket states already?

- Mat

> +
> +out:
> +	if (!msk->fastopening)
> +		release_sock(ssk);
>
> 	/* on successful connect, the msk state will be moved to established by
> 	 * subflow_finish_connect()
> 	 */
> 	if (unlikely(err && err != -EINPROGRESS)) {
> -		inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
> +		inet_sk_state_store(sk, inet_sk_state_load(ssk));
> 		return err;
> 	}
>
> -	mptcp_copy_inaddrs(sk, ssock->sk);
> +	mptcp_copy_inaddrs(sk, ssk);
>
> 	/* silence EINPROGRESS and let the caller inet_stream_connect
> 	 * handle the connection in progress
> -- 
> 2.41.0
>
>
>
