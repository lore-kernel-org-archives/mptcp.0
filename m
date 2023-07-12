Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579F0EAE7
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 21:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCC8C433C8;
	Wed, 12 Jul 2023 21:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689198769;
	bh=/4yAvW495Fk2HFCHV4Th+6Dpt/SqV/dmK2dOQjdgPVk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=tppluq7Z2bD078QW9ajpJUB8/5BatDdhSw59/K+EhqiBPqFPo5PNPtsvlQAXUA/ga
	 z2CI3HiQ7YWxz8fg51VnJMY1ZMQ8zjFPVsgbU6ipIdwcG3VwO5hEZyQrZK2QohUB25
	 dklIKV/AUGE9ooihwcZkARAUL+9SFzXQgGIEkW2JTeNWAlAcmz7IhKb7k0XiNfQR+5
	 RxjZ98PWH2wm+1RgEhwDU/WHPTg0FLf5zRkl9E5ZO+I9XLvlC3rFUrfKBWLs6ukD91
	 uTIptes6vG4exa9EKnxpSIYuoJpYlm+QsujCq3YJVOPpbN7pusXfAQ4zAF5RHHqjuN
	 W9eEjwg9S9cvw==
Date: Wed, 12 Jul 2023 14:52:44 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 08/14] mptcp: avoid additional indirection in
 mptcp_listen()
In-Reply-To: <3e6dc1e7ec147cf1ab8109a7ec65b62319565604.1688993569.git.pabeni@redhat.com>
Message-ID: <fcd2efdf-67d9-e90e-ddd7-355f7367ce05@kernel.org>
References: <cover.1688993569.git.pabeni@redhat.com> <3e6dc1e7ec147cf1ab8109a7ec65b62319565604.1688993569.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 10 Jul 2023, Paolo Abeni wrote:

> We are going to remove the first subflow socket soon, so avoid
> the addictional indirection via at listen() time. Instead call
> directly the recently introduced helper on the first subflow sock.
>
> No functional changes intended.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 14 ++++++++++----
> 1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 00b891f709f7..c5da7a172ee9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3759,6 +3759,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
> 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
> 	struct sock *sk = sock->sk;
> 	struct socket *ssock;
> +	struct sock *ssk;
> 	int err;
>
> 	pr_debug("msk=%p", msk);
> @@ -3775,15 +3776,20 @@ static int mptcp_listen(struct socket *sock, int backlog)
> 		goto unlock;
> 	}
>
> +	ssk = msk->first;
> 	inet_sk_state_store(sk, TCP_LISTEN);
> 	sock_set_flag(sk, SOCK_RCU_FREE);
>
> -	err = ssock->ops->listen(ssock, backlog);
> -	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
> +	lock_sock(ssk);
> +	err = __inet_listen_sk(ssk, backlog);
> +	release_sock(ssk);
> +	inet_sk_state_store(sk, inet_sk_state_load(ssk));
> +
> 	if (!err) {
> +		WRITE_ONCE(sk->sk_max_ack_backlog, backlog);

This seems like new functionality that isn't mentioned in the commit 
message. Do the changes here expose an issue with making the msk-level 
sk_max_ack_backlog match the subflow, or is this an unrelated fix?

> 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> -		mptcp_copy_inaddrs(sk, ssock->sk);
> -		mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
> +		mptcp_copy_inaddrs(sk, ssk);
> +		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
> 	}
>
> unlock:
> -- 
> 2.41.0
>
>
>
