Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A87B
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 01:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645666921; x=1677202921;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eDoFckfxx6+Zm0CdIUDYgCr42nho2643msMbZd5x4N8=;
  b=MDSyL70FVEWSjaGH8Q2fCKiS+1qObXyYNszY4CY8Z2zzo+UtccdZQ98k
   CwRa7EtjDaO0kk/xT6WTnMTDZjxeUZkkcnf24cj6uIie4+Y2WnK7QTFgJ
   OJXL1nWU4Le7qrBuowGYw+3SXPFx8wuHj81tmUEJhCq19tKCSAIgLWr+v
   oLE9jNK60x14D6aYcCgBaf+L2yhTdodOIpKdftrWwqGe12C0b4l0bWOOX
   2v6KYzFXq8nMZ0hWQRVwZWyOEaJS+zgi5gX2rORPbi9OabnKYNrF5px6b
   KLdQjkp+rINg8aKqOdhCf8W2H73uyElt8ujnYKRbvuZoQNa3M2fZDXuva
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="338564408"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="338564408"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:42:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="508677486"
Received: from ortmgvpn37.amr.corp.intel.com ([10.212.237.95])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:42:00 -0800
Date: Wed, 23 Feb 2022 17:42:00 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [RFC mptcp-next v2 1/6] mptcp: add MP_FAIL echo support
In-Reply-To: <0abcf65bfd7c913a99d1027b865e5f087e31672c.1645096378.git.geliang.tang@suse.com>
Message-ID: <117bcca7-1cef-f3a5-f82f-e4ca5bf7f1d6@linux.intel.com>
References: <cover.1645096378.git.geliang.tang@suse.com> <0abcf65bfd7c913a99d1027b865e5f087e31672c.1645096378.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 17 Feb 2022, Geliang Tang wrote:

> Add MP_FAIL echo support.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm.c       | 10 ++++++++--
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  |  2 ++
> 3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d0d31d5c198a..dc0dffc1b6b5 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -279,8 +279,14 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>
> 	pr_debug("fail_seq=%llu", fail_seq);
>
> -	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallback))
> -		subflow->send_infinite_map = 1;
> +	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallback)) {
> +		if (!subflow->mp_fail_response_expect) {
> +			subflow->send_mp_fail = 1;
> +			subflow->send_infinite_map = 1;
> +		} else {
> +			subflow->mp_fail_response_expect = 0;

I'm not sure this should be cleared. If the peer retransmits MP_FAIL, we 
could receive MP_FAIL multiple times and we don't want to echo an MP_FAIL 
back.

-Mat

> +		}
> +	}
> }
>
> /* path manager helpers */
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 18ca0248c084..3c74b04fba6c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -448,6 +448,7 @@ struct mptcp_subflow_context {
> 		backup : 1,
> 		send_mp_prio : 1,
> 		send_mp_fail : 1,
> +		mp_fail_response_expect : 1,
> 		send_fastclose : 1,
> 		send_infinite_map : 1,
> 		rx_eof : 1,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 8d086641bdc5..f06d93fce1bb 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1172,6 +1172,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 				tcp_send_active_reset(ssk, GFP_ATOMIC);
> 				while ((skb = skb_peek(&ssk->sk_receive_queue)))
> 					sk_eat_skb(ssk, skb);
> +			} else {
> +				subflow->mp_fail_response_expect = 1;
> 			}
> 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
> 			return true;
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
