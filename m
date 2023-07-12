Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B75F50D
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 21:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D768DC433C7;
	Wed, 12 Jul 2023 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689198658;
	bh=JTp4L9aKLjKJEm273ZHA4JrTDqWagbyU1mFBsOa9A1g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Lnsjv1U6L6j5TDQwpMlu4jWAem+9TIKPdxyLktr7AKU/oysWiHGeykH4q+/yafvTN
	 okq5Nox7dZ/ySrvEQiYvFlPOWYcRjfMcrhSqfc15UwQMha+3wWQGsevkU4QoSe4Q5u
	 5SOTw4bWIlMpGBu70fIEEHfn6pjTTn1WlaNsEL8AI2ndRzl5fIKapi7eJbttUU7+/y
	 H8HMS+8l1F2mgnVAxR8GTcIz/H/+waUBpGT1+fmv1qU/NYaJbNI5p0OLBlwfd1Ymxh
	 xXlWMQHFMKcB6nllHftcxkAqcDJ7NDnBJxFbF9Lw5SwCFGJGdv8iCdsHbnW6X6t3CR
	 WUUiI4wQkeCyw==
Date: Wed, 12 Jul 2023 14:50:54 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 07/14] net: factor out __inet_listen_sk()
 helper
In-Reply-To: <c5d9a8a411ec56d847418aad437b63d24872cb71.1688993569.git.pabeni@redhat.com>
Message-ID: <927fb820-a640-48b9-50b4-e395ea0aa604@kernel.org>
References: <cover.1688993569.git.pabeni@redhat.com> <c5d9a8a411ec56d847418aad437b63d24872cb71.1688993569.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 10 Jul 2023, Paolo Abeni wrote:

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
> ---
> include/net/inet_common.h |  1 +
> net/ipv4/af_inet.c        | 39 +++++++++++++++++++++++----------------
> 2 files changed, 24 insertions(+), 16 deletions(-)
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
> index 2fd23437c1d2..fa482e314162 100644
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
> @@ -227,10 +216,28 @@ int inet_listen(struct socket *sock, int backlog)
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
> +	int err;
> +
> +	lock_sock(sk);
> +
> +	err = -EINVAL;

Minor tweak: can initialize in the declaration above.

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
