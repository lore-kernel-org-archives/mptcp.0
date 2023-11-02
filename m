Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83329373
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsNXGi0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DB9C433CB;
	Thu,  2 Nov 2023 00:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698886282;
	bh=8mXeW8624Ck3mKPx5ZdNIpvruDw0X6oX8QuxuLJxXAA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gsNXGi0+2IheOU2dpzBLarSZ/xlh6cpot6xkyAqBRKYogTPGT3feikKMof8ui279W
	 2yH0oSh8i8d6hfZmwdsxb7cReFlyKmmjubREOYdO7yxYfjgmpTtGd+jUJaJxYr1oek
	 MRugcUtSGUuqKRrwDVME2WWDtczM3gevuwIOY4D9O+vqi5iUyhxvcR75QkSa1S70yK
	 klCO2TWFbd/N74vHUc2CK62wFfk3kqC55yLKHjPhXzUpxkW1dcJ/ixooKq5GRdULsV
	 2/gf9g1fXAQTDGteZipUzVJAz36a3SnUgTVFUqSzyVjkrPcFHP3p4fhIb4HX8ttM1D
	 Z+9P1eC3VdQww==
Date: Wed, 1 Nov 2023 17:51:20 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] net/mptcp: don't overwrite sock_ops in
 mptcp_is_tcpsk()
In-Reply-To: <a2581b975c0c5bec417b2dd5e0b014acd7770e14.1698764762.git.dcaratti@redhat.com>
Message-ID: <79c895c8-2089-3d54-2495-3c19341db8f1@kernel.org>
References: <a2581b975c0c5bec417b2dd5e0b014acd7770e14.1698764762.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 31 Oct 2023, Davide Caratti wrote:

> Eric suggests:
>
> > The fact that mptcp_is_tcpsk() was able to write over sock->ops was a
> > bit strange to me.
> > mptcp_is_tcpsk() should answer a question, with a read-only argument.
>
> re-factor code to avoid overwriting sock_ops inside that function. Also,
> change the helper name to reflect the semantic, and to disambiguate from
> its dual sk_is_mptcp().
>
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/432
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
> net/mptcp/protocol.c | 38 ++++++++++++++++++--------------------
> 1 file changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0ad507ac6bc7..9a9f8acd979e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -55,28 +55,15 @@ u64 mptcp_wnd_end(const struct mptcp_sock *msk)
> 	return READ_ONCE(msk->wnd_end);
> }
>
> -static bool mptcp_is_tcpsk(struct sock *sk)
> +static const struct proto_ops *mptcp_get_fallback_tcp_ops(const struct sock *sk)
> {
> -	struct socket *sock = sk->sk_socket;
> -
> -	if (unlikely(sk->sk_prot == &tcp_prot)) {
> -		/* we are being invoked after mptcp_accept() has
> -		 * accepted a non-mp-capable flow: sk is a tcp_sk,
> -		 * not an mptcp one.
> -		 *
> -		 * Hand the socket over to tcp so all further socket ops
> -		 * bypass mptcp.
> -		 */
> -		WRITE_ONCE(sock->ops, &inet_stream_ops);
> -		return true;
> +	if (unlikely(sk->sk_prot == &tcp_prot))
> +		return &inet_stream_ops;
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -	} else if (unlikely(sk->sk_prot == &tcpv6_prot)) {
> -		WRITE_ONCE(sock->ops, &inet6_stream_ops);
> -		return true;
> +	else if (unlikely(sk->sk_prot == &tcpv6_prot))
> +		return &inet6_stream_ops;
> #endif
> -	}
> -
> -	return false;
> +	return NULL;
> }
>
> static int __mptcp_socket_create(struct mptcp_sock *msk)
> @@ -3832,6 +3819,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
> 			       int flags, bool kern)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
> +	const struct proto_ops *fallback_ops;
> 	struct sock *ssk, *newsk;
> 	int err;
>
> @@ -3851,7 +3839,8 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
> 	lock_sock(newsk);
>
> 	__inet_accept(sock, newsock, newsk);
> -	if (!mptcp_is_tcpsk(newsock->sk)) {
> +	fallback_ops = mptcp_get_fallback_tcp_ops(newsock->sk);
> +	if (!fallback_ops) {
> 		struct mptcp_sock *msk = mptcp_sk(newsk);
> 		struct mptcp_subflow_context *subflow;
>
> @@ -3877,6 +3866,15 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
> 			if (unlikely(list_is_singular(&msk->conn_list)))
> 				inet_sk_state_store(newsk, TCP_CLOSE);
> 		}
> +	} else {
> +		/* we are being invoked after mptcp_accept() has
> +		 * accepted a non-mp-capable flow: sk is a tcp_sk,
> +		 * not an mptcp one.
> +		 *
> +		 * Hand the socket over to tcp so all further socket ops
> +		 * bypass mptcp.
> +		 */
> +		WRITE_ONCE(newsock->sk->sk_socket->ops, fallback_ops);

Hi Davide -

From your comment in the meeting about using a different helper to 
determine if it's a MPTCP or TCP sk, I think the idea is to get rid of the 
helper function (rather than rename) and then include the ipv4/ipv6 logic 
in this block of code? That approach sounds good to me.

If that doesn't work out, another option is to rename the helper function 
to something that meets Eric's criteria (avoiding "mptcp_is_xxx()" or 
"mptcp_get_xxx()" names).

- Mat

> 	}
> 	release_sock(newsk);
>
> -- 
> 2.41.0
>
>
>
