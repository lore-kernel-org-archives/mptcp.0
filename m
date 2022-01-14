Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C32C80
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 22:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642200221; x=1673736221;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=r/58m/5KtvjiEfiCS6VtpeyzcTURZFc4lvMbiY8REik=;
  b=M8V6cbjqr47nUH73rgET7+0Af3fr21zCO1HY/uNwRmnCC0V/DNvXuhPv
   uyzO5Oxc5m+Ey225ck3nreS4IzSx3STmh2B22KrSaNBqbVFk1grQ3l6f3
   BNSJd/w7WiOGULYrO+jb1htCMU5+AAdGygZkFIr1emyCl4H2pWTL0rwoW
   9J141rgkgC5v+N+vhjmpx6vP6dafzMPSy+6kss3NVgukLvR37NClyyTmS
   aowOu8L+Nc2gP1E8yejyvTNUgC0NQCq5/OBeua8PaKpO8hr6m+Ch9Nofi
   AtvyUP9UNo3u/PDasq5nV6HaQX/k2iyrD6Gvf3elW54UzqBm2C92WbsiV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="231693216"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="231693216"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 14:43:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="491671626"
Received: from shajisur-mobl.amr.corp.intel.com ([10.209.76.214])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 14:43:41 -0800
Date: Fri, 14 Jan 2022 14:43:40 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 04/21] mptcp: establish subflows from either
 end of connection
In-Reply-To: <20220112221523.1829397-5-kishen.maloor@intel.com>
Message-ID: <83f91e9b-9c20-6e83-6442-41b87139f4eb@linux.intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com> <20220112221523.1829397-5-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 12 Jan 2022, Kishen Maloor wrote:

> This change updates internal logic to permit subflows to be
> established from either the client or server ends of MPTCP
> connections. This symmetry and added flexibility may be
> harnessed by PM implementations running on either end in
> creating new subflows.
>
> The essence of this change lies in not relying on the
> "server_side" flag (which continues to be available if needed).
>

After this patch, server_side is unused except for some debug output. If 
it's really no longer referenced (see below first), may be better to just 
remove it.

> v2: check for 3rd ACK retransmission only on passive side
> of the MPJ handshake
>
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> net/mptcp/options.c  | 2 +-
> net/mptcp/protocol.c | 5 +----
> net/mptcp/protocol.h | 2 --
> 3 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cceba8c7806d..89808816db06 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -921,7 +921,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 		if (TCP_SKB_CB(skb)->seq == subflow->ssn_offset + 1 &&
> 		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq &&
> 		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
> -		    READ_ONCE(msk->pm.server_side))
> +		    !subflow->request_join)
> 			tcp_send_ack(ssk);
> 		goto fully_established;
> 	}
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4012f844eec1..408a05bff633 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3248,15 +3248,12 @@ bool mptcp_finish_join(struct sock *ssk)
> 		return false;
> 	}
>
> -	if (!msk->pm.server_side)
> +	if (!list_empty(&subflow->node))
> 		goto out;
>
> 	if (!mptcp_pm_allow_new_subflow(msk))
> 		goto err_prohibited;
>
> -	if (WARN_ON_ONCE(!list_empty(&subflow->node)))
> -		goto err_prohibited;
> -
> 	/* active connections are already on conn_list.
> 	 * If we can't acquire msk socket lock here, let the release callback
> 	 * handle it
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index e2a67d3469f6..c50247673c7e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -908,10 +908,8 @@ static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
> static inline bool subflow_simultaneous_connect(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> -	struct sock *parent = subflow->conn;
>
> 	return sk->sk_state == TCP_ESTABLISHED &&
> -	       !mptcp_sk(parent)->pm.server_side &&
> 	       !subflow->conn_finished;
> }

Are changes in this function needed? This code was added to address
https://github.com/multipath-tcp/mptcp_net-next/issues/35
which was a weird case encountered with syzkaller where a socket tried to 
connect to itself, triggering the "simultaneous open" code path. It 
doesn't seem to be applicable to MP_JOINs.

--
Mat Martineau
Intel
