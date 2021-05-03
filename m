Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545771
	for <mptcp@lists.linux.dev>; Mon,  3 May 2021 19:04:21 +0000 (UTC)
IronPort-SDR: jBxJGsUGzedsjZ4/ZjOj4kdRHlu5uUvNOjTE86VFJbTNLnlsxxQ8g1pkrswH+PQKI9VPO2ls+F
 /MAwoMqrVYfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="283213749"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="283213749"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 12:04:20 -0700
IronPort-SDR: ELLNhIyA3tv5IKUyGgBHqguUfZ5LlIcpPZv0nXUAK+25VNTL97CcHegrRlDLzqbAe2SqCwHJyF
 OpXfkSlLbSKg==
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="462734140"
Received: from atshreve-mobl.amr.corp.intel.com ([10.251.29.232])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 12:04:20 -0700
Date: Mon, 3 May 2021 12:04:19 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] mptcp: fix splat when closing unaccepted socket
In-Reply-To: <20210503100224.22433-1-fw@strlen.de>
Message-ID: <5d40b9cc-991d-40f7-ba51-6a11dc3e705d@linux.intel.com>
References: <20210503100224.22433-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 3 May 2021, Florian Westphal wrote:

> From: Paolo Abeni <pabeni@redhat.com>
>
> If userspace exits before calling accept() on a listener that had at least
> one new connection ready, we get:
>
>   Attempt to release TCP socket in state 8
>
> This happens because the mptcp socket gets cloned when the TCP connection
> is ready, but the socket is never exposed to userspace.
>
> The client additionally sends a DATA_FIN, which brings connection into
> CLOSE_WAIT state.  This in turn prevents the orphan+state reset fixup
> in mptcp_sock_destruct() from doing its job.
>
> Fixes: 3721b9b64676b ("mptcp: Track received DATA_FIN sequence number and add related helpers")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/185
> Tested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/subflow.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 15620bafc544..01f30f8ea710 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -546,8 +546,7 @@ static void mptcp_sock_destruct(struct sock *sk)
> 	 * ESTABLISHED state and will not have the SOCK_DEAD flag.
> 	 * Both result in warnings from inet_sock_destruct.
> 	 */
> -
> -	if (sk->sk_state == TCP_ESTABLISHED) {
> +	if ((1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
> 		sk->sk_state = TCP_CLOSE;
> 		WARN_ON_ONCE(sk->sk_socket);
> 		sock_orphan(sk);
> -- 
> 2.26.3

Thanks Paolo and Florian. Patch looks good - should go to -net right?

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


--
Mat Martineau
Intel
