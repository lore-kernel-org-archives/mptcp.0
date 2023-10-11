Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4A7208C6
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV187MNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553E1C433C7;
	Wed, 11 Oct 2023 16:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697043198;
	bh=p4Lx+LvpQsSeXTDcj8KE5S4bnQqXGxl5s476f2Qy8iA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DV187MNuJjECJ340R46KjSHcl0lFargvtdp5tfMECdzC3QFCj+kVCe0d2QAzepCLc
	 n7VD9wtUXg/QPGG5xqtRKz+wkJXQIFLdqvCSZaJEQ+AFNd8Klx/qDhrZy3DsCclTdg
	 ak3EWPx60O2wEkwx64Tusr9IVhMUYjzTzABO4BNb3NpCtvAPRMw6oOVt2ZCf/0vKg0
	 ax8wpE84teAiynzgh5qhdoPB/pvotSPplhc7tH6HqRV1JRXoVTylS8cxONfqDaBrEt
	 Qn6eL1OXQyiKh+Slm0KBMd+2L6nsHbNa9Rg33Auna5Y0I4fYnFM5JNschG9VYwoiUY
	 CHm0m+PpIQ9Ug==
Message-ID: <73963454-bb2d-48b8-9202-666fc2fc5ba7@kernel.org>
Date: Wed, 11 Oct 2023 18:53:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v14 3/7] mptcp: add __mptcp_subflow_disconnect
 helper
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1697031190.git.geliang.tang@suse.com>
 <e75487344cde69c5b754ee1fb3bd8c730d54e5de.1697031190.git.geliang.tang@suse.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <e75487344cde69c5b754ee1fb3bd8c730d54e5de.1697031190.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang, Paolo,

On 11/10/2023 15:34, Geliang Tang wrote:
> When closing the msk->first socket in __mptcp_close_ssk(), if there's
> another subflow available, it's better to avoid resetting it, just shut
> down it.
> 
> This patch adds a new helper __mptcp_subflow_disconnect(), and reuse
> flag MPTCP_CF_FASTCLOSE in this case. When MPTCP_CF_FASTCLOSE isn't set,
> we invoke tcp_shutdown() instead of tcp_disconnect().
> 
> Co-developed-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/protocol.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 30e0c29ae0a4..1a54d55f8bb2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2366,6 +2366,26 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
>  #define MPTCP_CF_PUSH		BIT(1)
>  #define MPTCP_CF_FASTCLOSE	BIT(2)
>  
> +/* be sure to send a reset only if the caller asked for it, also
> + * clean completely the subflow status when the subflow reaches
> + * TCP_CLOSE state
> + */
> +static void __mptcp_subflow_disconnect(struct sock *ssk,
> +				       struct mptcp_subflow_context *subflow,
> +				       unsigned int flags)
> +{
> +	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
> +	    (flags & MPTCP_CF_FASTCLOSE)) {
> +		/* The MPTCP code never wait on the subflow sockets, TCP-level
> +		 * disconnect should never fail
> +		 */
> +		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
> +		mptcp_subflow_ctx_reset(subflow);
> +	} else {
> +		tcp_shutdown(ssk, SEND_SHUTDOWN);

I didn't check in detail but should we not also call
__mptcp_subflow_error_report()?

And maybe other helpers? What is done between the 'goto out' and the
'out' label in __mptcp_close_ssk() here below? → what we do when other
subflows are being closed.

Cheers,
Matt

> +	}
> +}
> +
>  /* subflow sockets can be either outgoing (connect) or incoming
>   * (accept).
>   *
> @@ -2403,7 +2423,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
>  
>  	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
> -		/* be sure to force the tcp_disconnect() path,
> +		/* be sure to force the tcp_close path
>  		 * to generate the egress reset
>  		 */
>  		ssk->sk_lingertime = 0;
> @@ -2413,11 +2433,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  
>  	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
>  	if (!dispose_it) {
> -		/* The MPTCP code never wait on the subflow sockets, TCP-level
> -		 * disconnect should never fail
> -		 */
> -		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
> -		mptcp_subflow_ctx_reset(subflow);
> +		__mptcp_subflow_disconnect(ssk, subflow, flags);
>  		release_sock(ssk);
>  
>  		goto out;

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
