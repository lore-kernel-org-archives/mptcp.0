Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC52570
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 00:03:49 +0000 (UTC)
IronPort-SDR: DJ9hrNiuWCnBpLRziTpmyAMY+3fbFiIqZKnl1YjXQwPEjDtZ8PHIisYNDNtacf+hgP0H8/eBG6
 4tx85RrYz1Uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="179245955"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="179245955"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 17:03:48 -0700
IronPort-SDR: vs/mC2YzdKVxkdGVwARALyTBWsZg0mrDfSqHhqFKZdnOVqlsxuNTY6rGQp7loHtZmfJG1IYseC
 z32My8eSASBw==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="527975347"
Received: from naldridg-mobl1.amr.corp.intel.com ([10.254.68.46])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 17:03:48 -0700
Date: Wed, 31 Mar 2021 17:03:48 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: lyl <liyonglong@chinatelecom.cn>
cc: mptcp@lists.linux.dev, mptcp@lists.01.org, matthieu.baerts@tessares.net, 
    fw@strlen.de, pabeni@redhat.com
Subject: Re: [PATCH] mptcp: ensure there is unacked data at all subflow
In-Reply-To: <1617181038-185283-1-git-send-email-liyonglong@chinatelecom.cn>
Message-ID: <c5a9ce9e-c0ca-40b7-bbc3-c7c07dcf388c@linux.intel.com>
References: <1617181038-185283-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


Hello! Thanks for your submission.

On Wed, 31 Mar 2021, lyl wrote:

> MPTCP-level retransmit may take place if first subflow
> without data in its write queue and second subflow is likely to
> have unacked data left in its write queue. In this condition data
> maybe double retransmited.
>
> Signed-off-by: lyl <liyonglong@chinatelecom.cn>

The certificate of origin requires a full name (not initials), so could 
you send a v2 with your full name spelled out? See the "Developer's 
Certificate of Origin" section in 
Documentation/process/submitting-patches.rst


> ---
> net/mptcp/protocol.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9d7e7e1..40a6703 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2072,6 +2072,7 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
> {
> 	struct mptcp_subflow_context *subflow;
> 	struct sock *backup = NULL;
> +	struct sock *idle = NULL;
>
> 	sock_owned_by_me((const struct sock *)msk);
>
> @@ -2097,10 +2098,10 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
> 			continue;
> 		}
>
> -		return ssk;
> +		idle = ssk;

To keep the scheduler behavior more like the existing code, can you try 
assigning to 'idle' only if it is NULL (has not been set to another ssk 
already)?

> 	}
>
> -	return backup;
> +	return idle ? : backup;
> }
>
> static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
> -- 
> 1.8.3.1

--
Mat Martineau
Intel
