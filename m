Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEEB15AE2
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 23:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80646C433C7;
	Fri, 14 Jul 2023 23:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689376861;
	bh=fataxzHVTBPlHcCUEc/Ipban6A17VtQnL9PAKoUNQkM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=l8noqv4YUKQXyvowtztrxCpzwS6gbFBBJ+SfuQ8BfbTr4EAcT29lwklc5+77ivvkL
	 J6M6tJ9t4LyOoTvo02GxpO0asqrQO4d88R9e/7HSu4zOomaAwUW8z2AASQeG59gOkS
	 Qjdl5HzqxUXfWNpXtqYY4YXqyMgC8mCMFsKiBVbkt4KXsJa/ThEJDeQotM3HxL1RRt
	 srJVTS0KIrmP1b/cxiKbHMhcsXLL43qseJC1PIVO3swmQN/omj8RcT7UEW8AVVyz6f
	 Qd6adwLRZS5zLoy+jCK3EyNP9u6a/UNKJjbR7GDJ1GHkXdSZMs9KF7Vbdpwijpxjcj
	 ppVVx+Z3uGSUg==
Date: Fri, 14 Jul 2023 16:21:00 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 04/13] net: factor out inet{,6}_bind_sk
 helpers
In-Reply-To: <0ae88674cecce303698c169be39bdeefe27e9232.1689334116.git.pabeni@redhat.com>
Message-ID: <626a1632-09e6-49d9-10d3-c916ed77a233@kernel.org>
References: <cover.1689334116.git.pabeni@redhat.com> <0ae88674cecce303698c169be39bdeefe27e9232.1689334116.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 Jul 2023, Paolo Abeni wrote:

> The mptcp protocol maintains an additional socket just to easily
> invoke a few stream operations on the first subflow. One of
> them is bind().
>
> Factor out the helpers operating directly on the struct sock, to
> allow get rid of the above dependency in the next patch without
> duplicating the existing code.
>
> No functional changes intended.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Acked-by: Mat Martineau <martineau@kernel.org>

> ---
> include/net/inet_common.h |  1 +
> include/net/ipv6.h        |  1 +
> net/ipv4/af_inet.c        |  8 ++++++--
> net/ipv6/af_inet6.c       | 10 +++++++---
> 4 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/inet_common.h b/include/net/inet_common.h
> index b86b8e21de7f..8e97de700991 100644
> --- a/include/net/inet_common.h
> +++ b/include/net/inet_common.h
> @@ -42,6 +42,7 @@ int inet_shutdown(struct socket *sock, int how);
> int inet_listen(struct socket *sock, int backlog);
> void inet_sock_destruct(struct sock *sk);
> int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
> +int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
> /* Don't allocate port at this moment, defer to connect. */
> #define BIND_FORCE_ADDRESS_NO_PORT	(1 << 0)
> /* Grab and release socket lock. */
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 7332296eca44..af761504e2f6 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -1220,6 +1220,7 @@ void inet6_cleanup_sock(struct sock *sk);
> void inet6_sock_destruct(struct sock *sk);
> int inet6_release(struct socket *sock);
> int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
> +int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
> int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
> 		  int peer);
> int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 9b2ca2fcc5a1..2fd23437c1d2 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -431,9 +431,8 @@ int inet_release(struct socket *sock)
> }
> EXPORT_SYMBOL(inet_release);
>
> -int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
> +int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
> {
> -	struct sock *sk = sock->sk;
> 	u32 flags = BIND_WITH_LOCK;
> 	int err;
>
> @@ -454,6 +453,11 @@ int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>
> 	return __inet_bind(sk, uaddr, addr_len, flags);
> }
> +
> +int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
> +{
> +	return inet_bind_sk(sock->sk, uaddr, addr_len);
> +}
> EXPORT_SYMBOL(inet_bind);
>
> int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 5d593ddc0347..d68959434256 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -435,10 +435,8 @@ static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
> 	goto out;
> }
>
> -/* bind for INET6 API */
> -int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
> +int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
> {
> -	struct sock *sk = sock->sk;
> 	u32 flags = BIND_WITH_LOCK;
> 	const struct proto *prot;
> 	int err = 0;
> @@ -462,6 +460,12 @@ int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>
> 	return __inet6_bind(sk, uaddr, addr_len, flags);
> }
> +
> +/* bind for INET6 API */
> +int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
> +{
> +	return inet6_bind_sk(sock->sk, uaddr, addr_len);
> +}
> EXPORT_SYMBOL(inet6_bind);
>
> int inet6_release(struct socket *sock)
> -- 
> 2.41.0
>
>
>
