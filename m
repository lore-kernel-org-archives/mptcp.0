Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C876B2FB3
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 15:43:43 +0000 (UTC)
IronPort-SDR: r99L8XNLtVAEHAbPSKg8NU8Ze0uMObtG+DBF7mmeKfWg+QCyu4eYqbJatj2Q4n+TOvIPekf80R
 J4/azWQKbFkg==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="187381147"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="187381147"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 08:43:42 -0700
IronPort-SDR: y1/3pLM9hvJU5KGFfB1vRXEua69itMS/X3EO6CPr/jSwq5D+j3vXkIuLcjJGmZG1W/RKuEqW82
 odFII9K1LZ5A==
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="488228568"
Received: from vsampat1-mobl2.amr.corp.intel.com ([10.212.210.249])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 08:43:42 -0700
Date: Fri, 25 Jun 2021 08:43:42 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>, 
    Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH mptcp-next] mptcp: fix 'masking a bool' warning
In-Reply-To: <20210625115329.858684-1-matthieu.baerts@tessares.net>
Message-ID: <dfc2322-22bb-9380-4c7a-9ff1b66b8431@linux.intel.com>
References: <20210625115329.858684-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


On Fri, 25 Jun 2021, Matthieu Baerts wrote:

> Dan Carpenter reported an issue introduced in
> commit fde56eea01f9 ("mptcp: refine mptcp_cleanup_rbuf") where a new
> boolean (ack_pending) is masked with 0x9.
>
> This is not the intention to ignore values by using a boolean. This
> variable should have a 'bool' type but we should keep the 'u8' to allow
            ^^^^^^
         "should not" ??

> this comparison.
>
> Fixes: fde56eea01f9 ("mptcp: refine mptcp_cleanup_rbuf")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Thanks for catching this Dan!

I'll send to netdev today. Meanwhile, for the mptcp tree:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/protocol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ddce5b7bbefd..199a36fe4f69 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -455,7 +455,7 @@ static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)
> static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
> {
> 	const struct inet_connection_sock *icsk = inet_csk(ssk);
> -	bool ack_pending = READ_ONCE(icsk->icsk_ack.pending);
> +	u8 ack_pending = READ_ONCE(icsk->icsk_ack.pending);
> 	const struct tcp_sock *tp = tcp_sk(ssk);
>
> 	return (ack_pending & ICSK_ACK_SCHED) &&
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
