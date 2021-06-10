Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0A92F80
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 21:30:25 +0000 (UTC)
IronPort-SDR: lO4ioRO7zrWT5ZaoBBKUK1xNpwH07UmvEjM7prrizPcy/2jnF3LuScLeBs7BAuSeifKBu8jfKz
 8Pqnb1BJ/y2w==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="185098726"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="185098726"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 14:30:24 -0700
IronPort-SDR: BXiV00kt83+uuNElWuvxJM8ZlAb+VWIMKbW6w7V1RNytXfOqS0oBKxt6P4ipENwwBxpp5kWHvQ
 bAFhRgvd679w==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="486343783"
Received: from ngattu-mobl1.amr.corp.intel.com ([10.209.121.205])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 14:30:22 -0700
Date: Thu, 10 Jun 2021 14:30:20 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add deny_join_id0
 in mptcp_options_received"
In-Reply-To: <6670b769c9c6129d810282c3c8bd65e3317b1578.1623316231.git.geliangtang@gmail.com>
Message-ID: <bed4c37-75a3-8ed-fc45-baaae8b1d628@linux.intel.com>
References: <6670b769c9c6129d810282c3c8bd65e3317b1578.1623316231.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 10 Jun 2021, Geliang Tang wrote:

> Move the deny_join_id0 test into check_fully_established as Paolo
> suggested.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/options.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 0d30008f0313..63c1e18d61d5 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -910,6 +910,9 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 		return false;
> 	}
>
> +	if (mp_opt->deny_join_id0)
> +		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
> +
> 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
> 		pr_warn_once("bogus mpc option on established client sk");
> 	mptcp_subflow_fully_established(subflow, mp_opt);
> @@ -1051,8 +1054,6 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 	}
>
> 	mptcp_get_options(sk, skb, &mp_opt);
> -	if (mp_opt.deny_join_id0)
> -		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
> 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
> 		return;
>
> -- 
> 2.31.1

Looks good, thanks Geliang.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
