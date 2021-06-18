Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFCC173
	for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 20:59:08 +0000 (UTC)
IronPort-SDR: Mq9Ky+G8p7Wm4Und5qwutcaMEpfG/xAyOPkLaPLxQeJ0hqjkYTVUy/QbTHyKHtU7nj6hC9xCDz
 LkhR/6b/77kw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="292250021"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="292250021"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 13:58:52 -0700
IronPort-SDR: gwya5I9oIOljW8ypa61N9BuYOh6wsKhp9xh6QCPRqEPneVoFr2xYfT88/DAirFXECO8m+V9APl
 nWEwBb4Qzu3g==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="405394248"
Received: from rsurapan-mobl2.amr.corp.intel.com ([10.209.105.229])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 13:58:51 -0700
Date: Fri, 18 Jun 2021 13:58:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: drop duplicate mptcp_setsockopt()
 declaration
In-Reply-To: <c3038e2051a4b0a718e868b9129b5c6ecc682fef.1624038975.git.pabeni@redhat.com>
Message-ID: <c0c8623-72eb-1d0-f4d4-7a9229307a71@linux.intel.com>
References: <c3038e2051a4b0a718e868b9129b5c6ecc682fef.1624038975.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 18 Jun 2021, Paolo Abeni wrote:

> commit 7896248983ef ("mptcp: add skeleton to sync msk socket
> options to subflows") introduced a duplicate declaration of
> mptcp_setsockopt(), just drop it.
>
> Reported-by: Florian Westphal <fw@strlen.de>
> Fixes: 7896248983ef ("mptcp: add skeleton to sync msk socket options to subflows")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.h | 3 ---
> 1 file changed, 3 deletions(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 2480db50cbd2..fce3f34800ff 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -783,9 +783,6 @@ unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
> unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
> unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
>
> -int mptcp_setsockopt(struct sock *sk, int level, int optname,
> -		     sockptr_t optval, unsigned int optlen);
> -
> void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
> void mptcp_sockopt_sync_all(struct mptcp_sock *msk);
>
> -- 
> 2.26.3

Thanks Paolo.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
