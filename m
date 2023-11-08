Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0137155
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwzwRPG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1F3C433C7;
	Wed,  8 Nov 2023 23:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699485324;
	bh=jP2oNure21IbRcaUhI453IuCpyTrK/Aq2ocgg/uP9Ow=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qwzwRPG03pOO0+C/zSuWPspSzWbgzi3HoBJjJCWKf/9MFYONSGJae9VNBplI04axe
	 0EaI/aKzJ2r0ru34I+kkUPyqjqqvKkg1UsDPLMc8CiEVsTn1DMFOho951XLyAfBPam
	 JM6nbxGehwLrts6075QnQKTBUHd8Mg26tGVV5Bxe7O9UaXzpvqhK2PW5znnTDYp0+t
	 ZRfkrOu4dI+z1guHBy0hEUDTkNkffq4ffq05S5LD8XZPB1Jj4X2shjmG46EQrcDeev
	 OOZlau8I6UP+pgukspdleUm6YFDW0jCxyXO3HEtBlTIPTv/v1JFR6ifbglkkheCi4s
	 IEih9gAAO5ivw==
Date: Wed, 8 Nov 2023 15:15:23 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: fix setsockopt(IP_TOS) subflow
 locking
In-Reply-To: <f2cf8a00fdf178f314b92c8809ca9deed98464fa.1699466615.git.pabeni@redhat.com>
Message-ID: <9ac14d65-9c32-9ae0-1e52-5521d6800f96@kernel.org>
References: <f2cf8a00fdf178f314b92c8809ca9deed98464fa.1699466615.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 8 Nov 2023, Paolo Abeni wrote:

> The mptcp implementation of the IP_TOS socket option uses the lockless
> variant of the TOS manipulation helper and does not hold suck lock at

(matttbe: please fix "such" typo when applying)

> the helper invocation time.
>
> Add the required locking.
>
> Fixes: ffcacff87cd6 ("mptcp: Support for IP_TOS for MPTCP setsockopt()")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/457
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/sockopt.c | 3 +++
> 1 file changed, 3 insertions(+)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 8d485c40585a..cabe856b2a45 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -738,8 +738,11 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
> 	val = READ_ONCE(inet_sk(sk)->tos);
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
>
> +		slow = lock_sock_fast(ssk);
> 		__ip_sock_set_tos(ssk, val);
> +		unlock_sock_fast(ssk, slow);
> 	}
> 	release_sock(sk);
>

Looks good to me with commit message typo fix:

Reviewed-by: Mat Martineau <martineau@kernel.org>
