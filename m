Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFAB2AB35
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 23:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2416C433C7;
	Fri, 14 Jul 2023 23:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689376885;
	bh=gp1J6FNAvvhTGGFigG95ofZd5U1OileqxL7y7VcxpZk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jJhMyMrIJVhh1uKgTOBbIdDxIHkKcVFSYWtkd9TgJa0K7Tk+U86FLVxifo62PvsjS
	 j21RxRQggKtrX/G91TM3QoroFockBTSLdpMRJMCc/1mGRuEFiAN39N0RUXCe0UAOns
	 vScqCMItZQ1avDh9SHQ4F5nlh8/2W7Dsfv1DZOuBsszVxvOV8Vy2u0XhPGOgOq3NtK
	 fEQ96M/zhLPs1u83zRiutWyx+zyxRDvRFipF5FgF5w4SiIy0AqELlIR63NLxMx4L9c
	 3gkxw68ERSPbfuhIO3Am88dTko5WQMx3kxJKRhP4NCeKn2szzccBtW/VVPkLZF9FK2
	 gp6WYr5wxXjPQ==
Date: Fri, 14 Jul 2023 16:21:24 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 06/13] net: factor out __inet_listen_sk()
 helper
In-Reply-To: <5ed59fdc8730f5a559f126b9f78fcdf2ef64d1ce.1689334116.git.pabeni@redhat.com>
Message-ID: <e68937af-a024-2642-585e-175b346c1bf6@kernel.org>
References: <cover.1689334116.git.pabeni@redhat.com> <5ed59fdc8730f5a559f126b9f78fcdf2ef64d1ce.1689334116.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 Jul 2023, Paolo Abeni wrote:

> The mptcp protocol maintains an additional socket just to easily
> invoke a few stream operations on the first subflow. One of them
> is inet_listen().
>
> Factor out an helper operating directly on the (locked) struct sock,
> to allow get rid of the above dependency in the next patch without
> duplicating the existing code.
>
> No functional changes intended.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> --
> v1 -> v2:
> - initialize 'err' at definition time (Mat)

Acked-by: Mat Martineau <martineau@kernel.org>

> ---
> include/net/inet_common.h |  1 +
> net/ipv4/af_inet.c        | 38 ++++++++++++++++++++++----------------
> 2 files changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/include/net/inet_common.h b/include/net/inet_common.h
> index 8e97de700991..f50a644d87a9 100644
> --- a/include/net/inet_common.h
> +++ b/include/net/inet_common.h
> @@ -40,6 +40,7 @@ int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
> 		 int flags);
> int inet_shutdown(struct socket *sock, int how);
> int inet_listen(struct socket *sock, int backlog);
> +int __inet_listen_sk(struct sock *sk, int backlog);
> void inet_sock_destruct(struct sock *sk);
> int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
> int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 2fd23437c1d2..c59da65f19d2 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -187,24 +187,13 @@ static int inet_autobind(struct sock *sk)
> 	return 0;
> }
>
> -/*
> - *	Move a socket into listening state.
> - */
> -int inet_listen(struct socket *sock, int backlog)
> +int __inet_listen_sk(struct sock *sk, int backlog)
> {
> -	struct sock *sk = sock->sk;
> -	unsigned char old_state;
> +	unsigned char old_state = sk->sk_state;
> 	int err, tcp_fastopen;
>
> -	lock_sock(sk);
> -
> -	err = -EINVAL;
> -	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
> -		goto out;
> -
> -	old_state = sk->sk_state;
> 	if (!((1 << old_state) & (TCPF_CLOSE | TCPF_LISTEN)))
> -		goto out;
> +		return -EINVAL;
>
> 	WRITE_ONCE(sk->sk_max_ack_backlog, backlog);
> 	/* Really, if the socket is already in listen state
> @@ -227,10 +216,27 @@ int inet_listen(struct socket *sock, int backlog)
>
> 		err = inet_csk_listen_start(sk);
> 		if (err)
> -			goto out;
> +			return err;
> +
> 		tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_LISTEN_CB, 0, NULL);
> 	}
> -	err = 0;
> +	return 0;
> +}
> +
> +/*
> + *	Move a socket into listening state.
> + */
> +int inet_listen(struct socket *sock, int backlog)
> +{
> +	struct sock *sk = sock->sk;
> +	int err = -EINVAL;
> +
> +	lock_sock(sk);
> +
> +	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
> +		goto out;
> +
> +	err = __inet_listen_sk(sk, backlog);
>
> out:
> 	release_sock(sk);
> -- 
> 2.41.0
>
>
>
