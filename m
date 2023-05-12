Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B523D4D
	for <mptcp@lists.linux.dev>; Fri, 12 May 2023 19:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C45EC433D2;
	Fri, 12 May 2023 19:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683919486;
	bh=npzq4ky7atrZmx9YN2GhdaFEziuLMCSyHKjRG3TzOIs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CY9bxmFRC/accPDOFek+mS0H1qtj7iQBHHDDbtHe7oFtCg+pzo+9BmCcWQkDrqkXC
	 8+ggrmFzQisZAWhAQm6RTfpNS9Odoq+Aohw2gQFQQ5ya1MTBq5UFINPM7Wlf0KLTrc
	 g9KZOZs+KgRwyJQDH73/tni3DdEmw6P9P4eBPiY9bGU4utkysM3ZtOf3nBxTMhMKu0
	 /BD2/Ns6OZ5AHl2hJBjkJa8vaaHiHGPuflM8Cw4gVIJfJ3tggdExFSkb/M2Jj5SFDQ
	 qf/rC7FkFJUtZBYoc5AB/czWYPlJMZ9cx99z4Gsm1acAmTRO2WNDO6yJiPp8VjGvOR
	 V0wJmrnJXhUTg==
Date: Fri, 12 May 2023 12:24:45 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix connect timeout handling
In-Reply-To: <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
Message-ID: <5ba7d292-7128-fc9c-aa13-96c938bb881a@kernel.org>
References: <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 5 May 2023, Paolo Abeni wrote:

> Ondrej reported a functional issue WRT timeout handling on connect
> with a nice reproducer.
>
> The problem is that the current mptcp connect waits for both the
> MPTCP socket level timeout, and the first subflow socket timeout.
> The latter is not influenced/touched by the exposed setsockopt().
>
> Overall the above makes the SO_SNDTIMEO a no-op on connect.
>
> Since mptcp_connect is invoked via inet_stream_connect and the
> latter properly handle the MPTCP level timeout, we can address the
> issue making the nested subflow level connect always unblocking.
>
> This also allow simplifying a bit the code, dropping an ugly hack
> to handle the fastopen and custom proto_ops connect.
>
> The issues predates the blamed commit below, but the current resolution
> requires the infrastructure introduced there.
>
> Fixes: 54f1944ed6d2 ("mptcp: factor out mptcp_connect()")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/399
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note: there is needed follow-up correctly propagating the SYN_SENT
> -> CLOSE state transition from the first subflow to the msk socket in
> case of connect error, but that is somewhat independed/pre-existent.
>
> Sending out early for testing.

Hi Paolo -

Patch LGTM, and appreciate the cleanup of msk->connect_flags:

Reviewed-by: Mat Martineau <martineau@kernel.org>

I think it would be good to also add a selftest in net-next to check the 
connect timeout (set to a very short time), but that doesn't need to block 
this -net change.

Thanks,
Mat

> ---
> net/mptcp/protocol.c | 29 +++++++----------------------
> net/mptcp/protocol.h |  1 -
> 2 files changed, 7 insertions(+), 23 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f5842f93c891..4747058a8b6b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1734,7 +1734,6 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>
> 	lock_sock(ssk);
> 	msg->msg_flags |= MSG_DONTWAIT;
> -	msk->connect_flags = O_NONBLOCK;
> 	msk->fastopening = 1;
> 	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
> 	msk->fastopening = 0;
> @@ -3672,9 +3671,9 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
> 	 * acquired the subflow socket lock, too.
> 	 */
> 	if (msk->fastopening)
> -		err = __inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags, 1);
> +		err = __inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK, 1);
> 	else
> -		err = inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags);
> +		err = inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK);
> 	inet_sk(sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
>
> 	/* on successful connect, the msk state will be moved to established by
> @@ -3687,12 +3686,10 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
>
> 	mptcp_copy_inaddrs(sk, ssock->sk);
>
> -	/* unblocking connect, mptcp-level inet_stream_connect will error out
> -	 * without changing the socket state, update it here.
> +	/* silence EINPROGRESS and let the caller inet_stream_connect
> +	 * handle the connection in progress
> 	 */
> -	if (err == -EINPROGRESS)
> -		sk->sk_socket->state = ssock->state;
> -	return err;
> +	return 0;
> }
>
> static struct proto mptcp_prot = {
> @@ -3751,18 +3748,6 @@ static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
> 	return err;
> }
>
> -static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> -				int addr_len, int flags)
> -{
> -	int ret;
> -
> -	lock_sock(sock->sk);
> -	mptcp_sk(sock->sk)->connect_flags = flags;
> -	ret = __inet_stream_connect(sock, uaddr, addr_len, flags, 0);
> -	release_sock(sock->sk);
> -	return ret;
> -}
> -
> static int mptcp_listen(struct socket *sock, int backlog)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
> @@ -3917,7 +3902,7 @@ static const struct proto_ops mptcp_stream_ops = {
> 	.owner		   = THIS_MODULE,
> 	.release	   = inet_release,
> 	.bind		   = mptcp_bind,
> -	.connect	   = mptcp_stream_connect,
> +	.connect	   = inet_stream_connect,
> 	.socketpair	   = sock_no_socketpair,
> 	.accept		   = mptcp_stream_accept,
> 	.getname	   = inet_getname,
> @@ -4012,7 +3997,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
> 	.owner		   = THIS_MODULE,
> 	.release	   = inet6_release,
> 	.bind		   = mptcp_bind,
> -	.connect	   = mptcp_stream_connect,
> +	.connect	   = inet_stream_connect,
> 	.socketpair	   = sock_no_socketpair,
> 	.accept		   = mptcp_stream_accept,
> 	.getname	   = inet6_getname,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8d9d87e2f840..39613bba1c46 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -300,7 +300,6 @@ struct mptcp_sock {
> 			nodelay:1,
> 			fastopening:1,
> 			in_accept_queue:1;
> -	int		connect_flags;
> 	struct work_struct work;
> 	struct sk_buff  *ooo_last_skb;
> 	struct rb_root  out_of_order_queue;
> -- 
> 2.40.0
>
>
>
