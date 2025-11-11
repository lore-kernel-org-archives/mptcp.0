Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994762FF143
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 01:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826367; cv=none; b=f/4PZhO42xNMtGAMB6jswhQ1rz1L9aqB+772OLVhSZrGPBM+iFvQGaJVvU0UBSjU/JfUMayI5zkIxqhvKEnSisERbwXh4jJqqTrrgH70jbUZMvUZBN5DpcqMV0xNV8DkB9vcV1HQgncASYEWJVDkQ/LP6ZCz+H3dbOQQUZ5351k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826367; c=relaxed/simple;
	bh=GJb0y2gVyJawtR+87PzwQ2B1WPZZsCfAE7ydj3iZwfw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eIKqsNxn7ZC84nyz0kaJvckD/azwQZlOyoPgFpF7Ar0gUL9+ynNl4hHAzBB2M80yFVEDKWZmO/wguQIawusw1GIAXnMNG8LDHCbbeF4k82UYEg8cIjiziQzKrXc3sg2eRvGRtARe7OJ9J+ffmt9NspeJPMv84N07Djj21ekAWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdlsNbsf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdlsNbsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38971C116B1;
	Tue, 11 Nov 2025 01:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762826367;
	bh=GJb0y2gVyJawtR+87PzwQ2B1WPZZsCfAE7ydj3iZwfw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=RdlsNbsfxz8kzS67gMu7dxztzIzFe8dAbEKaM8M2iB2nT+6ID837ypUUOZvKrlGYw
	 iOywSUbt1HK946h/1DRsuLs+VS8E1j/gqgcfJ6MB4AMrrsmwbe8A5G/HPFi6LtiIR4
	 LafkFUKWvX5Fixqh8I89mNMterwHh+F5K+sF/DAt272RljZS6mkoPUy+yG9W8aDav6
	 xUHpiZMvLLjPlZUNyXFK/pSaaymzTfJxEFkPrDzMJkTKUDWiuoyZty0eBDdiJUCIcZ
	 4E3eJcm3YRnFfX8lwXB6BxDhAsikwYCkVyJEmRfPHRNTrjAKZ0HDgpBCaOCa06AM1g
	 QZ20kS1d3idrw==
Message-ID: <5a0c227a3a2b660492af391af65eaae8afe31ad0.camel@kernel.org>
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: fix duplicate reset on fastclose
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Tue, 11 Nov 2025 09:59:23 +0800
In-Reply-To: <32586f43554a4837f39d534676c5ad957dc10dd5.1762500073.git.pabeni@redhat.com>
References: <cover.1762500073.git.pabeni@redhat.com>
	 <32586f43554a4837f39d534676c5ad957dc10dd5.1762500073.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thanks for this v2.

On Fri, 2025-11-07 at 08:23 +0100, Paolo Abeni wrote:
> The CI reports sporadic failures of the fastclose self-tests. The
> root
> cause is a duplicate reset, not carrying the relevant MPTCP option.
> In the failing scenario the bad reset is received by the peer before
> the fastclose one, preventing the reception of the latter.
> 
> Indeed there is window of opportunity at fastclose time for the
> following
> race:
> 
> mptcp_do_fastclose
>   __mptcp_close_ssk
>     __tcp_close()
>       tcp_set_state() [1]
>       tcp_send_active_reset() [2]
> 
> After [1] the stack will send reset to in-flight data reaching the
> now
> closed port. Such reset may race with [2].
> 
> Address the issue explicitly sending a single reset on fastclose
> before
> explicitly moving the subflow to close status.
> 
> Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios");
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/596
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - test subflow->send_fastclose in __mptcp_subflow_disconnect()
> instead
>    of MPTCP_CF_FASTCLOSE
> ---
>  net/mptcp/protocol.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0301e0b0de05..24d4fa8227b7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2437,7 +2437,6 @@ bool __mptcp_retransmit_pending_data(struct
> sock *sk)
>  
>  /* flags for __mptcp_close_ssk() */
>  #define MPTCP_CF_PUSH		BIT(1)
> -#define MPTCP_CF_FASTCLOSE	BIT(2)
>  
>  /* be sure to send a reset only if the caller asked for it, also
>   * clean completely the subflow status when the subflow reaches
> @@ -2448,7 +2447,7 @@ static void __mptcp_subflow_disconnect(struct
> sock *ssk,
>  				       unsigned int flags)

nit:

The 3rd argument "flags" of __mptcp_subflow_disconnect is useless now.
We can drop it.

No need to send v3, Matt or I can handle it.

Thanks,
-Geliang

>  {
>  	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
> -	    (flags & MPTCP_CF_FASTCLOSE)) {
> +	    subflow->send_fastclose) {
>  		/* The MPTCP code never wait on the subflow sockets,
> TCP-level
>  		 * disconnect should never fail
>  		 */
> @@ -2511,20 +2510,13 @@ static void __mptcp_close_ssk(struct sock
> *sk, struct sock *ssk,
>  	if (dispose_it)
>  		list_del(&subflow->node);
>  
> -	if ((flags & MPTCP_CF_FASTCLOSE) &&
> !__mptcp_check_fallback(msk)) {
> -		/* be sure to force the tcp_close path
> -		 * to generate the egress reset
> -		 */
> -		ssk->sk_lingertime = 0;
> -		sock_set_flag(ssk, SOCK_LINGER);
> -		subflow->send_fastclose = 1;
> -	}
> +	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
> +		tcp_set_state(ssk, TCP_CLOSE);
>  
>  	need_push = (flags & MPTCP_CF_PUSH) &&
> __mptcp_retransmit_pending_data(sk);
>  	if (!dispose_it) {
>  		__mptcp_subflow_disconnect(ssk, subflow, flags);
>  		release_sock(ssk);
> -
>  		goto out;
>  	}
>  
> @@ -2855,9 +2847,26 @@ static void mptcp_do_fastclose(struct sock
> *sk)
>  
>  	mptcp_set_state(sk, TCP_CLOSE);
>  	mptcp_backlog_purge(sk);
> -	mptcp_for_each_subflow_safe(msk, subflow, tmp)
> -		__mptcp_close_ssk(sk,
> mptcp_subflow_tcp_sock(subflow),
> -				  subflow, MPTCP_CF_FASTCLOSE);
> +
> +	/* Explicitly send the fastclose reset as need */
> +	if (__mptcp_check_fallback(msk))
> +		return;
> +
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		lock_sock(ssk);
> +
> +		/* Some subflow socket states don't allow/need a
> reset.*/
> +		if ((1 << ssk->sk_state) & (TCPF_LISTEN |
> TCPF_CLOSE))
> +			goto unlock;
> +
> +		subflow->send_fastclose = 1;
> +		tcp_send_active_reset(ssk, ssk->sk_allocation,
> +				     
> SK_RST_REASON_TCP_ABORT_ON_CLOSE);
> +unlock:
> +		release_sock(ssk);
> +	}
>  }
>  
>  static void mptcp_worker(struct work_struct *work)

