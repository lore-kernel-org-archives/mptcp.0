Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92FC89
	for <mptcp@lists.linux.dev>; Sat,  5 Mar 2022 00:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646440416; x=1677976416;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7i1W3UChJCnTSaj6CvLdUaApbns3RVY8pwBhaynt1lQ=;
  b=RDWekQO9FT25PTE2dAWNDdxxE7ZGZ64TmRP5dqgO7p7z+03mQ0o4ecuy
   x8GYlAcgfVyzSMTi8ORlKq8jizX4WjWAuAk+FebQc3+sMbB9cvCAP/I1c
   AmJldtEpXeBvHn2piVg8s51RPejoyrqDUgYnrQcZhDmuH3tbDcnx1+SHY
   h0+1bZpEheYzOShYevDUm4MpYSttzCeElTfKvswYkuiJ5vn4ivbhR3edq
   LV8BnAM+tUgZ6OxWaVePNFN+KYfD5TTW5fB4INsYQWfU7Me8qkLnvzdNS
   4vNxYMJcjS7l3GsLKx2GuoyLEMSaFDaBqptoSg9CtNS6Vk1Cn/dXKSRo3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="317328333"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="317328333"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 16:33:36 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="536461862"
Received: from iballa-mobl2.amr.corp.intel.com ([10.251.12.232])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 16:33:35 -0800
Date: Fri, 4 Mar 2022 16:33:35 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/2] mptcp: add MP_FAIL response support
In-Reply-To: <87d47204cb7b125d2089abb7dfcdada8b2ce1795.1646287286.git.geliang.tang@suse.com>
Message-ID: <9d991d11-82c8-4db3-be62-7fb5e2f1111a@linux.intel.com>
References: <cover.1646287286.git.geliang.tang@suse.com> <87d47204cb7b125d2089abb7dfcdada8b2ce1795.1646287286.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 3 Mar 2022, Geliang Tang wrote:

> This patch added a new struct member mp_fail_response_expect in struct
> mptcp_subflow_context to support MP_FAIL response. In the single subflow
> with checksum error and contiguous data special case, a MP_FAIL sent in
> response to another MP_FAIL.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm.c       | 11 +++++++++--
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  |  2 ++
> 3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d0d31d5c198a..c9080230b800 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -279,8 +279,15 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>
> 	pr_debug("fail_seq=%llu", fail_seq);
>
> -	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallback))
> -		subflow->send_infinite_map = 1;
> +	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallback)) {
> +		if (!subflow->mp_fail_response_expect) {
> +			subflow->send_mp_fail = 1;
> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
> +			subflow->send_infinite_map = 1;
> +		} else {
> +			subflow->mp_fail_response_expect = 0;

I don't think there's any need to clear this flag. Once the MP_FAIL 
response is received, this side is supposed to fall back and another 
incoming MP_FAIL would be strange to see. But if one somehow propagated 
here, it would be better to "expect" it by having the flag still set so no 
more MP_FAILs are sent in response. I mentioned this before in my RFCv2 
review - if you think this line of code should remain, please explain.

Thanks!

-Mat

> +		}
> +	}
> }
>
> /* path manager helpers */
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index c8bada4537e2..39aa22595add 100644
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
> index 30ffb00661bb..63a256a94b65 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1217,6 +1217,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
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
